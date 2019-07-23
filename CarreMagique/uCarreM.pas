{ ============================================
  Software Name : 	CarreMagique
  ============================================ }
{ ******************************************** }
{ Written By WalWalWalides                     }
{ CopyRight © 2019                             }
{ Email : WalWalWalides@gmail.com              }
{ GitHub :https://github.com/walwalwalides     }
{ ******************************************** }

unit uCarreM;


interface

const optionmask : array[1..5] of byte = (2,6,$e,$1e,$3e);
      grouplimit = 75;

type TnrType = (ntNone,ntOrg,ntPlay);
     TField = record
               nrType  : TnrType;
               nr      : byte;
               options : byte;
               groupNr : byte;
               grid    : byte;
               marked  : boolean;
              end;


var HSize : byte = 4;
    VSize : byte = 4;
    field : array[1..150] of TField;
    maxfield : byte = 150;
    maxGroup : byte;
    groupSize : array[1..grouplimit] of byte;
    groupMember : array[1..5,1..grouplimit] of byte;//fields of a group

function initGroups : byte;
procedure initOptions;
procedure clearFieldData(f : byte);
procedure clearDigit(f : byte);
procedure enterDigit(f,n : byte; tp : TNrType);
function testGameOK : word;
procedure recalcFieldOptions;
function checkEnd : boolean;
function GetBit1(m : byte) : byte;
procedure registerGroups;

implementation

//---low level-----------

function GetBit1(m : byte) : byte;
//return first bit set in m
var i : byte;
begin
 i := 1;
 while (i < 8) and (((1 shl i) and m) = 0) do inc(i);
 if (i < 8) then result := i else result := 0;
end;

function popcount(m : byte) : byte;
//count number of 1 bits in m
var i : byte;
begin
 result := 0;
 i := 2;
 repeat
  if (i and m) <> 0 then inc(result);
  i := i shl 1;
 until i = $40;
end;

procedure clearFieldData(f : byte);
begin
 with field[f] do
  begin
   groupNr := 0;
   nrType := ntNone;
   options := 0;
   nr := 0;
   marked := false;
  end;
end;

procedure fillGroup(f,grp : byte);
//start at field f, set grp group number
var game : array[1..150] of byte;       //holds search path
    i,hvsize,dir,c,r,field1 : byte;
    OK : boolean;
label nextfield,previousfield;
begin
 hvsize := HSize*Vsize;
 for i := 1 to HVSize do game[i] := 0;
 dir := 0; //direction code 0:right   1: left   2: up   3: down
 field1 := f;
 field[f].groupNr := grp;

nextfield:

 c := (f-1) mod Hsize + 1;
 r := (f-1) div Hsize + 1;
 case dir of
  0 : begin
       OK := (c < Hsize) and (field[f+1].groupNr = 0) and
             ((field[f].grid and 4) = 0);
       if OK then inc(f);
      end;
  1 : begin
       OK := (c > 1) and (field[f-1].groupNr = 0) and
             ((field[f].grid and 1) = 0);
       if OK then dec(f);
       end;
  2 : begin
       OK := (r > 1) and (field[f - HSize].groupNr = 0) and
             ((field[f].grid and 2) = 0);
       if OK then dec(f,HSize);
       end;
  3 : begin
       OK := (r < VSize) and (field[f + Hsize].groupNr = 0) and
             ((field[f].grid and 8) = 0);
       if OK then inc(f,HSize);
      end;
  else OK := false;
 end;//case
 if OK then
  begin
   game[f] := dir;
   field[f].groupNr := grp;
   if dir > 1 then dir := 0;      //continue left or start right
   goto nextfield;
  end
  else begin
        inc(dir);
        if dir = (game[f] xor 1) then inc(dir);
        if dir < 4 then goto nextfield;
       end;

previousfield:

 if f = field1 then exit;
//
 dir := game[f];
 case dir of
  0 : dec(f);
  1 : inc(f);
  2 : inc(f,HSize);
  3 : dec(f,HSize);
 end;//case
 inc(dir);
 if dir = (game[f] xor 1) then inc(dir);
 if dir > 3 then goto previousfield else goto nextfield;
end;

function initGroups : byte;
//set all groups in field
//result bits 6,7: code; bits 0..5:group
var maxfield,i,j,n,grSize : byte;
begin
 result := 0;
 maxGroup := 0;
 maxfield := HSize*VSize;
 for i := 1 to maxField do field[i].groupNr := 0;
 for i := 1 to 5 do
  for j := 1 to grouplimit do groupMember[i,j] := 0;
 for i := 1 to maxfield do
  if field[i].groupNr = 0 then
   begin
    inc(maxGroup);
    fillGroup(i,maxGroup);
   end;
//
 if maxgroup > grouplimit then result := $40;
//
 if result = 0 then
  begin
   for i := 1 to grouplimit do groupSize[i] := 0;
   for i := 1 to maxfield do
    begin
     n := field[i].groupNr;
     inc(groupsize[n]);
     grSize := groupSize[n];
     if grSize <= 5 then groupMember[grSize,n] := i;
    end;
   i := 0;
   repeat
    inc(i);
    if groupSize[i] > 5 then result := $80 + i;
   until (result <> 0) or (i = maxgroup);
  end;
end;

procedure initOptions;
var i,gs : byte;
begin
 for i := 1 to HSize*Vsize do
  with field[i] do
   begin
    gs := groupsize[groupNr];
    options := optionmask[gs];
   end;
end;

function checkEnd : boolean;
//return true if game is solved
var i,hvs : byte;
begin
 hvs := HSize*VSize;
 i := 0;
 repeat
  inc(i);
  result := field[i].nr <> 0;
 until (result=false) or (i=hvs);
end;

function neighbourfields(a,b : byte) : boolean;
var ca,ra,cb,rb : byte;
begin
 ca := (a-1) mod HSize;
 ra := (a-1) div HSize;
 cb := (b-1) mod HSize;
 rb := (b-1) div Hsize;
 result := (abs(ra-rb) <= 1) and (abs(ca-cb) <= 1);
end;

procedure dropFieldOption(f : byte);
//f must be field with number
//scan game for same groupor neighbour  and drop option
//call only if field f has number
var i,grp,msk : byte;
begin
 with field[f] do
  begin
   grp := groupNr;         //drop options in other members of group
   msk := (1 shl nr) xor $3e;        //0 bit
  end;
 for i := 1 to HSize*VSize do
  with field[i] do
   if (nr = 0) then
    if (grp = groupNr) or neighbourfields(i,f) then
     options := options and msk ;
end;

procedure recalcFieldOptions;
//recalculate options of all fields
//investigate same group and neighbours
//clear field f expected
var i,maxhv : byte;
begin
 maxhv := HSize*VSize;
 for i := 1 to maxhv do
  with field[i] do
   if nr = 0 then options := optionmask[groupsize[groupNr]]//full options
    else options := 1 shl nr;
 for i := 1 to maxhv do
  if field[i].nr > 0 then dropfieldoption(i);
end;

procedure registerGroups;
//called after loading game
//call if gameStatus is gmDigit,gmPlay,gmEnd,gmComp
var i,j,n : byte;
begin
 maxgroup := 0;
 for j := 1 to grouplimit do
  begin
   groupSize[j] := 0;
   for i := 1 to 5 do groupMember[i,j] := 0;
  end;
 for i := 1 to HSize*VSize do
  begin
   n := field[i].groupNr;
   inc(groupSize[n]);
   groupMember[groupSize[n],n] := i;
   if n > maxgroup then maxgroup := n;
  end;
end;

procedure clearDigit(f : byte);
begin
 with field[f] do
  begin
   nr := 0;
   nrType := ntNone;
  end;
 recalcfieldOptions;
end;

procedure enterDigit(f,n : byte; tp : TNrType);
//enter digit n in field f , tp is number type
var msk : byte;
begin
 msk := 1 shl n;
 with field[f] do
  if (options and msk) <> 0 then
   begin
    nrType := tp;
    nr := n;
    options := msk;
    dropFieldOption(f);
   end;
end;

function testGameOK : word;
var grpOptions : array[1..grouplimit] of byte;
    i,lastfield,msk : byte;
begin
 result := 0; //OK
 for i := 1 to maxgroup do grpOptions[i] := 0;
 i := 0;
 lastfield := HSize*VSize;
 repeat
  inc(i);
  with field[i] do
   if options = 0 then result := $4000 or i//set error (no options in field)
    else grpOptions[groupNr] := grpOptions[groupNr] or options;
 until (i = lastfield) or (result > 0);
 if result = 0 then
  begin
   i := 0;
   repeat                                  //test missing options in groups
    inc(i);
    msk := optionmask[groupSize[i]] and (grpOptions[i] xor $3e);
    if msk <>  0 then  result := $8000 or (msk shl 8) or i;
   until (result > 0) or (i = maxgroup);
  end; 
end;



end.

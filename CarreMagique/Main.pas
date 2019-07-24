{ ============================================
  Software Name : 	CarreMagique
  ============================================ }
{ ******************************************** }
{ Written By WalWalWalides }
{ CopyRight © 2019 }
{ Email : WalWalWalides@gmail.com }
{ GitHub :https://github.com/walwalwalides }
{ ******************************************** }
unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, shellApi, System.Actions, Vcl.ActnList, Vcl.Menus, Vcl.ComCtrls;

type
  TfrmMain = class(TForm)
    PaintBox1: TPaintBox;
    gridBtn: TSpeedButton;
    StaticText1: TStaticText;
    Label1: TLabel;
    StaticText2: TStaticText;
    Label2: TLabel;
    hplusBtn: TSpeedButton;
    hminBtn: TSpeedButton;
    vplusBtn: TSpeedButton;
    vminBtn: TSpeedButton;
    msglabel: TLabel;
    clearBtn: TBitBtn;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    solutionBtn: TSpeedButton;
    Timer1: TTimer;
    edtNumber: TEdit;
    GrBoxSolve: TGroupBox;
    GrBoxDimension: TGroupBox;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    OpenFiles1: TMenuItem;
    OpenFolders1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    Edit1: TMenuItem;
    CopytoClipboard1: TMenuItem;
    View1: TMenuItem;
    Refresh1: TMenuItem;
    A1: TMenuItem;
    C1: TMenuItem;
    miSolution: TMenuItem;
    Option1: TMenuItem;
    actOption1: TMenuItem;
    A2: TMenuItem;
    actAbout1: TMenuItem;
    ActionList1: TActionList;
    actClear: TAction;
    actSolution: TAction;
    actOpenFile: TAction;
    actShowInExplorer: TAction;
    actOpenFolder: TAction;
    actExit: TAction;
    actCopyToClipboard: TAction;
    actRefresh: TAction;
    actOption: TAction;
    actAbout: TAction;
    GrBoxIni: TGroupBox;
    procedure gridBtnClick(Sender: TObject);
    procedure PaintBox1Paint(Sender: TObject);
    procedure PaintBox1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure PaintBox1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure clearBtnClick(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure solutionBtnClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure hplusBtnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure hplusBtnMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure edtNumberKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtNumberChange(Sender: TObject);
    procedure actExitExecute(Sender: TObject);
    procedure actAboutExecute(Sender: TObject);
    procedure actClearExecute(Sender: TObject);
    procedure actSolutionExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TCarreMStatus = (gsGrid, gsSolution);

procedure setCarreMStatus(gs: TCarreMStatus);

var
  frmMain: TfrmMain;
  CarreMStatus: TCarreMStatus;

implementation

{$R *.dfm}

uses uCarreM, uAbout;

type
  TPaintMode = (pmNone, pmPaint, pmErase);
  TCarreMMessage = (gmGridBtn, gmSolutionBtn, gmClearBtn);

const
  fieldsize = 48; // square field size in pixels
  markcolor = $0000FF;
  formMessage = 'CarreMagique';
  gridmessage = 'Draw grid, enter a NUMBER and press SOLUTION';
  errormessage = 'The value of Number should be between 34 and 99';
  hop: array [1 .. 5] of byte = (5, 32, 20, 5, 32); // coordinate of options
  vop: array [1 .. 5] of byte = (5, 5, 16, 28, 28);
  Oprect: array [1 .. 5] of Trect = ((left: 4; top: 5; right: 15; bottom: 21), (left: 31; top: 5; right: 42; bottom: 21), (left: 19; top: 16; right: 30;
    bottom: 32), (left: 4; top: 28; right: 15; bottom: 44), (left: 31; top: 28; right: 43; bottom: 44));

var
  SolutionMark: boolean; // Solutionfields are marked
  marker: byte = 0;
  paintMode: TPaintMode;
  timercode: byte;
  oldOpt: byte;
  oldField: byte; // <> 0 if selection
  isolve: Integer;
  arrSolution: array [1 .. 16] of Integer;
  markercount: byte = 0;
  istart, iend: byte;

procedure clearMarker; forward;
procedure setMarker(n: byte); forward;

// field <---> (x,y)  conversion

procedure fieldNr2XY(var X, Y: smallInt; n: byte);
var
  row, col: byte;
begin
  col := (n - 1) mod HSize;
  row := (n - 1) div HSize;
  X := col * fieldsize;
  Y := row * fieldsize;
end;


// -- low level helpers

procedure EnableDimensionButtons(b: boolean);
begin
  with frmMain do
  begin
    hplusBtn.enabled := b;
    hminBtn.enabled := b;
    vplusBtn.enabled := b;
    vminBtn.enabled := b;
  end;
end;

procedure postmessage(s: string);
begin
  frmMain.msglabel.Caption := s;
end;

procedure showdimensions;
begin
  with frmMain do
  begin
    StaticText1.Caption := inttostr(HSize);
    StaticText2.Caption := inttostr(VSize);
  end;
end;

// --painting-----

procedure paintMarker(f: byte; switch: boolean);
// use markcolor if switch=true else white
var
  i: byte;
  X, Y, x1, y1, x2, y2: smallInt;
begin
  fieldNr2XY(X, Y, f);
  x1 := X + 2;
  y1 := Y + 2;
  x2 := x1 + fieldsize - 4;
  y2 := y1 + fieldsize - 4;
  with frmMain.PaintBox1.Canvas do
  begin
    pen.Width := 1;
    if switch then
      pen.color := markcolor
    else
      pen.color := $FFFFFF;
    for i := 0 to 2 do
    begin
      moveto(x1 + i, y1 + i);
      lineto(x1 + i, y2 - i);
      lineto(x2 - i, y2 - i);
      lineto(x2 - i, y1 + i);
      lineto(x1 + i, y1 + i);
    end;
  end;
end;

procedure paintline(f: byte; switch: boolean);
// use markcolor if switch=true else white
var
  i: byte;
  X, Y, x1, y1, x2, y2: smallInt;
  boolDraw: boolean;
begin
  boolDraw := ((istart=1)and(f = 4)) or ((istart=1)and(f = 13)) or ((istart=5)and(f = 8)) or ((istart=9)and(f = 12)) or ((istart=1)and(f = 16))
  or ((istart=2)and(f = 14))or ((istart=3)and(f = 15))  or ((istart=4)and(f = 13))or ((istart=4)and(f = 16));
  if boolDraw=False then exit;

  fieldNr2XY(X, Y, f);
  x1 := X + 2;
  y1 := Y + 2;
  x2 := x1 + fieldsize - 4;
  y2 := y1 + fieldsize - 4;
  with frmMain.PaintBox1.Canvas do
  begin
    pen.Width := 1;
    if switch then
      pen.color := $0000FF
    else
      pen.color := $FFFFFF;
    for i := 0 to 0 do
    begin
      moveto(x1 + i, y1 + i);

      case istart of
        1 .. 4:
          y2 := 1;
        5 .. 8:
          y2 := 2;
        9 .. 12:
          y2 := 3;
        13 .. 16:
          y2 := 4;

      end;
      lineto(48 * istart, 48 * y2);
      // lineto(x1 + i, y2 - i);
      // lineto(x2 - i, y2 - i);
      // lineto(x2 - i, y1 + i);
      // lineto(x1 + i, y1 + i);
    end;
  end;
end;

procedure paintEmptyField(f: byte);
var
  X, Y: smallInt;
  r: Trect;
begin
  fieldNr2XY(X, Y, f);
  r.left := X + 2;
  r.top := Y + 2;
  r.right := X + fieldsize - 1;
  r.bottom := Y + fieldsize - 1;
  with frmMain.PaintBox1.Canvas do
  begin
    brush.color := $FFFFFF;
    brush.Style := bsSolid;
    fillrect(r);

  end;
  if f = marker then
    paintMarker(f, true);

end;

procedure paintFieldEdges(f: byte);
var
  X, Y, x1, y1, x2, y2: smallInt;
begin
  fieldNr2XY(X, Y, f);
  with frmMain.PaintBox1.Canvas do
  begin
    pen.Width := 1;
    x1 := X + 1;
    y1 := Y + 1;
    x2 := X + fieldsize - 1;
    y2 := Y + fieldsize - 1;
    pen.color := $FFFFFF; // erase edges
    moveto(x1, y1);
    lineto(x1, y2);
    lineto(x2, y2);
    lineto(x2, y1);
    lineto(x1, y1);
    pen.color := $000000; // paint edge if grid bit is set
    with field[f] do
    begin
      if (grid and 1) <> 0 then
      begin
        moveto(x1, y1);
        lineto(x1, y2 + 1);
      end;
      if (grid and 2) <> 0 then
      begin
        moveto(x1, y1);
        lineto(x2 + 1, y1);
      end;
      if (grid and 4) <> 0 then
      begin
        moveto(x2, y1);
        lineto(x2, y2 + 1);
      end;
      if (grid and 8) <> 0 then
      begin
        moveto(x1, y2);
        lineto(x2 + 1, y2);
      end;
    end; // with
  end; // with
end;

procedure paintgameGrid;
// paint the grid
var
  i: byte;
begin
  with frmMain.PaintBox1 do
    with Canvas do
    begin
      brush.color := $FFFFFF;
      brush.Style := bsSolid;
      fillrect(rect(0, 0, Width, height));
      pen.Width := 1;
      pen.color := $000000;
      for i := 0 to HSize do
      begin
        moveto(i * fieldsize, 0);
        lineto(i * fieldsize, height);
      end;
      for i := 0 to VSize do
      begin
        moveto(0, i * fieldsize);
        lineto(Width, i * fieldsize);
      end;
    end;
end;

procedure paintfieldNr(f: byte);
var
  X, Y: smallInt;
  ch: Char;
begin
  fieldNr2XY(X, Y, f);
  with frmMain.PaintBox1.Canvas do
  begin
    font.name := 'arial';
    font.Style := [];
    font.height := 32;
    brush.Style := bsClear;
    with field[f] do
    begin
      case nrType of
        ntOrg:
          font.color := $000080;
        ntPlay:
          font.color := $000000;
        ntNone:
          font.color := $FFFFFF;
      end;
      ch := chr(ord('0') + field[f].nr);
      textout(X + 16, Y + 8, ch); // ch
    end;
  end;
  if marker = f then
    paintMarker(f, true);
end;

procedure paintfieldOptions(f: byte);
var
  X, Y: smallInt;
  i: byte;
  ch: Char;
begin
  fieldNr2XY(X, Y, f);
  with frmMain.PaintBox1.Canvas do
  begin
    font.name := 'arial';
    font.height := 16;
    font.color := $808080;
    brush.Style := bsClear;
    for i := 1 to 5 do
    begin
      if (field[f].options and (1 shl i)) <> 0 then
      begin
        ch := chr(ord('0') + i);
        textout(X + hop[i], Y + vop[i], ch);
      end;
    end;
  end;
  if f = marker then
    paintMarker(f, true);
end;

function getTemplate(f: byte): Integer;
var
  isol: Integer;
begin
  isol := 0;
  if (isolve >= 34) then
  begin
    isol := isolve - 34;
    case f of
      1:
        begin
          result := 1 + isol;
          arrSolution[1] := result;
        end;

      2:
        Begin
          result := 16;
          arrSolution[2] := result;
        End;
      3:
        Begin
          result := 10;
          arrSolution[3] := result;
        End;
      4:
        Begin
          result := 7;
          arrSolution[4] := result;
        End;
      5:
        Begin
          result := 6;
          arrSolution[5] := result;
        End;
      6:
        Begin
          result := 11;
          arrSolution[6] := result;
        End;
      7:
        Begin
          result := 13;
          arrSolution[7] := result;
        End;
      8:
        Begin
          result := 4 + isol;
          arrSolution[8] := result;
        End;
      9:
        Begin
          result := 15;
          arrSolution[9] := result;
        End;
      10:
        Begin
          result := 2 + isol;
          arrSolution[10] := result;
        End;
      11:
        Begin
          result := 8;
          arrSolution[11] := result;
        End;

      12:
        Begin
          result := 9;
          arrSolution[12] := result;
        End;
      13:
        Begin
          result := 12;
          arrSolution[13] := result;
        End;
      14:
        Begin
          result := 5;
          arrSolution[14] := result;
        End;
      15:
        Begin
          result := 3 + isol;
          arrSolution[15] := result;
        End;
      16:
        Begin
          result := 14;
          arrSolution[16] := result;
        End;
    end;
  end;

end;

procedure paintSolutionField(f: byte);
// set field error marker
// set general SolutionMark
var
  X, Y: smallInt;
  d: byte;
  iNb: Integer;
  k: Integer;
begin
  fieldNr2XY(X, Y, f);
  inc(X, 5);
  inc(Y, 5);
  d := fieldsize - 10;
  with frmMain.PaintBox1.Canvas do
  begin
    pen.Width := 1;
    pen.color := $0000FF;

    ellipse(X, Y, X + d, Y + d);
    font.Size := 15;

    iNb := getTemplate(f);
    if length(iNb.ToString) > 1 then
      k := 8
    else
    begin
      k := 16;
    end;

    textout(X + k, Y + 8, iNb.ToString);
  end;
  field[f].marked := true;
  SolutionMark := true;
end;

procedure paintSolutionGroup(grp: byte);
var
  i: byte;
begin
  for i := 1 to HSize * VSize do
    with field[i] do
      if groupNr = grp then
        paintSolutionField(i);
end;

procedure paintField(f: byte);
begin
  paintEmptyField(f);
  if field[f].nr <> 0 then
    paintfieldNr(f)
  else if (CarreMStatus <> gsGrid) then
    paintfieldOptions(f);
  if field[f].marked then
    paintSolutionField(f);
end;

procedure repaintFields;
var
  i: byte;
begin
  for i := 1 to HSize * VSize do
    paintField(i);
end;

procedure paintEdgeData(f, m: byte);
// set,clear edge bits m of field f
// check paintmode
// helper of setEdge procedure
var
  amask: byte;
begin
  if paintMode = pmErase then
  begin
    amask := m xor $F;
    m := 0;
  end
  else
    amask := $F;
  field[f].grid := (field[f].grid and amask) or m;
  paintFieldEdges(f);
end;

procedure paintformEdges(col: TColor);
// 1 pixel wide edge around paintbox1
var
  x1, y1, x2, y2: Word;
begin
  with frmMain.PaintBox1 do
  begin
    x1 := left - 1;
    y1 := top - 1;
    x2 := left + Width;
    y2 := top + height;
  end;
  with frmMain.Canvas do
  begin
    pen.color := col;
    pen.Width := 1;
    moveto(x2, y1);
    lineto(x1, y1);
    lineto(x1, y2);
    lineto(x2, y2);
    lineto(x2, y1);
  end;
end;


// low level control

procedure clearMarker;
begin
  if marker <> 0 then
  begin
    paintMarker(marker, False);
    marker := 0;
  end;
end;

procedure setMarker(n: byte);
begin

  if (markercount = 2) then
  begin
    marker := istart;
    paintline(iend, False);
    clearMarker;
    marker := iend;
    clearMarker;

    markercount := 0;
    exit;
  end;

  if n <> 0 then
  begin
    if (markercount = 1) then
      paintline(n, true);

    paintMarker(n, true);
    marker := n;
    inc(markercount);
  end;

end;

procedure advanceMarker;
var
  n: byte;
begin
  n := marker + 1;
  if n > HSize * VSize then
    n := 1;
  setMarker(n);
end;

procedure initGridEdges;
// grid bits:   0:left 1: top 2: 3: bottom
var
  i, hv, lb, f: byte;
begin
  hv := HSize * VSize;
  lb := hv - HSize;
  for i := 1 to hv do
    field[i].grid := 0;
  for i := 1 to HSize do
  begin
    field[i].grid := 2;
    field[i + lb].grid := 8;
  end;
  for i := 1 to VSize do
  begin
    f := (i - 1) * HSize + 1;
    field[f].grid := field[f].grid or 1;
    f := f + HSize - 1;
    field[f].grid := field[f].grid or 4;
  end;
end;

procedure clearSolutionFields;
// removes eror marks from fields
// resets SolutionMark
var
  i: byte;
begin
  for i := 1 to HSize * VSize do
    with field[i] do
      if marked then
      begin
        marked := False;
        paintField(i);
      end;
  SolutionMark := False;
end;

procedure setPaintbox1Dimensions;
// set width , height
begin
  with frmMain do
  begin
    paintformEdges(Canvas.brush.color); // erase old edges
    with PaintBox1 do
    begin
      Width := HSize * fieldsize + 1;
      height := VSize * fieldsize + 1;
      left := 8 + (15 * fieldsize - Width) div 2;
      top := 120 + (10 * fieldsize - height) div 2;
    end;
    PaintBox1.Invalidate;
    paintformEdges(clBlack);
  end; // with frmMain
end;



// -- central game control helpers

function builtGroups: boolean;
// initiate groups
// return true if OK, else post message
var
  m: byte;
begin
  result := False;
  if SolutionMark then
  begin
    repaintFields;
    SolutionMark := False;
  end;
  m := initGroups;
  case m shr 6 of
    0:
      begin
        result := true;
        initOptions;
        repaintFields;
      end;
    1:
      postmessage('error: too many groups');
    2:
      begin
        postmessage('Solution Of Number : ' + frmMain.edtNumber.Text);
        paintSolutionGroup(m and $3F);
      end;
  end; // case
end;

procedure clearGameDigits(nt: TNrType);
var
  i: byte;
begin
  for i := 1 to HSize * VSize do
    with field[i] do
    begin
      if nr = 0 then
        options := optionmask[groupSize[groupNr]];
      if nrType = nt then
      begin
        nr := 0;
        nrType := ntNone;
        marked := False;
        options := optionmask[groupSize[groupNr]];
      end;
    end;
end;

procedure ClearCM;
var
  i: byte;
begin

  for i := 1 to HSize * VSize do
    with field[i] do
    begin
      nr := 0;
      nrType := ntNone;
      groupNr := 0;
      marked := False;
      options := 0;
    end;
end;

// --- main control ---

procedure setCarreMStatus(gs: TCarreMStatus);
var
  s: string;
begin
  CarreMStatus := gs;
  with frmMain do
    case gs of
      gsGrid:
        begin
          clearMarker;
          frmMain.Caption := formMessage;
          msglabel.Caption := gridmessage;
          gridBtn.Down := true;
          EnableDimensionButtons(true);
        end;
      gsSolution:
        begin
          setMarker(1);
          frmMain.Caption := formMessage;
          msglabel.Caption := gridmessage;
          solutionBtn.Down := true;
          EnableDimensionButtons(False);
        end;
    end; // case
end;

procedure CarreMControl(gm: TCarreMMessage);
// button messages arrive here
begin
  case gm of
    gmGridBtn:
      begin
        ClearCM;
        repaintFields;
        setCarreMStatus(gsGrid);

      end;
    gmSolutionBtn:
      case CarreMStatus of
        gsGrid:
          begin
            if SolutionMark then
              clearSolutionFields;
            if builtGroups then
            begin
              setCarreMStatus(gsSolution);
              repaintFields;
            end
            else
              frmMain.gridBtn.Down := true;
          end;

      end; // case
    gmClearBtn:
      begin
        if SolutionMark then
        begin
          clearSolutionFields;
          setCarreMStatus(CarreMStatus);
          exit;
        end; // restore message
        case CarreMStatus of
          gsGrid:
            begin
              initGridEdges;
              frmMain.PaintBox1.Invalidate;
              SolutionMark := False;
              postmessage('');
            end;
          gsSolution:
            begin
              clearGameDigits(ntOrg);
              clearGameDigits(ntPlay);
              recalcfieldoptions;
              repaintFields;
            end;
        end; // case
      end;
  end; // case
end;

procedure processDelete;
// delete key pressed
begin
  if marker = 0 then
    exit;
  //
  if SolutionMark then
    clearSolutionFields;
  case CarreMStatus of
    gsGrid, gsSolution:
      begin
        clearDigit(marker);
        repaintFields;
      end;
  end; // case
end;

procedure addOrgNumber(fld, nr: byte);
// common code to  enter org game digit
begin
  enterdigit(fld, nr, ntOrg);
  repaintFields;
end;



// mouse events

procedure TfrmMain.PaintBox1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  col, row, xmod, ymod: byte;
  center: boolean;

  iposArr: Integer;
  iSum: Integer;
  i: Integer;
  boolSimple: boolean;
begin

  with frmMain.PaintBox1 do
    if (X < 10) or (X > Width - 10) or (Y < 10) or (Y > height - 10) then
      exit;
  //
  col := X div fieldsize;
  row := Y div fieldsize;
  xmod := X mod fieldsize;
  ymod := Y mod fieldsize;
  center := (xmod > 15) and (xmod < fieldsize - 15) and (ymod > 15) and (ymod < fieldsize - 15);
  //
  case Button of
    mbLeft:
      case CarreMStatus of
        gsGrid:
          paintMode := pmPaint;
        gsSolution:
          if oldField = 0 then
          begin
            // if center then
            setMarker(1 + col + row * HSize);
            case row of
              0:
                iposArr := 1 + col + row;

              1:
                iposArr := 4 + col + row;

              2:
                iposArr := 7 + col + row;

              3:
                iposArr := 10 + col + row;

            end;

            if (markercount = 0) then
            begin
              iSum := 0;
            end;

            if (markercount = 1) then
            begin
              istart := iposArr;
              iend := iposArr;
              iSum := 0;
            end;
            if (markercount = 2) then
            begin
              iend := iposArr;
              iSum := 0;
            end;

            boolSimple := ((istart = 1) and (iend = 4)) or ((istart = 1) and (iend = 13)) or ((istart = 5) and (iend = 8)) or ((istart = 9) and (iend = 12)) or
              ((istart = 4) and (iend = 13)) or ((istart = 13) and (iend = 16)) or ((istart = 2) and (iend = 14)) or ((istart = 3) and (iend = 15)) or
              ((istart = 4) and (iend = 16)) or ((istart = 1) and (iend = 16));

            if (boolSimple = true) then
            begin
              if (iend - istart = 3) then
              begin
                for i := istart to iend do
                Begin
                  iSum := iSum + arrSolution[i];
                End;
              end
              else if (iend - istart = 12) then
              begin
                for i := istart to iend do
                Begin
                  if (i mod 4 = istart mod 4) then
                    iSum := iSum + arrSolution[i];
                End;

              end
              else if (iend - istart = 15) then
              begin
                for i := istart to iend do
                Begin
                  if (i mod 5 = istart mod 5) then
                    iSum := iSum + arrSolution[i];
                End;

              end
              else if (iend - istart = 9) then
              begin
                for i := istart to iend do
                Begin
                  if (i mod 3 = istart mod 3) then
                    iSum := iSum + arrSolution[i];
                End;

              end;

              msglabel.Caption := iSum.ToString;
            end
            else
              msglabel.Caption := arrSolution[iend].ToString;

          end
          else
            addOrgNumber(oldField, oldOpt);

      end; // case
    mbRight:
      case CarreMStatus of
        gsGrid:
          paintMode := pmErase;
        gsSolution:
          ;

      end; // case
  end; // case
  oldField := 0;
  oldOpt := 0;
end;

procedure TfrmMain.PaintBox1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  paintMode := pmNone;
end;

// keyboard events

procedure TfrmMain.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  maxmarker, n: byte;
begin
  // activecontrol := nil;

  maxmarker := HSize * VSize;
  n := marker;
  if n > 0 then
  begin
    case Key of
      VK_LEFT, VK_BACK:
        if n > 1 then
          dec(n);
      VK_RIGHT, VK_SPACE:
        if n < maxmarker then
          inc(n);
      VK_UP:
        if n > HSize then
          dec(n, HSize);
      VK_DOWN:
        if n <= maxmarker - HSize then
          inc(n, HSize);
      VK_DELETE:
        processDelete;
    end; // case
    setMarker(n);
  end; // if n > 0
end;

procedure TfrmMain.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key in ['1' .. '5'] then
    if (marker > 0) then
    begin

      case CarreMStatus of
        gsSolution:
          addOrgNumber(marker, strtoint(Key));
      end; // case
    end; // if
end;

// button & timer events

procedure TfrmMain.Timer1Timer(Sender: TObject);
// for quick paintbox1 resizing
begin
  paintformEdges(frmMain.Canvas.brush.color);
  case timercode of
    1:
      if HSize < 15 then
        inc(HSize);
    2:
      if HSize > 4 then
        dec(HSize);
    3:
      if VSize < 10 then
        inc(VSize);
    4:
      if VSize > 4 then
        dec(VSize);
  end; // case
  showdimensions;
  initGridEdges;
  setPaintbox1Dimensions;
end;

procedure TfrmMain.hplusBtnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  postmessage('');
  if (CarreMStatus = gsGrid) then
  begin
    timercode := TSpeedButton(Sender).Tag;
    Timer1Timer(self);
    Timer1.enabled := true;
  end;
end;

procedure TfrmMain.hplusBtnMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Timer1.enabled := False;
end;

procedure TfrmMain.gridBtnClick(Sender: TObject);
begin

  //

end;

procedure TfrmMain.solutionBtnClick(Sender: TObject);
begin

  isolve := strtoint(edtNumber.Text);
  if ((HSize = 4) and (VSize = 4) and (isolve >= 34)) then
  begin
    // CarreMControl(gmGridBtn);
    CarreMControl(gmSolutionBtn);
    CarreMStatus := gsSolution;
  end
  else
  begin
    if (isolve < 34) then
      msglabel.Caption := errormessage;

  end;
end;

procedure TfrmMain.edtNumberChange(Sender: TObject);
begin
  solutionBtn.enabled := (length(edtNumber.Text) > 1);
  miSolution.enabled := (length(edtNumber.Text) > 1);
end;

procedure TfrmMain.edtNumberKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  // SolutionBtn.enabled := (length(edtNumber.text) > 0);
end;

procedure TfrmMain.clearBtnClick(Sender: TObject);
begin
  // activecontrol := nil;
  // CarreMControl(gmClearBtn);
  CarreMControl(gmGridBtn);
  setPaintbox1Dimensions;

end;

procedure TfrmMain.actAboutExecute(Sender: TObject);
var
  f: TfrmAbout;
begin

  if not Assigned(f) then
    Application.CreateForm(TfrmAbout, f);
  f.Position := poMainFormCenter;
  try
    f.ShowModal;
  finally
    FreeAndNil(f);
  end;
end;

procedure TfrmMain.actClearExecute(Sender: TObject);
begin
  //
  CarreMControl(gmGridBtn);
end;

procedure TfrmMain.actExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TfrmMain.actSolutionExecute(Sender: TObject);
begin
  //
  isolve := strtoint(edtNumber.Text);
  CarreMControl(gmSolutionBtn);

end;

procedure TfrmMain.CheckBox1Click(Sender: TObject);
begin
  activecontrol := nil;
  if CarreMStatus <> gsGrid then
    repaintFields;
end;



// frmMain paints

procedure TfrmMain.PaintBox1Paint(Sender: TObject);
var
  i: byte;
begin
  paintformEdges($000000); // on frmMain.canvas
  paintgameGrid;
  for i := 1 to HSize * VSize do
  begin
    paintFieldEdges(i);
    paintField(i);
  end;
  if marker <> 0 then
    paintMarker(marker, true);
end;

// -- create --

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  edtNumber.Clear;
  edtNumber.NumbersOnly := true;
  solutionBtn.enabled := False;

  HSize := 4;
  VSize := 4;
  showdimensions;
  setPaintbox1Dimensions;

  setCarreMStatus(gsGrid);
  initGridEdges;
  ClearCM;
  activecontrol := nil;
end;

end.

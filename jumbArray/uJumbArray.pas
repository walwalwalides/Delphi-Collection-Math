{ ============================================
  Software Name : 	JumbArray
  ============================================ }
{ ******************************************** }
{ Written By WalWalWalides                     }
{ CopyRight © 2020                             }
{ Email : WalWalWalides@gmail.com              }
{ GitHub :https://github.com/walwalwalides     }
{ ******************************************** }
unit uJumbArray;

interface

uses classes, forms, dialogs, controls, sysutils, stdctrls;

type

  TJumbArray = record
  type
    TJbArray = array of integer;
  Public
    procedure DisplayArrayResult(arr: TJbArray; lblDisplay: TLabel);
    function InsertValue(iarr: array of integer): TJbArray;
    function CanJumb(arr: TJbArray): boolean;
    function countWaysToJump(arr: TJbArray): TJbArray;
    function minJumpsToReachTillEnd(arr: TJbArray): integer;

  end;

implementation

uses
  System.Math;

{ TJbArray }

function TJumbArray.minJumpsToReachTillEnd(arr: TJbArray): integer;
var
  i, j, len: integer;
  minJumps: TJbArray;
Begin
  len := length(arr);
  SetLength(minJumps, len);

  if (len = 0) then
  Begin
    result := -1;

  End;

  for i := 0 to len - 1 do
  Begin
    minJumps[i] := MaxInt;
  End;

  minJumps[0] := 0;

  for i := 0 to len - 2 do
  Begin
    j := i + 1;
    while ((j <= i + arr[i]) and (j < len)) do
    Begin
      minJumps[j] := min(minJumps[j], 1 + minJumps[i]);
      inc(j);
    End;
  End;

  result := minJumps[len - 1];

end;

procedure TJumbArray.DisplayArrayResult(arr: TJbArray; lblDisplay: TLabel);
var
  i: integer;
  s: string;
begin
  lblDisplay.Alignment := taCenter;
  lblDisplay.caption := '';
  lblDisplay.Font.Size := 15;

  for i := 0 to length(arr) - 1 do
  begin
    s := s + ' | ' + inttostr(arr[i]);
  end;
  if not(s.IsEmpty) then
  begin
    s := s + ' | ';
    lblDisplay.caption := s;
  end;
end;

function TJumbArray.InsertValue(iarr: array of integer): TJbArray;
var
  i, n: integer;
begin
  n := length(iarr);
  SetLength(result, n);
  for i := Low(iarr) to High(iarr) do
    result[i] := iarr[i];
end;

function TJumbArray.countWaysToJump(arr: TJbArray): TJbArray;
var
  count_jump: TJbArray;
  n: integer;
  i, j: integer;
Begin
  // Time Complexity : O(n²)
  n := length(arr);
  SetLength(count_jump, n);

  for i := (n - 2) downto 0 do
  Begin
    if (arr[i] >= n - i - 1) then
      count_jump[i] := count_jump[i] + 1;

    j := i + 1;
    while ((j < n - 1) and (j <= arr[i] + i)) do
    Begin
      if (count_jump[j] <> -1) then
        count_jump[i] := count_jump[i] + count_jump[j];
      j := j + 1;
    End;

    if (count_jump[i] = 0) then
      count_jump[i] := -1

  End;

  result := count_jump;

End;

function TJumbArray.CanJumb(arr: TJbArray): boolean;
var
  len, i, Max: integer;
Begin
  len := length(arr);
  Max := arr[0];
  if len <= 1 then
    result := true;

  for i := 0 to len - 1 do
  Begin
    if ((Max <= i) and (arr[i] = 0)) then
    Begin
      result := false;
      Break;
    End;

    if ((i + arr[i]) > Max) then
      Max := arr[i] + i;

    // reach the end of the array
    if (Max >= len) then
    Begin
      result := true;
      exit;
    End;

  End;
  result := false;

end;

end.

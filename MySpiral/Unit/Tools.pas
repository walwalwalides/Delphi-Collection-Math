unit Tools;

interface

uses
  System.SysUtils, System.Math,Vcl.ExtCtrls;

type
  TMatrix = array of array of Integer;

   procedure spiralPrint(m, n: Integer; A: TMatrix;var AText:TPanel);
   function checkMatrix(A: TMatrix): Boolean;

implementation

procedure PrintMatrix(const A: TMatrix);

var
  i, j: Integer;
begin
  for i := 0 to Length(A) - 1 do
  begin
    for j := 0 to Length(A[0]) - 1 do
      Write(Format('%3d', [A[i, j]]));
    Writeln;
  end;
end;

function checkMatrix(A: TMatrix): Boolean;
var
  prevLen: Integer;
Begin

  if Length(A) > 0 then
  Begin
    prevLen := 0;
    var
    k := 0;
    for var i in A do
    Begin

      if (prevLen = 0) then
      begin
        prevLen := Length(i);
        Result := true;
      end
      else if (prevLen = Length(i)) then
        Result := true
      else
        Result := False;
      inc(k);
    End;

    if (prevLen <> k) then
      Result := False;

  End
  else
    Result := False;
End;

procedure spiralPrint(m, n: Integer; A: TMatrix;var AText:TPanel);

var
  i, k, l: Integer;
begin
  i := 0;
  k := 0;
  l := 0;

  while ((k < m) and (l < n)) do
  Begin
    for i := l to n - 1 do
    begin
      AText.Caption:=AText.Caption+Format('%d', [A[k][i]]);
      if ((i < n) and (l < n - 1)) then
        AText.Caption:=AText.Caption+'-';
    end;
    inc(k);

    for i := k to m - 1 do
    Begin
      AText.Caption:=AText.Caption+Format('%d', [A[i][n - 1]]);
      if ((i < m) and (l < n - 1)) then
        AText.Caption:=AText.Caption+'-';

    End;

    dec(n);

    if (k < m) then
    Begin
      for i := n - 1 downto l do
      Begin
        AText.Caption:=AText.Caption+Format('%d', [A[m - 1][i]]);
        if ((i >= l) and (l < n - 1)) then
          AText.Caption:=AText.Caption+'-';
      End;
      dec(m);

    end;

    if (l < n) then
    begin
      for i := m - 1 downto k do
      Begin
        AText.Caption:=AText.Caption+Format('%d', [A[i][l]]);
        if ((i >= k) and (l < n - 1)) then
          AText.Caption:=AText.Caption+'-';
      End;

      inc(l);

    end;

  End;

end;

end.

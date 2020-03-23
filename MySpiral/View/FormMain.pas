{ ============================================
  Software Name : 	StudNote
  ============================================ }
{ ******************************************** }
{ Written By WalWalWalides }
{ CopyRight © 2019 }
{ Email : WalWalWalides@gmail.com }
{ GitHub :https://github.com/walwalwalides }
{ ******************************************** }
unit FormMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, ExtCtrls, Vcl.Buttons, Vcl.Menus;

const
  iniFile = 'Data\';
  iniName = 'MySpiral.ini';

type
  TSpiralData = record
    iColumn1: Integer;
    iColumn2: Integer;
    iColumn3: Integer;
    iColumn4: Integer;

  end;

  TMainForm = class(TForm)
    edtColumn1: TEdit;
    edtColumn2: TEdit;
    edtColumn3: TEdit;
    edtColumn4: TEdit;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    StaticText3: TStaticText;
    StaticText4: TStaticText;
    StringGrid: TStringGrid;
    pnlResult: TPanel;
    GrBoxNote: TGroupBox;
    GrBoxControle: TGroupBox;
    bvlHead: TBevel;
    bvlFeet: TBevel;
    AddButton: TBitBtn;
    DelButton: TBitBtn;
    MainMenu: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    BalloonHint: TBalloonHint;
    A1: TMenuItem;
    I1: TMenuItem;
    BitBtnEdit: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure AddButtonClick(Sender: TObject);
    procedure DelButtonClick(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnClick(Sender: TObject);
    procedure StringGridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure StringGridMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure I1Click(Sender: TObject);
    procedure BitBtnChartClick(Sender: TObject);
    procedure edtColumn1Change(Sender: TObject);
    procedure edtColumn2Change(Sender: TObject);
    procedure edtColumn3Change(Sender: TObject);
    procedure edtColumn4Change(Sender: TObject);
    procedure BitBtnEditClick(Sender: TObject);
  private
    fSpiralArr: array of TSpiralData;

    procedure AddRow(aColumn1, aColumn2, aColumn3, aColumn4: Integer);
    procedure RemoveRow(aName: Integer);
    procedure DoOutput(aArrIndex, aName: Integer);
    procedure writeIniDatei;
    procedure LoadIniDatei;
    procedure ShowCellHint(X, Y: Integer);
    function ADDpermisition: boolean;
    procedure EditNumber(aName: Integer);

    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

uses
  System.IniFiles, AboutSN, Tools;

{$R *.dfm}

var
  iniFolder, iniPath: String;
  Bitmap1, Bitmap2, Bitmap3: TBitmap;
  LastRow, LastCol, iactLine: Integer;
  AColLastCol, ARowLastRow: boolean;
  Spiral: TMatrix;
  m, n: Integer;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  MainForm.KeyPreview := True;
  // ------------------------------------  //

  edtColumn1.NumbersOnly := True;
  edtColumn2.NumbersOnly := True;
  edtColumn3.NumbersOnly := True;
  edtColumn4.NumbersOnly := True;

  AddButton.Enabled := False;

  iniFolder := ExtractFilePath(Application.ExeName) + iniFile;
  ForceDirectories(iniFolder);
  iniPath := iniFolder + iniName;

  // SetLength(fSpiralArr, 0);
  StringGrid.Cells[0, 0] := 'Column 1';
  StringGrid.Cells[1, 0] := 'Column 2';
  StringGrid.Cells[2, 0] := 'Column 3';
  StringGrid.Cells[3, 0] := 'Column 4';
  LoadIniDatei;

end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  writeIniDatei;
end;

procedure TMainForm.edtColumn2Change(Sender: TObject);
begin
  AddButton.Enabled := ADDpermisition;
end;

procedure TMainForm.I1Click(Sender: TObject);
begin
  frmAboutSN.Show;
end;

procedure TMainForm.N2Click(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.edtColumn1Change(Sender: TObject);
begin
  AddButton.Enabled := ADDpermisition;
end;

procedure TMainForm.AddButtonClick(Sender: TObject);
begin
  AddRow(StrToInt(edtColumn1.Text), StrToInt(edtColumn2.Text),
    StrToInt(edtColumn3.Text), StrToInt(edtColumn4.Text));
  AddButton.Enabled := False;
end;

procedure TMainForm.AddRow(aColumn1, aColumn2, aColumn3, aColumn4: Integer);
var
  aIndex, i: Integer;
begin
  aIndex := -1;
  for i := 0 to Length(fSpiralArr) - 1 do
  begin
    if (fSpiralArr[i].iColumn1 = aColumn1) then
    begin
      aIndex := 0;
      Break;
    end;
  end;
  if aIndex < 0 then
  begin
    aIndex := Length(fSpiralArr);
    SetLength(fSpiralArr, aIndex + 1);
  end;

  fSpiralArr[aIndex].iColumn1 := aColumn1;
  fSpiralArr[aIndex].iColumn2 := aColumn2;
  fSpiralArr[aIndex].iColumn3 := aColumn3;
  fSpiralArr[aIndex].iColumn4 := aColumn4;

  Spiral[aIndex, 0] := aColumn1;
  Spiral[aIndex, 1] := aColumn2;
  Spiral[aIndex, 2] := aColumn3;
  Spiral[aIndex, 3] := aColumn4;

  DoOutput(aIndex, aColumn1);
end;

function TMainForm.ADDpermisition: boolean;
begin
  result := ((Length(edtColumn1.Text) > 0) and (Length(edtColumn2.Text) > 0) and
    (Length(edtColumn3.Text) > 0) and (Length(edtColumn4.Text) > 0));
end;

procedure TMainForm.BitBtnChartClick(Sender: TObject);
begin
  //

end;

procedure TMainForm.BitBtnEditClick(Sender: TObject);
var
  Ycol: Integer;
  studentName: string;
begin
  // if AddButton.Enabled then
  // begin
  // AddButtonClick(nil);
  // exit;
  // end;

  Ycol := StringGrid.Selection.BottomRight.Y;
  if (Ycol > -1) then
  begin
    studentName := StringGrid.Cells[0, Ycol];

    EditNumber(StrToInt(studentName));

  end;
end;

procedure TMainForm.btnClick(Sender: TObject);
begin
  ShowMessage(StringGrid.Cells[0, 1]);
end;

procedure TMainForm.RemoveRow(aName: Integer);
var
  i, aIndex, aArrLeng: Integer;
begin
  aArrLeng := Length(fSpiralArr);
  aIndex := -1;
  for i := 0 to aArrLeng - 1 do
  begin
    if fSpiralArr[i].iColumn1 = aName then
    begin
      aIndex := i;
      Break;
    end;
  end;
  if aIndex >= 0 then
  begin
    fSpiralArr[aIndex] := fSpiralArr[aArrLeng - 1];
    SetLength(fSpiralArr, aArrLeng - 1);
    DoOutput(-1, aName);
  end;
end;

procedure TMainForm.EditNumber(aName: Integer);
var
  i, aIndex, aArrLeng: Integer;
begin
  aArrLeng := Length(fSpiralArr);
  aIndex := -1;
  for i := 0 to aArrLeng - 1 do
  begin
    if fSpiralArr[i].iColumn1 = aName then
    begin
      aIndex := i;
      Break;
    end;
  end;
  if aIndex >= 0 then
  begin
    edtColumn1.Text := (aName).ToString;
    edtColumn2.Text := (fSpiralArr[aIndex].iColumn2).ToString;
    edtColumn3.Text := (fSpiralArr[aIndex].iColumn3).ToString;
    edtColumn4.Text := (fSpiralArr[aIndex].iColumn4).ToString;

    DoOutput(aIndex, aName);
  end;
end;

procedure TMainForm.StringGridDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
  AGrid: TStringGrid;
  CellLeftMargin, CellTopMargin: Integer;
begin

  AGrid := TStringGrid(Sender);
  if (ARow = 0) then
  Begin
    StringGrid.Canvas.Font.Style := [fsBold];
    AGrid.Canvas.Brush.Color := clBtnFace
  End;
  if (ARow = 1) then
  Begin
    StringGrid.Canvas.Font.Style := [fsBold];
    AGrid.Canvas.Brush.Color := clred;
    AGrid.Canvas.FillRect(Rect);

  End;
  if (ARow = 2) then
  Begin
    StringGrid.Canvas.Font.Style := [fsBold];
    AGrid.Canvas.Brush.Color := clGreen;
    AGrid.Canvas.FillRect(Rect);
  End;

  if (ARow = 3) then
  Begin
    StringGrid.Canvas.Font.Style := [fsBold];
    AGrid.Canvas.Brush.Color := clBtnShadow;
    AGrid.Canvas.FillRect(Rect);
  End;

  if (ARow = 4) then
  Begin
    StringGrid.Canvas.Font.Style := [fsBold];
    AGrid.Canvas.Brush.Color := clred;
    AGrid.Canvas.FillRect(Rect);
  End;

  if (ACol = 3) and (ARow <> 4) and (ARow <> 1) and (ARow <> 0) then
  Begin
    StringGrid.Canvas.Font.Style := [fsBold];
    AGrid.Canvas.Brush.Color := clBlue;
    AGrid.Canvas.FillRect(Rect);
  End;

  if (ACol = 0) and (ARow <> 4) and (ARow <> 1) and (ARow <> 0) then
  Begin
    StringGrid.Canvas.Font.Style := [fsBold];
    AGrid.Canvas.Brush.Color := clBlue;
    AGrid.Canvas.FillRect(Rect);
  End;

  if gdFixed in State then // if is fixed use the clBtnFace color
    AGrid.Canvas.Brush.Color := clBtnFace
  else if gdSelected in State then // if is selected use the clAqua color
    AGrid.Canvas.Brush.Color := clAqua
  else
    AGrid.Canvas.Brush.Color := clWindow;
  // if is not selected use the clwindow color

  // AGrid.Canvas.FillRect(Rect);
  AGrid.Canvas.TextOut(Rect.Left + 2, Rect.Top + 2, AGrid.Cells[ACol, ARow]);

end;

procedure TMainForm.StringGridMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin

  ShowCellHint(X, Y);
end;

{
  Show Cell Hint
}
procedure TMainForm.ShowCellHint(X, Y: Integer);
var
  ACol, ARow: Integer;
begin
  if StringGrid.ShowHint = False then
    StringGrid.ShowHint := True;
  StringGrid.MouseToCell(X, Y, ACol, ARow);
  if (ACol > -1) and (ARow > -1) then
    StringGrid.Hint := StringGrid.Cells[ACol, ARow];
  // if (AColLastCol) or (ARowLastRow) then
  // begin
  // Application.CancelHint;
  // LastCol:=ACol;
  // LastRow:=ARow;
  // end;
end;

procedure TMainForm.DelButtonClick(Sender: TObject);
begin
  if (edtColumn1.Text<>'')then

  RemoveRow(StrToInt(edtColumn1.Text));
  edtColumn1.Clear;
  edtColumn2.Clear;
  edtColumn3.Clear;
  edtColumn4.Clear;

end;

procedure TMainForm.DoOutput(aArrIndex, aName: Integer);
var
  i, aGridIndex: Integer;

  row, col, dx, dy, dirChanges, visits, temp: Integer;

begin
  aGridIndex := -1;

  if (aArrIndex < 0) then
  begin
    for i := 1 to StringGrid.RowCount - 1 do
    begin
      if StringGrid.Cells[0, i] = (aName).ToString then
      begin
        aGridIndex := i;
        Break;
      end;
    end;
    if aGridIndex < -1 then
      exit
    else
    begin
      for i := aGridIndex to StringGrid.RowCount - 1 do
      begin
        StringGrid.Cells[0, i] := StringGrid.Cells[0, i + 1];
        StringGrid.Cells[1, i] := StringGrid.Cells[1, i + 1];
        StringGrid.Cells[2, i] := StringGrid.Cells[2, i + 1];
        StringGrid.Cells[3, i] := StringGrid.Cells[3, i + 1];

      end;
      if (StringGrid.RowCount<3) then
      StringGrid.RowCount := StringGrid.RowCount - 1;
    end;
  end
  else
  begin
    for i := 1 to StringGrid.RowCount - 1 do
    begin
      if StringGrid.Cells[0, i] = (aName).ToString then
      begin
        aGridIndex := i;
        Break;
      end;
    end;
    if aGridIndex < 0 then
    begin
      if StringGrid.Cells[0, 1] = '' then
        aGridIndex := 1
      else
      begin
        StringGrid.RowCount := StringGrid.RowCount + 1;
        aGridIndex := StringGrid.RowCount - 1;
      end;
    end;
    StringGrid.Cells[0, aGridIndex] := IntToStr(fSpiralArr[aArrIndex].iColumn1);
    StringGrid.Cells[1, aGridIndex] := IntToStr(fSpiralArr[aArrIndex].iColumn2);
    StringGrid.Cells[2, aGridIndex] := IntToStr(fSpiralArr[aArrIndex].iColumn3);
    StringGrid.Cells[3, aGridIndex] := IntToStr(fSpiralArr[aArrIndex].iColumn4);

  end;

  row := 0;
  col := 0;
  dx := 1;
  dy := 0;
  dirChanges := 0;
  visits := m;
  // for i := 0 to n * m - 1 do
  // begin
  //
  // Spiral[row, col] := i;
  // dec(visits);
  // if visits = 0 then
  // begin
  // visits := m * (dirChanges mod 2) + n * ((dirChanges + 1) mod 2) -
  // (dirChanges div 2) - 1;
  // temp := dx;
  // dx := -dy;
  // dy := temp;
  // inc(dirChanges);
  // end;
  // inc(col, dx);
  // inc(row, dy);
  // end;
  if checkMatrix(Spiral) then
  Begin
    // PrintMatrix(Spiral);
    pnlResult.caption := '';
    spiralPrint(m, n, Spiral, pnlResult);
  end
  else
    pnlResult.caption := 'not valid matrix';

end;

procedure TMainForm.edtColumn3Change(Sender: TObject);
begin
  AddButton.Enabled := ADDpermisition;
end;

procedure TMainForm.writeIniDatei;
var
  sIniDatei: TIniFile;
  i: Integer;
  idiff: Integer;
begin
  sIniDatei := TIniFile.Create(iniPath);

  for i := 1 to StringGrid.RowCount do
  begin
    if (StringGrid.Cells[0, i] <> '') then
    begin
      sIniDatei.WriteString('Row n°' + i.ToString, 'Column 1',
        StringGrid.Cells[0, i]);
      sIniDatei.WriteString('Row n°' + i.ToString, 'Column 2',
        StringGrid.Cells[1, i]);
      sIniDatei.WriteString('Row n°' + i.ToString, 'Column 3',
        StringGrid.Cells[2, i]);
      sIniDatei.WriteString('Row n°' + i.ToString, 'Column 4',
        StringGrid.Cells[3, i]);
    end;

  end;
  if (iactLine > StringGrid.RowCount) then
  Begin
    idiff := StringGrid.RowCount - iactLine;

    for i := StringGrid.RowCount to iactLine do
    Begin
      sIniDatei.WriteString('Row n°' + i.ToString, 'Column 1', '');
      sIniDatei.WriteString('Row n°' + i.ToString, 'Column 2', '');
      sIniDatei.WriteString('Row n°' + i.ToString, 'Column 3', '');
      sIniDatei.WriteString('Row n°' + i.ToString, 'Column 4', '');

    End;
  End;

  sIniDatei.Free;
end;

procedure TMainForm.LoadIniDatei;
var
  sIniDatei: TIniFile;
  ANote0: string;
  ANote1: string;
  ANote2: string;
  ANote3: string;
  i: Integer;
  oSL: TStringlist;
  iline: Integer;

begin
  if not FileExists(iniPath) then
    exit;

  oSL := TStringlist.Create;
  try
    oSL.LoadFromFile(iniPath);
    iline := oSL.Count div 4
  finally
    oSL.Free;
  end;
  if (iline <= 0) then
    exit;

  sIniDatei := TIniFile.Create(iniPath);
  m := 4; // columns
  n := 4; // rows
  SetLength(Spiral, n, m);
  for i := 1 to iline do
  begin

    ANote0 := sIniDatei.ReadString('Row n°' + i.ToString, 'Column 1', '');
    ANote1 := sIniDatei.ReadString('Row n°' + i.ToString, 'Column 2', '');
    ANote2 := sIniDatei.ReadString('Row n°' + i.ToString, 'Column 3', '');
    ANote3 := sIniDatei.ReadString('Row n°' + i.ToString, 'Column 4', '');
    if ((ANote0 <> '') and (ANote1 <> '') and (ANote2 <> '') and (ANote3 <> ''))
    then
      AddRow(StrToInt(ANote0), StrToInt(ANote1), StrToInt(ANote2),
        StrToInt(ANote3));

  end;

  iactLine := iline;
  sIniDatei.Free;
end;

procedure TMainForm.edtColumn4Change(Sender: TObject);
begin
  AddButton.Enabled := ADDpermisition;
end;

end.

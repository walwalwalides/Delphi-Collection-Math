{ ============================================
  Software Name : 	Researcher
  ============================================ }
{ ******************************************** }
{ Written By WalWalWalides }
{ CopyRight © 2020 }
{ Email : WalWalWalides@gmail.com }
{ GitHub :https://github.com/walwalwalides }
{ ******************************************** }
unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, uRecordPerson,
  uClassPerson,
  Vcl.Menus;

type
  TForm1 = class(TForm)
    edtInput: TEdit;
    btnResult: TButton;
    lstboxResult: TListBox;
    lblName: TLabel;
    lblAge: TLabel;
    lblProfession: TLabel;
    lbltitelName: TLabel;
    lbltitelAge: TLabel;
    lbltitelProfession: TLabel;
    MainMenu: TMainMenu;
    miS: TMenuItem;
    N2: TMenuItem;
    miA: TMenuItem;
    I1: TMenuItem;
    miD: TMenuItem;
    DAllName: TMenuItem;
    A2: TMenuItem;
    miF: TMenuItem;
    FiOld: TMenuItem;
    FiYoung: TMenuItem;
    miO: TMenuItem;
    Ocs: TMenuItem;
    ONcs: TMenuItem;
    procedure btnResultClick(Sender: TObject);
    procedure edtInputKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure edtInputKeyPress(Sender: TObject; var Key: Char);
    procedure lstboxResultDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure edtInputChange(Sender: TObject);
    procedure lstboxResultClick(Sender: TObject);
    procedure I1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure DAllNameClick(Sender: TObject);
    procedure FiOldClick(Sender: TObject);
    procedure FiYoungClick(Sender: TObject);
    procedure ONcsClick(Sender: TObject);
    procedure OcsClick(Sender: TObject);
  private
    procedure SearchInListBox;
    procedure ClearDetailInfo;
    function ReturnIndex(AArray: TArrayRecord<TPersonRecord>;
      const AName: string): Integer;
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;
  BoolFound: Boolean = false;
  BoolCaseSensitive: Boolean = false;
  arrInput: TArrayRecord<TPersonRecord>;

implementation

uses
  System.Math, About;

{$R *.dfm}

function lcs(a, b: string): string; // dynamic programming
var
  x, y: string;
  lenga, lengb: Integer;
begin
  lenga := length(a);
  lengb := length(b);
  lcs := '';
  if (lenga > 0) and (lengb > 0) then
    if a[lenga] = b[lengb] then
      lcs := lcs(copy(a, 1, lenga - 1), copy(b, 1, lengb - 1)) + a[lenga]
    else
    begin
      x := lcs(a, copy(b, 1, lengb - 1));
      y := lcs(copy(a, 1, lenga - 1), b);
      if length(x) > length(y) then
        lcs := x
      else
        lcs := y;
    end;
end;

function ReadFile(const FileName: string): string;
var
  Strings: TStringList;
  I, iAge: Integer;
  sProfession, sName: string;
  sInput: string;
  StringsSplit: TStringList;
  t: Integer;

  procedure Split(const Delimiter: Char; sInput: string;
    ListOfStrings: TStrings);
  begin
    ListOfStrings.Clear;
    ListOfStrings.Delimiter := Delimiter;
    ListOfStrings.StrictDelimiter := True; // Requires D2006 or newer.
    ListOfStrings.DelimitedText := sInput;

  end;

begin
  // arrInput:=Tarray<string>.create('walid');
  arrInput.Clear;

  Strings := TStringList.Create;
  StringsSplit := TStringList.Create;
  try
    Strings.LoadFromFile(FileName);
    t := Strings.Count div 2;
    for I := 0 to t - 1 do
    Begin
      sInput := Strings[I];

      StringsSplit.Clear;

      Split(',', sInput, StringsSplit);

      sName := StringsSplit[0];
      iAge := strtoint(StringsSplit[1]);
      sProfession := StringsSplit[2];
      arrInput.Add(TPersonRecord.Create(sName, iAge, sProfession));

    End;

    Result := Strings.Text;
  finally
    FreeAndNil(StringsSplit);
    FreeAndNil(Strings);
  end;
end;

procedure TForm1.SearchInListBox;
var
  sX, sY, sResult, stmp: string;
  I, m, n, iresult, itmp, iIndex: Integer;

  sl: TStringList;
begin
  BoolFound := false;
  if (edtInput.Text <> '') then
  Begin
    if BoolCaseSensitive = false then
      sX := lowercase(edtInput.Text)
    else
      sX := edtInput.Text;
  End
  else
    exit;
  sl := TStringList.Create;

  if (arrInput.Count = 0) then
    exit;

  itmp := 0;
  sResult := '';
  for I := 0 to arrInput.Count - 1 do
  Begin
    if BoolCaseSensitive = false then
      sY := lowercase(arrInput[I].Name) // extract name from list library
    else
      sY := arrInput[I].Name;

    m := length(sX);
    n := length(sY);
    stmp := lcs(sX, sY);
    iresult := stmp.length;
    if ((iresult >= itmp) and (iresult <> 0)) then
    begin
      itmp := iresult;
      sl.Add(arrInput[I].Name);
      if (iresult = m) and (iresult = n) then // found searching name
      Begin
        iIndex := ReturnIndex(arrInput, stmp);
        sResult := arrInput[iIndex].Name;
        break

      End;

    end;
  End;

  // Display the result
  lstboxResult.Clear;
  ClearDetailInfo;
  try
    if (sResult.isempty) then
    Begin
      if (sl.Count > 0) then
        lstboxResult.Items.Assign(sl)
      else
        lstboxResult.Items.Add('No results found !');

    End
    else
    Begin
      BoolFound := True;
      lstboxResult.Items.Add(sResult);
    End;
  finally
    FreeAndNil(sl);
  end;

end;

procedure TForm1.btnResultClick(Sender: TObject);
begin
  //
end;

procedure TForm1.edtInputChange(Sender: TObject);
begin
  if (edtInput.Text = '') then
  Begin
    lstboxResult.Clear;
    ClearDetailInfo;
  End
  else
    SearchInListBox;
end;

procedure TForm1.edtInputKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = 13) then
  Begin
    btnResultClick(nil);

  End;
  Key := 0;
end;

procedure TForm1.edtInputKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
  Begin

    Key := #0;
  End;
end;

procedure TForm1.FormCreate(Sender: TObject);
const
  cfLibrary = 'myLibrary.txt';
begin
  self.Position := poMainFormCenter;
  self.Color := clwhite;
  lstboxResult.Style := lbOwnerDrawFixed;
  if FileExists(cfLibrary) then
    ReadFile(cfLibrary);
  lstboxResult.Sorted := True;

  ClearDetailInfo;

end;

procedure TForm1.I1Click(Sender: TObject);
begin
  frmAbout.show;
end;

function CompareItemFunction(const Value: string): Boolean;
begin
  Result := lowercase(Value) <> '';
end;

function TForm1.ReturnIndex(AArray: TArrayRecord<TPersonRecord>;
  const AName: string): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to (AArray.Count - 1) do
  Begin
    if (lowercase(AArray[I].Name) = lowercase(AName)) then
    Begin
      Result := I;
      break;
    End;
  End;
end;

procedure TForm1.lstboxResultClick(Sender: TObject);
var
  I, iIndex: Integer;
  sName: String;
begin

  with lstboxResult do
  Begin
    if ItemIndex < 0 then
      exit;
    lblName.caption := Items[ItemIndex];
    sName := lblName.caption;
    iIndex := ReturnIndex(arrInput, sName);
    lblAge.caption := arrInput[iIndex].Age.ToString;
    lblProfession.caption := arrInput[iIndex].Profession;
  End;
end;

procedure TForm1.lstboxResultDrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
var
  TopDif: Integer;
begin

  with (Control as TListBox) do
  begin
    if (BoolFound = True) then
    // es sollen nur das Item verändert werden, dass der Eingabe entspricht!
    begin
      Canvas.Brush.Color := clwhite; // Background
      Canvas.Font.Color := clGreen; // Schriftfarbe
      Canvas.Font.Style := [fsBold];

      TopDif := (ItemHeight div 2) - (Canvas.TextHeight(#32) div 2);
      Canvas.TextRect(Rect, Rect.Left, Rect.Top + TopDif, Items[Index]);
    end
    else
    begin
      Canvas.Brush.Color := clwhite; // Background
      Canvas.Font.Color := clBlack; // Schriftfarbe
      Canvas.Font.Style := [fsBold];

      TopDif := (ItemHeight div 2) - (Canvas.TextHeight(#32) div 2);
      Canvas.TextRect(Rect, Rect.Left, Rect.Top + TopDif, Items[Index]);

    end;
  end;

end;

procedure TForm1.N2Click(Sender: TObject);
begin
  application.Terminate;
end;

procedure TForm1.OcsClick(Sender: TObject);
begin
  BoolCaseSensitive := True;
end;

procedure TForm1.ONcsClick(Sender: TObject);
begin
  BoolCaseSensitive := false;
end;

procedure TForm1.DAllNameClick(Sender: TObject);
{ TODO : Display all Name in listbox }
var
  sX: string;
  I: Integer;
  sl: TStringList;
begin
  // sort the list before display
  BoolFound := false;
  edtInput.Clear;
  arrInput.Sort(TPersonRecord.NameComparer);

  sl := TStringList.Create;

  if (arrInput.Count = 0) then
    exit;

  for I := 0 to arrInput.Count - 1 do
  Begin
    sX := arrInput[I].Name;
    if (sX <> '') then
    begin
      sl.Add(sX);
    End;

  end;

  // Display the result
  lstboxResult.Clear;
  ClearDetailInfo;
  try

    if (sl.Count > 0) then
      lstboxResult.Items.Assign(sl)
    else
      lstboxResult.Items.Add('List Empty !');

  finally
    FreeAndNil(sl);
  end;

End;

procedure TForm1.FiOldClick(Sender: TObject);
var
  iOld: Integer;
begin
  //
  arrInput.Sort(TPersonRecord.AgeComparer);
  iOld := arrInput.IndexOfMax(TPersonRecord.AgeComparer);
  lstboxResult.Clear;
  ClearDetailInfo;
  try

    if (arrInput.Count > 0) then
    Begin
      lstboxResult.Items.Add(arrInput[iOld].Name);
      lstboxResult.SetFocus;

    End;

  finally
    //

    if lstboxResult.Items.Count > 0 then
    begin
      lstboxResult.Selected[0] := True;
      lstboxResult.ItemIndex := 0;
      lstboxResultClick(nil);

    end;
  end;

end;

procedure TForm1.ClearDetailInfo;
begin
  lblName.caption := '----';
  lblAge.caption := '----';
  lblProfession.caption := '----';
end;

procedure TForm1.FiYoungClick(Sender: TObject);
var
  iMin: Integer;
begin
  //
  arrInput.Sort(TPersonRecord.AgeComparer);
  iMin := arrInput.IndexOfMin(TPersonRecord.AgeComparer);
  lstboxResult.Clear;
  ClearDetailInfo;
  try

    if (arrInput.Count > 0) then
    Begin
      lstboxResult.Items.Add(arrInput[iMin].Name);
      lstboxResult.SetFocus;

    End;

  finally
    //

    if lstboxResult.Items.Count > 0 then
    begin
      lstboxResult.Selected[0] := True;
      lstboxResult.ItemIndex := 0;
      lstboxResultClick(nil);

    end;
  end;

end;

end.

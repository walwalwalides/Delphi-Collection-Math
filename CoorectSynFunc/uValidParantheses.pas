{ ============================================
  Software Name : 	ValidParentheses
  ============================================ }
{ ******************************************** }
{ Written By WalWalWalides }
{ CopyRight © 2020 }
{ Email : WalWalWalides@gmail.com }
{ GitHub :https://github.com/walwalwalides }
{ ******************************************** }
unit uValidParantheses;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  System.generics.collections, System.ImageList, Vcl.ImgList, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.Menus;

type
  TAnwser = record
    BoolAn: Boolean;
    PositionAn: integer;
    CharError: char;
  end;

  TfrmValidParantheses = class(TForm)
    btnTest: TButton;
    edtInput: TEdit;
    lblExpresion: TLabel;
    pnlFunction: TPanel;
    ImgLst: TImageList;
    statbar: TStatusBar;
    imgStatus: TImage;
    Bevel1: TBevel;
    MainMenu: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    A1: TMenuItem;
    I1: TMenuItem;
    procedure btnTestClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtInputChange(Sender: TObject);
    procedure statbarDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect);
    procedure I1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
  private
    function isBalancedExp(exp: string): TAnwser;
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  frmValidParantheses: TfrmValidParantheses;

implementation

uses
  System.StrUtils, AboutSN;

{$R *.dfm}

var
  sInformation: string;
  clInformation: TColor;

function PlusChar(const S: string; const C: char): integer;
var
  i: integer;
begin
  result := -1;
  for i := 1 to Length(S) do
  Begin
    if S[i] = C then
      if (S[i + 1] in ['0' .. '9']) or ((S[i + 1] = '(') or (S[i + 1] = '[') or
        (S[i + 1] = '{')) then
      Begin
        result := -1;
      End
      else
      Begin
        result := i;
        break;
      End;
  end;

end;

function TfrmValidParantheses.isBalancedExp(exp: string): TAnwser;
var
  Stk: TStack<string>;
  x,x1: char;
  i: integer;
  len, s1, s2: integer;
  b1, b2, b3: Boolean;
  res: TAnwser;
  stmp: string;
  boolfound, boolCondition: Boolean;
Begin
  exp := trim(exp);

  Stk := TStack<String>.Create;
  len := Length(exp);

  for i := 0 to len - 1 do
  Begin
    if ((exp[i] = '(') or (exp[i] = '[') or (exp[i] = '{')) then
    Begin
      Stk.push(exp[i]);
      continue;

    End;

    if (Stk.Count = 0) then
    Begin
      res.BoolAn := false;
      res.PositionAn := 0;
      result := res;
    End;

    case (exp[i]) of

      ')':
        Begin
          if Stk.Count > 0 then
          Begin
            stmp := Stk.peek;
            x := stmp[1];
            Stk.pop;

            if ((x = '{') or (x = '[')) then
            Begin
              res.BoolAn := false;
              res.PositionAn := i;
              result := res;
              break;
            End;
          End
          else
          Begin
            res.BoolAn := false;
            res.PositionAn := i;
            result := res;
            break;
          End;

        End;

      '}':
        Begin
          if Stk.Count > 0 then
          Begin

            stmp := Stk.peek;
            x := stmp[1];
            Stk.pop;
            if ((x = '(') or (x = '[')) then
            Begin
              res.BoolAn := false;
              res.PositionAn := i;
              result := res;
              break;
            End;
          End
          else
          Begin
            res.BoolAn := false;
            res.PositionAn := i;
            result := res;
            break;
          End;

        End;
      ']':
        Begin
          if Stk.Count > 0 then
          Begin

            stmp := Stk.peek;
            x := stmp[1];
            Stk.pop;
            if ((x = '(') or (x = '{')) then
            Begin
              res.BoolAn := false;
              res.PositionAn := i;
              result := res;
              break;
            End;

          End
          else
          Begin
            res.BoolAn := false;
            res.PositionAn := i;
            result := res;
            break;
          End;
        End;
    end;

  end;

  boolCondition := (x = '(') or (x = '[') or (x = '{');

  var
  iStck := Stk.Count;

  if (iStck >= 2) then
  Begin
    if (x = Stk.List[0]) or (x = char(0)) then
    Begin
      x1:=Stk.List[0][1];
      s1 := 2;
      s2 := 1;
    End
    else if (x = Stk.List[1]) or (x <> char(0)) then
    Begin
      x1:=Stk.List[1][1];


      s1 := 1;
      s2 := 2;
    End;

  End;

  // Check for only on signe
  var
  iposf := 0;
  var
  S := Stk.List[0];
  if (iStck = 1) then
  Begin
    case S[1] of
      '(':
        iposf := Pos(')', exp);
      '{':
        iposf := Pos('}', exp);
      '[':
        iposf := Pos(']', exp);

    end;
    if ((Pos('(', exp) > 0) and (Pos(')', exp) <= 0)) or
      ((Pos(')', exp) > 0) and (Pos('(', exp) <= 0)) then
      iposf := 0;

    if ((Pos('{', exp) > 0) and (Pos('}', exp) <= 0)) or
      ((Pos('}', exp) > 0) and (Pos('{', exp) <= 0)) then
      iposf := 0;

    if ((Pos('[', exp) > 0) and (Pos(']', exp) <= 0)) or
      ((Pos(']', exp) > 0) and (Pos('[', exp) <= 0)) then

      s1 := 1;
    s2 := 1;

  End;

  if (iStck > 0) then
  Begin

    var
    k := 0;
    boolfound := false;
    if (iStck = 2) and (boolCondition) then
    Begin
      k := iStck - s1;
      boolfound := true;
    End
    else
      k := iStck - s2;

    for i := 0 to k do
      stmp := Stk.pop;
    x := stmp[1];
  End;
  var
  iPlus := PlusChar(exp, '+');

  if (iPlus > -1) then
  Begin
    iposf := 0;
    res.PositionAn := iPlus;

  End;

  res.BoolAn := (res.PositionAn = 0) and (iStck = 1) and (iposf > 0);

  if (res.BoolAn = false) and (boolCondition) and (iStck = 2) then
  // search close outside the expression
  Begin
    var
    ipos := 0;
    var
    ipos2 :=0;
    var
    exp1 := exp;

    while Pos(x1, exp1) > 0 do
    Begin
      ipos2 := Pos(x1, exp1);
      exp1 := copy(exp1, ipos2 + 1, Length(exp1));
      ipos:=ipos+ipos2;
    End;
    if boolfound then
      dec(ipos);

    res.PositionAn := ipos;
    res.CharError := x1;
    result := res
  End
  else
  Begin

    if ((res.BoolAn = false) and (res.PositionAn = 0)) then
    Begin
      if (iStck = 1) then
      Begin
        if iposf = 0 then
          res.PositionAn := len - iStck + 1

        else
          res.PositionAn := iStck + 1
      End
      else

        res.PositionAn := Length(exp);
    End
    else if (boolCondition) and (iStck = 0) then

      res.PositionAn := res.PositionAn
    else if (res.PositionAn > 1) then
      res.PositionAn := res.PositionAn;

    res.CharError := exp[res.PositionAn];
    if ((res.PositionAn = len) and (res.CharError <> '+')) then
      sInformation := 'You must use a close parenthesis !';
    if (res.CharError = '+') then
      sInformation := 'You must add a number after the plus !';
    result := res;
  End;
  Stk.Clear;
  Stk.Free;
end;

procedure TfrmValidParantheses.N2Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmValidParantheses.statbarDrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
begin
  if Panel = StatusBar.Panels[0] then
  begin
    Panel.Width := Trunc(StatusBar.Canvas.TextWidth(sInformation) * 1.5);
    with StatusBar.Canvas do
    begin
      Brush.Color := clGrayText;
      FillRect(Rect);
      Font.Name := 'Tahoma';
      Font.Color := clInformation;
      Font.Style := Font.Style + [fsItalic, fsBold];
      TextRect(Rect, Rect.Left + 1, Rect.Top, sInformation);
    end;
  end;
end;

procedure TfrmValidParantheses.btnTestClick(Sender: TObject);
var
  expresion: string;
  resExpretion: TAnwser;
  BoolParenthese: Boolean;
begin
  imgStatus.Picture.Assign(nil);
  ImgLst.Draw(imgStatus.Canvas, 4, 4, 2);
  clInformation := clRed;
  statbar.Panels[0].Text := '';
  expresion := edtInput.Text;
  BoolParenthese := (Pos('(', expresion) > 0) or (Pos(')', expresion) > 0) or
    (Pos('}', expresion) > 0) or (Pos('{', expresion) > 0) or
    (Pos('[', expresion) > 0) or (Pos(']', expresion) > 0);
  if not(BoolParenthese) then
    sInformation := 'Parentheses no found !';
  statbar.Invalidate;
  if (Length(expresion) < 2) or not(BoolParenthese) then
    exit;
  resExpretion := isBalancedExp(expresion);
  if (resExpretion.BoolAn = true) then
  Begin
    clInformation := clWhite;;
    sInformation := 'Valid function';
    imgStatus.Picture.Assign(nil);
    ImgLst.Draw(imgStatus.Canvas, 4, 4, 3);
  End
  else
  Begin
    sInformation := 'Not valid function !';
    MessageDlg('Not a valid function : "' + resExpretion.CharError +
      '" ,position : ' + inttostr(resExpretion.PositionAn), mtWarning,
      [mbOK], 0);

    edtInput.SetFocus;
    edtInput.SelStart := resExpretion.PositionAn - 1;
    edtInput.SelLength := 1;

  End;

end;

procedure TfrmValidParantheses.edtInputChange(Sender: TObject);
begin

  if Length(edtInput.Text) >= 2 then
  Begin
    btnTest.ImageIndex := 1;
    btnTest.Enabled := true;
  End
  else
  Begin
    btnTest.ImageIndex := 0;
    btnTest.Enabled := false;
  End;
end;

procedure TfrmValidParantheses.FormCreate(Sender: TObject);
begin
  clInformation := clWhite;
  sInformation := 'Welcome';
  btnTest.ImageIndex := 1;
  btnTest.Enabled := true;
  // initial edit
//  edtInput.Clear;
  with lblExpresion do
  Begin
    Font.Name := 'Tahoma';
  End;
  self.Color := clWhite;
  self.Caption := Application.Title;
  self.position := poMainFormCenter;

end;

procedure TfrmValidParantheses.I1Click(Sender: TObject);
begin
  frmAboutSN.Show;
end;

end.

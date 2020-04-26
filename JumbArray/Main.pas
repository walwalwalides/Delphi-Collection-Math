{ ============================================
  Software Name : 	JumbArray
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
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Menus;

type
  TfrmMain = class(TForm)
    btnCalcule: TButton;
    lblresult: TLabel;
    lblArrayInput: TLabel;
    lblTitelInput: TLabel;
    lblOutput: TLabel;
    bvlSperate: TBevel;
    Bevel1: TBevel;
    MainMenu: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    A1: TMenuItem;
    I1: TMenuItem;
    procedure btnCalculeClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure I1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
  private

    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  frmMain: TfrmMain;

implementation

uses
  System.Math, uJumbArray, AboutSN;

{$R *.dfm}

procedure TfrmMain.btnCalculeClick(Sender: TObject);
var
  arrT: TJumbArray.TJbArray;
  arrS: TJumbArray.TJbArray;
  arr: TJumbArray;
  Boolresult: boolean;
  A: array of integer;
begin

  A := [2, 1, 2, 0, 4];

  arrT := arr.InsertValue(A); // Insert values in table
  arr.DisplayArrayResult(arrT, lblArrayInput); // Display value input
  arrS := arr.countWaysToJump(arrT);
  // Count number of ways to jump to reach end

  arr.DisplayArrayResult(arrS, lblresult); // Display value output

  Boolresult := arr.CanJumb(arrT);

  if (Boolresult) then
    showmessage('Valid ! ,Minimum jumbs to reach until the end : ' +
      arr.minJumpsToReachTillEnd(arrT).ToString)
  else
    showmessage('Not valid !,Can''t reach the END');

end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  lblresult.caption := '';
  lblArrayInput.caption := '';
  btnCalcule.Cursor := crHandPoint;
  self.Position := poMainFormCenter;

end;

procedure TfrmMain.I1Click(Sender: TObject);
begin
  frmAboutSN.show;
end;

procedure TfrmMain.N2Click(Sender: TObject);
begin
  Application.Terminate;
end;

end.

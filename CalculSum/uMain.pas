{ ============================================
  Software Name : 	CalculSum
  ============================================ }
{ ******************************************** }
{ Written By WalWalWalides }
{ CopyRight © 2019 }
{ Email : WalWalWalides@gmail.com }
{ GitHub :https://github.com/walwalwalides }
{ ******************************************** }
unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, uClassCalcul,
  uClassMethodsUtils, uInterfaceObject, System.Actions, Vcl.ActnList, Vcl.Menus;

const
  AppTitle = 'CalculSum';

type
  TfrmMain = class(TForm)
    btnSum: TButton;
    edtValue1: TEdit;
    edtValue2: TEdit;
    edtResult: TEdit;
    lblPlus: TLabel;
    GrBoxCalcul: TGroupBox;
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
    miSum: TMenuItem;
    Option1: TMenuItem;
    actOption1: TMenuItem;
    A2: TMenuItem;
    actAbout1: TMenuItem;
    ActionList1: TActionList;
    actClear: TAction;
    actSum: TAction;
    actOpenFile: TAction;
    actShowInExplorer: TAction;
    actOpenFolder: TAction;
    actExit: TAction;
    actCopyToClipboard: TAction;
    actRefresh: TAction;
    actOption: TAction;
    actAbout: TAction;
    procedure FormCreate(Sender: TObject);
    procedure btnSumClick(Sender: TObject);
    procedure edtValue1Change(Sender: TObject);
    procedure edtValue2Change(Sender: TObject);
    procedure actExitExecute(Sender: TObject);
    procedure actAboutExecute(Sender: TObject);
    procedure actSumExecute(Sender: TObject);
    procedure actClearExecute(Sender: TObject);
  private
    FCalcul: iCalcul;
    procedure SetCalcul(const Value: iCalcul);
    procedure SetValue(Value: String);
    { Private declarations }
  public
    { Public declarations }
    property Calcul: iCalcul read FCalcul write SetCalcul;
  end;

var
  frmMain: TfrmMain;

implementation

uses uAbout;

{$R *.dfm}
{ TForm1 }

{ TForm1 }

procedure TfrmMain.SetValue(Value: String);
begin
  edtResult.Text := Value;
end;

procedure TfrmMain.edtValue1Change(Sender: TObject);
begin
  btnSum.Enabled := (Length(edtValue1.Text) > 0) and (Length(edtValue2.Text) > 0);
  miSum.Enabled:=(Length(edtValue1.Text) > 0) and (Length(edtValue2.Text) > 0);

end;

procedure TfrmMain.edtValue2Change(Sender: TObject);
begin
  btnSum.Enabled := (Length(edtValue1.Text) > 0) and (Length(edtValue2.Text) > 0);
  miSum.Enabled:=(Length(edtValue1.Text) > 0) and (Length(edtValue2.Text) > 0);

end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  btnSum.Enabled := False;
  Caption := AppTitle;
  Position := poMainFormCenter;
  Calcul := TCalcul.New.Display.Result(SetValue).EndDisplay;

end;

procedure TfrmMain.SetCalcul(const Value: iCalcul);
begin
  FCalcul := Value;
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
  edtValue1.Clear;
  edtValue2.Clear;
  edtResult.Clear;
end;

procedure TfrmMain.actExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TfrmMain.actSumExecute(Sender: TObject);
begin
  Calcul.Add(edtValue1.Text).Add(edtValue2.Text).Sum.Execute;
end;

procedure TfrmMain.btnSumClick(Sender: TObject);
begin
  Calcul.Add(edtValue1.Text).Add(edtValue2.Text).Sum.Execute;

end;

end.

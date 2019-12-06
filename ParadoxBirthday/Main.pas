{ ============================================
  Software Name : 	PradoxBirthday
  ============================================ }
{ ******************************************** }
{ Written By WalWalWalides                     }
{ CopyRight © 2019                             }
{ Email : WalWalWalides@gmail.com              }
{ GitHub :https://github.com/walwalwalides     }
{ ******************************************** }

unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.ComCtrls, Vcl.Buttons, System.Actions, Vcl.ActnList, Vcl.Menus, Vcl.AppEvnts;

type
  TfrmMain = class(TForm)
    MonthCalendar1: TMonthCalendar;
    pnlTop: TPanel;
    GroupBox1: TGroupBox;
    lbledtPepole: TLabeledEdit;
    lbledtDays: TLabeledEdit;
    BitBtnCalculate: TBitBtn;
    lblCD: TLabel;
    lblPairs: TLabel;
    lblCM: TLabel;
    lblCP: TLabel;
    lblPairsV: TLabel;
    lblCPV: TLabel;
    lblCDV: TLabel;
    lblCMV: TLabel;
    bvlvertical: TBevel;
    bvlVertical2: TBevel;
    ApplicationEvents1: TApplicationEvents;
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
    actSettings: TAction;
    actAbout: TAction;
    procedure FormCreate(Sender: TObject);
    procedure BitBtnCalculateClick(Sender: TObject);
    procedure lbledtPepoleChange(Sender: TObject);
    procedure lbledtDaysChange(Sender: TObject);
    procedure actAboutExecute(Sender: TObject);
    procedure actExitExecute(Sender: TObject);
  private
    procedure CleanValues;
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}
uses
 uAbout;


// FloatToStrF(d, ffFixed, 16, 2)
// Format('%.2f', [d])

procedure TfrmMain.actAboutExecute(Sender: TObject);
var
  f: TfrmAbout;
begin

  if Assigned(f) then
    Application.CreateForm(TfrmAbout, f);
  f.Position := poMainFormCenter;
  try
    f.ShowModal;
  finally
    FreeAndNil(f);
  end;
end;

procedure TfrmMain.actExitExecute(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmMain.BitBtnCalculateClick(Sender: TObject);
var
  ipeople: integer;
  idays: integer;
  // ---------------------------------//
  ipairs: integer;

  ipair: Extended;
  iCM: Extended;
  iCDV: Extended;

begin

  ipeople := StrToInt(lbledtPepole.Text);
  idays := StrToInt(lbledtDays.Text);

  ipairs := (ipeople * (ipeople - 1)) div 2;
  ipair := ipairs/idays;
  iCDV := exp(-ipair) * 100;
  iCM := 100 - iCDV;

  lblPairsV.caption := ipairs.ToString;
  lblCPV.caption := FormatFloat('0.00', ipair);
  lblCDV.caption := FormatFloat('0.00', iCDV);
  lblCMV.caption := FormatFloat('0.00', iCM);

end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  frmMain.caption := Application.Title;


  lbledtPepole.top := 30;
  lbledtDays.top := 70;

  lbledtPepole.left := 10;
  lbledtDays.left := 10;

  BitBtnCalculate.top := 110;
  BitBtnCalculate.left := 30;

  lbledtPepole.NumbersOnly := True;
  lbledtDays.NumbersOnly := True;

  frmMain.Position := poMainFormCenter;
  frmMain.WindowState := wsMaximized;

  lblPairs.caption := 'Pairs : ';
  lblCD.caption := 'Chance different : ';
  lblCP.caption := 'Chance per pair : ';
  lblCM.caption := 'Chance of match : ';

  lblPairs.left := 150;
  lblCD.left := 150;
  lblCP.left := 150;
  lblCM.left := 150;

  lblPairs.top := 30;
  lblCP.top := 60;
  lblCD.top := 90;
  lblCM.top := 120;

  lblPairsV.left := 300;
  lblCDV.left := 300;
  lblCPV.left := 300;
  lblCMV.left := 300;

  lblPairsV.top := 30;
  lblCPV.top := 60;
  lblCDV.top := 90;
  lblCMV.top := 120;

  bvlvertical.left := 140;
  bvlVertical2.left := 290;
  CleanValues;

  lbledtPepole.Text := '2';
  lbledtDays.Text := '365';

  frmMain.Padding.left := 10;
  frmMain.Padding.top := 10;
  frmMain.Padding.Right := 10;
  frmMain.Padding.Bottom := 10;
end;

procedure TfrmMain.lbledtDaysChange(Sender: TObject);
begin
  CleanValues;
end;

procedure TfrmMain.lbledtPepoleChange(Sender: TObject);
begin
  CleanValues;
end;

procedure TfrmMain.CleanValues;
begin
  lblPairsV.caption := '';
  lblCDV.caption := '';
  lblCPV.caption := '';
  lblCMV.caption := '';
end;

end.

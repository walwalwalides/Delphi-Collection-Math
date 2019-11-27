{ ============================================
  Software Name : 	DrawTree
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
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.ExtCtrls,System.generics.collections,System.generics.Defaults, Vcl.AppEvnts, System.Actions, Vcl.ActnList,
  Vcl.Menus;

type
  PMyList = ^AList;

  AList = record
    I: Integer;
    C: Char;
  end;

type
  TfrmMain = class(TForm)
    btnDraw: TButton;
    btnInsert: TButton;
    edtNumber: TEdit;
    GrpBoxInsert: TGroupBox;
    StatusBar1: TStatusBar;
    PaintBox1: TPaintBox;
    Bevel1: TBevel;
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
    procedure btnDrawClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnInsertClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
    procedure actExitExecute(Sender: TObject);
    procedure actAboutExecute(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  frmMain: TfrmMain;
  MyList: TList;
  ARecord: PMyList;
  headBool: Boolean;
  Arr: array of integer;


implementation
uses
uAbout;

{$R *.dfm}

  { TODO : Add function sort list }

function mycolor: TColor;
begin
  result := RGB(Random(256), Random(256), Random(256));
end;

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
 application.Terminate;
end;

procedure TfrmMain.ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
begin
//  btnDrawClick(nil);
end;

procedure TfrmMain.btnDrawClick(Sender: TObject);
var
  Y: Word;
  B: byte;
  K: Integer;
begin

  if (MyList.count <= 0) then
    exit;

   SetLength(Arr, MyList.count);

  for K := 0 to MyList.count - 1 do
  Begin
    ARecord := MyList.Items[K];
    Arr[K] := ARecord^.I;
  End;

  TArray.Sort<Integer>(Arr);



  with frmMain.PaintBox1 do
  begin
    Canvas.brush.color := $FFFFFF;
    Canvas.fillrect(rect(0, 0, Width, height));
//    brush.Style := bsSolid;
    if (headBool = false) then
    begin
      Canvas.TextOut(0, 0, 'Head');
      headBool := True;
    end;

    try
      { Now paint the items onto the paintbox }
      Y := 30; { Variable used in TextOut function }

      for B := 0 to (MyList.count - 1) do
      begin
        ARecord := MyList.Items[B];

        Canvas.TextOut(10, Y+30, ARecord^.C); { Display C }
        Y := Y + 30; { Increment Y Value }

        Canvas.Font.color := mycolor;
        Canvas.TextOut(30 + Y - (B * B * B), Y, IntToStr(Arr[B]));
        { Display I }
        Y := Y + 30; { Increment Y Value again }

        Canvas.Font.color := clRed;
        Canvas.LineTo(10, 10); { Display I }
        Canvas.Font.color := clBlack;
        Y := Y + 30; { Increment Y Value again }

      end;

    finally

    end;

  end;
end;

procedure TfrmMain.btnInsertClick(Sender: TObject);
var
  sC: Char;
begin
  if (edtNumber.text = '') or (MyList.count > 9) then
    exit;

  try
    New(ARecord);
    // sC := edtChar.text[1];
    sC := IntToStr(MyList.count)[1];
    ARecord^.I := strtoint(edtNumber.text);
    ARecord^.C := sC;
    MyList.Add(ARecord);
  Except
    ShowMessage('Error');
  end;
  StatusBar1.Panels[1].text := IntToStr(MyList.count);


end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  // Position of the Parametres of element in GUI
   MyList := TList.Create;

  GrpBoxInsert.Anchors := [akRight, akTop];
  btnDraw.Anchors := [akRight, akTop];
  PaintBox1.Anchors := [akRight, akTop,akBottom,akLeft];
  edtNumber.Clear;
  edtNumber.NumbersOnly := True;
  frmMain.Position := poMainFormCenter;
  frmMain.WindowState := wsMaximized;


end;

procedure TfrmMain.FormDestroy(Sender: TObject);
var
  B: byte;
begin
  { Cleanup: must free the list items as well as the list }
  if (MyList.count > 0) then
  begin
    for B := 0 to (MyList.count - 1) do
    begin
      ARecord := MyList.Items[B];
      Dispose(ARecord);
    end;
  end;

  MyList.Free;
end;

procedure TfrmMain.FormResize(Sender: TObject);
begin
  btnDrawClick(nil);
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  edtNumber.SetFocus;
  StatusBar1.Panels[1].Text:='0';
end;

end.

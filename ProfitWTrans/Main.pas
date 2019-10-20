{ ============================================
  Software Name : 	ProfitWithTransac
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
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids, Vcl.ExtCtrls, Vcl.Menus, System.Actions, Vcl.ActnList,
  Vcl.Samples.Spin;

type
  TfrmMain = class(TForm)
    btnResult: TButton;
    memDisplay: TMemo;
    strGridTransaction: TStringGrid;
    gridpnlMain: TGridPanel;
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
    SpedtTransaction: TSpinEdit;
    pnlMain: TPanel;
    lblnbTransaction: TLabel;
    procedure btnResultClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actAboutExecute(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  frmMain: TfrmMain;
  Price: array of integer;

implementation

uses
  System.Math, System.generics.collections, uAbout;

{$R *.dfm}

function MaxProfit(var Price: array of integer; const k: integer;
  Amemo: TMemo): integer;
var
  profit: array of array of integer;
  t, tmp: integer;
  Arr: TArray<integer>; // input and output
  SrcIndex, DestIndex: integer;
begin
  t := Price[1];
  var
  n := length(Price);
  var
  count := 0;
  Setlength(profit, k + 1, n + 1);
  Setlength(Arr, k * 2);
  for var I := 0 to k do
  begin
    var
    prev_diff := Low(integer);

    for var j := 0 to n do
    begin
      if ((I = 0) or (j = 0)) then
        profit[I][j] := 0
      else
      begin

        prev_diff := max(prev_diff, profit[I - 1][j - 1] - Price[j - 1]);
        profit[I][j] := max(profit[I][j - 1], Price[j] + prev_diff);

        if ((Price[j - 1] < Price[j]) and (I mod 2 = 0)) then
        begin
          if (Arr[count - 1] = Price[j - 1]) and (count <> 0) then
          begin
            dec(count);
            Arr[count] := Price[j];
            inc(count);
          end
          else
          begin
            Arr[count] := Price[j - 1];
            inc(count);
            Arr[count] := Price[j];
            inc(count);
          end;

        end;

      end;

    end;
  end;

  for var I := Low(Arr) to High(Arr) do

    if ((I mod 2) = 0) then
      Amemo.Lines.Add('buy at price ' + Arr[I].ToString + ' sell at price ' +
        Arr[I + 1].ToString);

  result := profit[k][n - 1];

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

procedure TfrmMain.btnResultClick(Sender: TObject);
begin
  memDisplay.Clear;
  var
  k := SpedtTransaction.Value;

  var
  s := MaxProfit(Price, k, memDisplay);
  memDisplay.Lines.Add('Result :' + IntToStr(s));
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  frmMain.position := poMainFormCenter;
  frmMain.WindowState := wsMaximized;
  btnResult.Cursor:=crHandPoint;
  memDisplay.Clear;
  pnlMain.Caption:='';

  gridpnlMain.Caption := '';
  frmMain.Caption := '';
  SpedtTransaction.Value:=2;

  strGridTransaction.RowCount := 2;
  strGridTransaction.ColCount := 7;
  strGridTransaction.Cells[0, 0] := 'Days';
  strGridTransaction.Cells[0, 1] := 'Price';

  Setlength(Price, 7);

  Price[0] := 2;
  Price[1] := 4;
  Price[2] := 7;
  Price[3] := 5;
  Price[4] := 4;
  Price[5] := 3;
  Price[6] := 5;

  for var I := 1 to 7 do
    strGridTransaction.Cells[I, 0] :='Day '+ I.ToString;

  for var j := 1 to 7 do
    strGridTransaction.Cells[j, 1] := (Price[j - 1]).ToString;

end;

end.

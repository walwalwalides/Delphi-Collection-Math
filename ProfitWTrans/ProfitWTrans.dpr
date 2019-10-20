program ProfitWTrans;

uses
  Vcl.Forms,
  Main in 'Main.pas' {frmMain},
  uAbout in 'ABOUT\uAbout.pas' {frmAbout};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title:='ProfitWTrans';
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.

program JumbArray;

uses
  Vcl.Forms,
  Main in 'Main.pas' {frmMain},
  uJumbArray in 'uJumbArray.pas',
  AboutSN in 'View\AboutSN.pas' {frmAboutSN};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmAboutSN, frmAboutSN);
  Application.Run;
end.

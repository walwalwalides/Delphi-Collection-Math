program MySpiralMatrix;

uses
  Forms,
  FormMain in 'View\FormMain.pas' {MainForm},
  AboutSN in 'View\AboutSN.pas' {frmAboutSN},
  Tools in 'Unit\Tools.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TfrmAboutSN, frmAboutSN);
  Application.Run;
end.

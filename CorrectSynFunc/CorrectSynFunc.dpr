program CorrectSynFunc;

uses
  Vcl.Forms,
  uValidParantheses in 'uValidParantheses.pas' {frmValidParantheses},
  AboutSN in 'View\AboutSN.pas' {frmAboutSN};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'CoorectSynFunc';
  Application.CreateForm(TfrmValidParantheses, frmValidParantheses);
  Application.CreateForm(TfrmAboutSN, frmAboutSN);
  Application.Run;

end.

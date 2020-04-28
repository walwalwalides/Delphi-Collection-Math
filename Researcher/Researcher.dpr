program Researcher;

uses
  Vcl.Forms,
  Main in 'Main.pas' {frmMain},
  uArrayhelper in 'uArrayhelper.pas',
  uClassPerson in 'uClassPerson.pas',
  About in 'View\About.pas' {frmAbout},
  uRecordPerson in 'uRecordPerson.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmAbout, frmAbout);
  Application.Run;
end.

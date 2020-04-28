program Researcher;

uses
  Vcl.Forms,
  Main in 'Main.pas' {Form1},
  uArrayhelper in 'uArrayhelper.pas',
  uClassPerson in 'uClassPerson.pas',
  About in 'View\About.pas' {frmAbout},
  uRecordPerson in 'uRecordPerson.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TfrmAbout, frmAbout);
  Application.Run;
end.

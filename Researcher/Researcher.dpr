program Researcher;

uses
  Vcl.Forms,
  Search in 'Search.pas' {frmSearch},
  uArrayhelper in 'uArrayhelper.pas',
  uClassPerson in 'uClassPerson.pas',
  About in 'View\About.pas' {frmAbout},
  uRecordPerson in 'uRecordPerson.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmSearch, frmSearch);
  Application.CreateForm(TfrmAbout, frmAbout);
  Application.Run;
end.

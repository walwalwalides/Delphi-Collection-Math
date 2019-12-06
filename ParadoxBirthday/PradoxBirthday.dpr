program PradoxBirthday;

uses
  Vcl.Forms,
  Main in 'Main.pas' {frmMain},
  uAbout in 'ABOUT\uAbout.pas' {frmAbout};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmAbout, frmAbout);
  Application.Run;
end.

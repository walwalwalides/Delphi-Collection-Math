program CalculSum;

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {frmMain},
  uClassCalcul in 'uClassCalcul.pas',
  uClassMethodsUtils in 'uClassMethodsUtils.pas',
  uInterfaceObject in 'uInterfaceObject.pas',
  uClassSum in 'uClassSum.pas',
  uClassOper in 'uClassOper.pas',
  uCalculEvents in 'uCalculEvents.pas',
  uAbout in 'ABOUT\uAbout.pas' {frmAbout};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmAbout, frmAbout);
  Application.Run;
end.

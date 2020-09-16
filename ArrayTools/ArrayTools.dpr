program ArrayTools;

uses
  Vcl.Forms,
  Test in 'Test.pas' {frmTest},
  uDynArrTools in 'uDynArrTools.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown:=true;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmTest, frmTest);
  Application.Run;
end.

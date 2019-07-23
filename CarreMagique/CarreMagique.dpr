program CarreMagique;

uses
  Forms,
  Main in 'Main.pas' {frmMain},
  uCarreM in 'uCarreM.pas',
  uAbout in 'ABOUT\uAbout.pas' {frmAbout};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Title:='CAREE MAGIQUE';
  Application.Run;
end.

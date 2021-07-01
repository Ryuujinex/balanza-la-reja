program BalanzaLaReja;

uses
  Vcl.Forms,
  Main in 'Main.pas' {Form1},
  EstructurasBalanza in 'EstructurasBalanza.pas',
  File_Manager in 'File_Manager.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

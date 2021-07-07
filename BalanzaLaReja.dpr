program BalanzaLaReja;

uses
  Vcl.Forms,
  Main in 'Main.pas' {Form1},
  Product_Manager in 'Product_Manager.pas',
  Transport_Manager in 'Transport_Manager.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, Estructuras, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  Archivo: Archivador;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  Archivo.CrearArchivoProd;
  Memo1.Lines.Add(Archivo.Mostrar);
end;

end.

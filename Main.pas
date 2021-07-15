unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, Vcl.StdCtrls, Product_Manager, Transport_Manager, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
  private
    { Private declarations }
  public
    PathProductos: string;
    PathTransportes: string;
  end;

var
  Form1: TForm1;
  Productos: ProductManagerObj;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  Productos.Crear;
  Memo1.Lines.Add('Archivo creado Satisfactoriamente.');
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  Rec: TProductos;
begin
  with Rec do
    begin
      Nombre:= LabeledEdit2.Text;
      Codigo:= Strtoint(LabeledEdit1.Text);
    end;
  if Productos.Agregar(Rec) = Product_Manager.OK then
    Memo1.Lines.Add('Registro agregado correctamente')
  else
    if Productos.Agregar(Rec) = Product_Manager.NO_EXISTE then
      Memo1.Lines.Add('Archivo inexistente.');

end;

procedure TForm1.Button3Click(Sender: TObject);
var
  Rec: Tproductos;
begin
  if Productos.Recuperar(Strtoint(LabeledEdit1.Text), Rec) = PErrores.OK then

    Memo1.Lines.Add(Rec.Codigo.ToString + ', ' + Rec.Nombre + '.')
  else
    if Productos.Recuperar(Strtoint(LabeledEdit1.Text), Rec) = PErrores.FUERA_RANGO then
      Memo1.Lines.Add('No existe esa Posicion.');
end;

procedure TForm1.Button6Click(Sender: TObject);
var
  Rec: Tproductos;
begin
  Rec.Codigo:= Strtoint(LabeledEdit1.Text);
  Rec.Nombre:= LabeledEdit2.Text;
  if Productos.Modificar(Strtoint(LabeledEdit1.Text), Rec) = PErrores.OK then
    Memo1.Lines.Add('Modificado el registro ' + LabeledEdit1.Text + ' correctamente.')
  else
    if Productos.Recuperar(Strtoint(LabeledEdit1.Text), Rec) = PErrores.FUERA_RANGO then
      Memo1.Lines.Add('No existe esa Posicion.');
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
  Memo1.Lines.Add(Productos.DevolverCadena);
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  Productos.Iniciar('.\data/Productos.dat');
end;

end.

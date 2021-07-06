unit EstructurasBalanza;

interface

uses
  Sysutils, Transport_Manager, Product_Manager;

const
  FilePath = '.\data/Productos.dat';

//type

implementation

procedure FileManager.CrearArchivoProd();
var
  Rec: TProductos;
  I: Integer;
begin
  Rec.Nombre:= 'Arena X Kg Perez';
  Rec.Codigo:= 0;
  Rec.Alta:= True;

  while not Eof(FileProductos) do

    Seek(Fileproductos, FilePos(Fileproductos) + 1);
  for I:= 1 to 100000 do
    begin
      write(FileProductos, Rec);
      Rec.Codigo:= Rec.Codigo + 1;
    end;
  CloseFile(FileProductos);
end;

function FileManager.Mostrar(): string;
var
  Rec: TProductos;
  Str: string;
begin
  Str:= '';
  AssignFile(FileProductos, FilePath);
  Reset(FileProductos);
  while not Eof(FileProductos) do
    begin
      read(Fileproductos, Rec);
      Str:= Str + Rec.Nombre + ', ' + Rec.Codigo.ToString + #13 + #10;
    end;
  CloseFile(Fileproductos);
  Mostrar:= Str;
end;

procedure FileManager.CrearArchivoTrans;
begin

end;

end.

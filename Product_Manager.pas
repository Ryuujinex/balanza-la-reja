unit Product_Manager;

interface

uses
  Sysutils;

type
  PErrores = (OK, FUERA_RANGO, NO_EXISTE, ERROR); // Devolucion de las funciones.

  TProductos = record
    Nombre: string[32];
    Codigo: Integer;
    Alta: Boolean;
  end;

  ProductManagerObj = object
  private
    QRecords: Integer;
    Path: string;
    Archivo: file of TProductos;
    procedure CheckQRecs();
  public
    procedure Crear();
    function Agregar(Rec: TProductos): PErrores;
    function Alta(Pos: Integer): PErrores;
    function Baja(Pos: Integer): PErrores;
    function Modificar(Pos: Integer; Rec: TProductos): PErrores;
    function Recuperar(Pos: Integer; out Rec: TProductos): PErrores;
    procedure Iniciar(PathFile: string);
    function DevolverCadenaAlta(): string;
    function DevolverCadenaBaja(): string;
  end;

implementation

// Inicializa las variables internas.
procedure ProductManagerObj.Iniciar(PathFile: string);
begin
  Path:= PathFile;
  AssignFile(Archivo, Path);
  if FileExists(Path) then
    CheckQRecs;
end;

// Crea el archivo, devolviendo true. Si existe previamente, devuelve false y no crea nada.
procedure ProductManagerObj.Crear();
begin
  Rewrite(Archivo);
  Closefile(Archivo);
  QRecords:= 0;
end;

// Actualiza la cantidad de registros en el archivo.
procedure ProductManagerObj.CheckQRecs();
begin
  QRecords:= 0;
  Reset(Archivo);
  while not Eof(Archivo) do
    begin
      QRecords:= QRecords + 1;
      Seek(Archivo, FilePos(Archivo) + 1);
    end;
  Closefile(Archivo);
end;

// Añade un registro al archivo, se debe pasar el puntero al registro.
function ProductManagerObj.Agregar(Rec: TProductos): PErrores;
begin
  if FileExists(Path) then
    begin
      Reset(Archivo);
      Seek(Archivo, QRecords);
      write(Archivo, Rec);
      Closefile(Archivo);
      QRecords:= QRecords + 1;
      Agregar:= OK
    end
  else
    Agregar:= NO_EXISTE;
end;

// Modifica un registro del archivo.
function ProductManagerObj.Modificar(Pos: Integer; Rec: TProductos): PErrores;
begin
  if FileExists(Path) then
    begin
      if (Pos >= QRecords) or (Pos < 0) then
        Modificar:= FUERA_RANGO
      else
        begin
          Reset(Archivo);
          Seek(Archivo, Pos);
          write(Archivo, Rec);
          Closefile(Archivo);
          Modificar:= OK
        end;
    end
  else
    Modificar:= NO_EXISTE;
end;

// Obtiene los datos de un registro.
function ProductManagerObj.Recuperar(Pos: Integer; out Rec: TProductos): PErrores;
begin
  // AssignFile(Archivo, Path);
  if FileExists(Path) then
    begin
      if (Pos >= QRecords) or (Pos < 0) then
        Recuperar:= FUERA_RANGO
      else
        begin
          Reset(Archivo);
          Seek(Archivo, Pos);
          read(Archivo, Rec);
          Closefile(Archivo);
          Recuperar:= OK
        end
    end
  else
    Recuperar:= NO_EXISTE;
end;

// Da de Alta un Registro
function ProductManagerObj.Alta(Pos: Integer): PErrores;
var
  Rec: TProductos;
begin
  if FileExists(Path) then
    begin
      if (Pos >= QRecords) or (Pos < 0) then
        Alta:= FUERA_RANGO
      else
        begin
          Reset(Archivo);
          Seek(Archivo, Pos);
          read(Archivo, Rec);
          Rec.Alta:= True;
          Seek(Archivo, Pos);
          write(Archivo, Rec);
          Closefile(Archivo);
          Alta:= OK
        end
    end
  else
    Alta:= NO_EXISTE;
end;

// Da de Baja un Registro
function ProductManagerObj.Baja(Pos: Integer): PErrores;
var
  Rec: TProductos;
begin
  if FileExists(Path) then
    begin
      if (Pos >= QRecords) or (Pos < 0) then
        Baja:= FUERA_RANGO
      else
        begin
          Reset(Archivo);
          Seek(Archivo, Pos);
          read(Archivo, Rec);
          Rec.Alta:= False;
          Seek(Archivo, Pos);
          write(Archivo, Rec);
          Closefile(Archivo);
          Baja:= OK
        end
    end
  else
    Baja:= NO_EXISTE;
end;

// Devuelve un string con los registros dados de alta
function Productmanagerobj.DevolverCadenaAlta(): string;
var
  Rec: TProductos;
  Str: string;
begin
  if FileExists(Path) then
    begin
      Reset(Archivo);
      Str:= '';
      while not Eof(Archivo) do
        begin
          read(Archivo, Rec);
          if Rec.Alta then
            Str:= Str + #13 + #10 + Rec.Codigo.Tostring + ', ' + Rec.Nombre + '.';
        end;
      Closefile(Archivo);
    end
  else
    Str:= 'Archivo inexistente.';
  DevolvercadenaAlta:= Str;
end;

// Devuelve un string con los registros dados de baja
function Productmanagerobj.DevolverCadenaBaja(): string;
var
  Rec: TProductos;
  Str: string;
begin
  if FileExists(Path) then
    begin
      Reset(Archivo);
      Str:= '';
      while not Eof(Archivo) do
        begin
          read(Archivo, Rec);
          if Rec.Alta then
            Str:= Str + #13 + #10 + Rec.Codigo.Tostring + ', ' + Rec.Nombre + '.';
        end;
      Closefile(Archivo);
    end
  else
    Str:= 'Archivo inexistente.';
  DevolvercadenaBaja:= Str;
end;

end.

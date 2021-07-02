unit Product_Manager;

interface

uses
  Sysutils;

type
  Errores = (OK, FUERA_RANGO, NO_EXISTE, ERROR); // Devolucion de las funciones.

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
    function Crear(): Errores;
    function Agregar(Rec: TProductos): Errores;
    function Modificar(Rec: TProductos): Errores;
    function Recuperar(Pos: Integer; out Rec: TProductos): Errores;
    function Iniciar(PathFile: string): Errores;
  end;

implementation

function ProductManagerObj.Iniciar(PathFile: string): Errores;
begin
  Path:= PathFile;
  AssignFile(Archivo, Path);
end;

// Crea el archivo, devolviendo true. Si existe previamente, devuelve false.
function ProductManagerObj.Crear(): Errores;
begin
  if FileExists(Path) then
    Crear:= ERROR
  else
    begin
      Rewrite(Archivo);
      QRecords:= 0;
      Crear:= OK;
    end;
end;

// Actualiza la cantidad de registros en el archivo.
procedure ProductManagerObj.CheckQRecs();
begin
  QRecords:= 0;
  while not Eof(Archivo) do
    begin
      QRecords:= QRecords + 1;
      Seek(Archivo, FilePos(Archivo) + 1);
    end;
end;

// Añade un registro al archivo, se debe pasar el puntero al registro.
function ProductManagerObj.Agregar(var Archivo: file; Path: string; Rec: Pointer): Errores;
begin
  AssignFile(Archivo, Path);
  if FileExists(Path) then
    begin
      Reset(Archivo);
      write(Archivo, Rec^);
      Closefile(Archivo);
      Agregar:= OK
    end
  else
    Agregar:= NO_EXISTE;
end;

// Modifica un registro del archivo.
function ProductManagerObj.Modificar(var Archivo: file; Path: string; Rec: Pointer; Pos: Integer): Errores;
begin
  AssignFile(Archivo, Path);
  if FileExists(Path) then
    begin
      if QRecords = 0 then
        CheckQRecs(Archivo);
      if (Pos >= QRecords) or (Pos < 0) then
        Modificar:= FUERA_RANGO
      else
        begin
          Reset(Archivo);
          Seek(Archivo, Pos);
          write(Archivo, Rec^);
          Closefile(Archivo);
          Modificar:= OK
        end;
    end
  else
    Modificar:= NO_EXISTE;
end;

// Obtiene los datos de un registro.
function ProductManagerObj.Recuperar(var Archivo: file; Path: string; Pos: Integer; var Rec: Pointer): Errores;
begin
  AssignFile(Archivo, Path);
  if FileExists(Path) then
    begin
      if QRecords = 0 then
        CheckQRecs(Archivo);
      if (Pos >= QRecords) or (Pos < 0) then
        Recuperar:= FUERA_RANGO
      else
        begin
          Reset(Archivo);
          Seek(Archivo, Pos);
          read(Archivo, Rec^);
          Closefile(Archivo);
          Recuperar:= OK
        end
    end
  else
    Recuperar:= NO_EXISTE;
end;

end.

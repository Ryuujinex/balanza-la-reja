unit File_Manager;

interface

uses
  Sysutils;

type
  Errores = (OK, FUERA_RANGO, NO_EXISTE, ERROR); // Devolucion de las funciones.

  FileManagerObj = object
  private
    QRecords: Integer;
    procedure CheckQRecs(var Archivo: file);
  public
    function Crear(var Archivo: file; Path: string): Errores;
    function Agregar(var Archivo: file; Path: string; Rec: Pointer): Errores;
    function Modificar(var Archivo: file; Path: string; Rec: Pointer; Pos: Integer): Errores;
    function Recuperar(var Archivo: file; Path: string; Pos: Integer; var Rec: Pointer): Errores;
  end;

implementation

// Crea el archivo, devolviendo true. Si existe previamente, devuelve false.
function FileManagerObj.Crear(var Archivo: file; Path: string): Errores;
begin
  AssignFile(Archivo, Path);
  if FileExists(Path) then
    Crear:= NO_EXISTE
  else
    begin
      Rewrite(Archivo);
      QRecords:= 0;
      Crear:= OK;
    end;
end;

// Actualiza la cantidad de registros en el archivo.
procedure FilemanagerObj.CheckQRecs(var Archivo: file);
begin
  QRecords:= 0;
  while not Eof(Archivo) do
    begin
      QRecords:= QRecords + 1;
      Seek(Archivo, FilePos(Archivo) + 1);
    end;
end;

// Añade un registro al archivo, se debe pasar el puntero al registro.
function Filemanagerobj.Agregar(var Archivo: file; Path: string; Rec: Pointer): Errores;
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
function Filemanagerobj.Modificar(var Archivo: file; Path: string; Rec: Pointer; Pos: Integer): Errores;
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
function Filemanagerobj.Recuperar(var Archivo: file; Path: string; Pos: Integer; var Rec: Pointer): Errores;
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

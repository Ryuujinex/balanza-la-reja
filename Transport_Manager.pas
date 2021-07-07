unit Transport_Manager;

interface

uses
  Sysutils;

type
  TErrores = (OK, FUERA_RANGO, NO_EXISTE, ERROR); // Devolucion de las funciones.

  TTransportes = record
    Nombre: string[32];
    Codigo: Integer;
    Transportista: array [1 .. 32] of string[32];
    Alta: Boolean;
  end;

  TransportManagerObj = object
  private
    QRecords: Integer;
    Path: string;
    Archivo: file of TTransportes;
    procedure CheckQRecs();
  public
    procedure Crear();
    function Agregar(Rec: TTransportes): TErrores;
    function Modificar(Pos: Integer; Rec: TTransportes): TErrores;
    function Recuperar(Pos: Integer; out Rec: TTransportes): TErrores;
    procedure Iniciar(PathFile: string);
  end;

implementation

// Inicializa las variables internas.
procedure TransportManagerObj.Iniciar(PathFile: string);
begin
  Path:= PathFile;
  AssignFile(Archivo, Path);
  if FileExists(Path) then
    CheckQRecs;
end;

// Crea el archivo, devolviendo true. Si existe previamente, devuelve false y no crea nada.
procedure TransportManagerObj.Crear();
begin
  Rewrite(Archivo);
  Closefile(Archivo);
  QRecords:= 0;
end;

// Actualiza la cantidad de registros en el archivo.
procedure TransportManagerObj.CheckQRecs();
begin
  QRecords:= 0;
  while not Eof(Archivo) do
    begin
      QRecords:= QRecords + 1;
      Seek(Archivo, FilePos(Archivo) + 1);
    end;
end;

// Añade un registro al archivo, se debe pasar el puntero al registro.
function TransportManagerObj.Agregar(Rec: TTransportes): TErrores;
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
function TransportManagerObj.Modificar(Pos: Integer; Rec: TTransportes): TErrores;
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
function TransportManagerObj.Recuperar(Pos: Integer; out Rec: TTransportes): TErrores;
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

end.

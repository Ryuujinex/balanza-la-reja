unit File_Manager;

interface

uses
  Sysutils;

type

  FileManagerObj = object
  private
    QRecords: Integer;
    procedure CheckQRecs(var Archivo: file);
  public
    function CreateFile(var Archivo: file; Path: string): Boolean;
  end;

implementation

// Crea el archivo, devolviendo true. Si existe previamente, devuelve false.
function FileManagerObj.CreateFile(var Archivo: file; Path: string): Boolean;
begin
  AssignFile(Archivo, Path);
  if FileExists(Path) then
    CreateFile:= False
  else
    begin
      Rewrite(Archivo);
      QRecords:= 0;
      Createfile:= True;
    end;
end;

procedure FilemanagerObj.CheckQRecs(var Archivo: file);
begin

end;

end.

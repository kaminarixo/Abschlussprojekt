codeunit 50143 TempBlobManagement
{
    procedure FileExists(FilePath: Text): Boolean;
    var
        InStr: InStream;
        OutStr: OutStream;
        TempBlob: Record TempBlob;
        FileMgt: Codeunit "File Management";
    begin
        TempBlob.Blob.CreateOutStream(OutStr);
        if FileMgt.BLOBImportFromServerFile(OutStr, FilePath) then begin
            exit(true);
        end else begin
            exit(false);
        end;
    end;
}

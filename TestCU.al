/*
codeunit 50149 TempBlobManagement
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"ApplicationManagement", 'OnCompanyInitialize', '', false, false)]
    local procedure OnCompanyInitialize()
    begin
        // Initialisierungscode, falls benötigt
    end;

    procedure FileExists(FileName: Text): Boolean
    var
        FileMgt: Codeunit "File Management";
        InStr: InStream;
    begin
        if FileMgt.BLOBImportFromServerFile(InStr, FileName) then
            exit(true)
        else
            exit(false);
    end;
}
*/
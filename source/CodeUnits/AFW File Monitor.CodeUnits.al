/*
codeunit 50100 "AFW File Monitor"
{
    SingleInstance = true;
    Subtype = Normal;

    trigger OnRun()
    begin
        MonitorFolder();
    end;

    local procedure MonitorFolder()
    var
        AFWFileRec: Record "AFW Files";
        AFWAlertRec: Record "AFW Alerts";
        FolderPath: Text[250];
        FileTypes: Text[250];
        FileTypeArray: array[10] of Text[10];
        CreationDate: DateTime;
        Files: List of [Text];
        FileName: Text[250];
        FileType: Text[10];
        FileTypeList: List of [Text];
        i: Integer;

    begin
        if not AFWFileRec.FindFirst() then
            Error('AFW Files not configured.');

        FolderPath := AFWFileRec."Folder Path";
        FileTypes := Format(AFWFileRec."File Types"); // Convert enum to text

        // Split the FileTypes string into an array
        FileTypeList := FileTypes.Split(',');
        for i := 1 to FileTypeList.Count do
            FileTypeArray[i] := CopyStr(FileTypeList.Get(i), 1, 10);

        // Get list of files in the folder
        Files := GetFilesInFolder(FolderPath);

        foreach FileName in Files do begin
            FileType := GetFileExtension(FileName);
            if FileTypes <> '' then begin
                if not MatchFileType(FileType, FileTypeArray) then
                    exit; // Use exit instead of continue
            end;

            CreationDate := GetFileCreationDateTime(FileName);

            if not AFWFileRec.Get(FileName) then begin
                AFWFileRec.Init();
                AFWFileRec."File Name" := FileName;
                AFWFileRec."Creation Date" := CreationDate;
                AFWFileRec.Status := AFWFileRec.Status::Pending;
                AFWFileRec.Insert();
            end else begin
                if DT2Date(CreationDate) < CalcDate('<-30D>', Today) then begin
                    CreateAlert(AFWFileRec);
                end;
            end;
        end;
    end;

    local procedure GetFilesInFolder(FolderPath: Text[250]): List of [Text]
    var
        FileManagement: Codeunit "File Management";
        Files: List of [Text];
    begin
        // Use the correct method from File Management codeunit
        //FileManagement.GetServerFiles(FolderPath, Files);
        exit(Files);
    end;

    local procedure GetFileExtension(FileName: Text[250]): Text[10]
    var
        DotPosition: Integer;
    begin
        DotPosition := StrPos(FileName, '.');
        if DotPosition > 0 then
            exit(CopyStr(FileName, DotPosition + 1, 10))
        else
            exit('');
    end;

    local procedure GetFileCreationDateTime(FileName: Text[250]): DateTime
    var
        FileManagement: Codeunit "File Management";
        CreationDateTime: DateTime;
    begin
        // Use the correct method from File Management codeunit
        //CreationDateTime := FileManagement.GetFileLastModifiedDateTime(FileName);
        exit(CreationDateTime);
    end;

    local procedure MatchFileType(FileExtension: Text[10]; FileTypeArray: array[10] of Text[10]): Boolean
    var
        i: Integer;
    begin
        for i := 1 to ArrayLen(FileTypeArray) do begin
            if FileExtension = FileTypeArray[i] then
                exit(true);
        end;
        exit(false);
    end;

    local procedure CreateAlert(AFWFileRec: Record "AFW Files")
    var
        AFWAlertRec: Record "AFW Alerts";
    begin
        if not AFWFileRec.FindFirst() then
            Error('AFW Files not configured.');

        AFWAlertRec.Init();
        AFWAlertRec."File Name" := AFWFileRec."File Name";
        AFWAlertRec."Alert Timestamp" := CurrentDateTime;
        AFWAlertRec."Recipient" := AFWFileRec."Email Recipient";
        AFWAlertRec.Insert();

        // Call AFW_Alert_Sender to send email notification
        Codeunit.Run(Codeunit::"AFW Alert Sender", AFWAlertRec);
    end;
}*/
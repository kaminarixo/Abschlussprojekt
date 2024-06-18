codeunit 50100 "EDI File Monitor"
{
    SingleInstance = true;
    Subtype = Normal;

    trigger OnRun()
    begin
        MonitorFolder();
    end;

    local procedure MonitorFolder()
    var
        EDISettingsRec: Record "EDI Settings";
        EDIFileRec: Record "EDI Files";
        EDIAlertRec: Record "EDI Alerts";
        FolderPath: Text[250];
        FileTypes: Text[250];
        FileTypeArray: Array of [10] Text;
        CreationDate: DateTime;
        Files: List of [Text];
        FileName: Text[250];
        FileType: Text[10];
    
    begin
        if not EDISettingsRec.FindFirst() then
            Error('EDI Settings not configured.');

        FolderPath := EDISettingsRec."Folder Path";
        FileTypes := EDISettingsRec."File Types";
        FileTypeArray := FileTypes.Split(',');

        // Get list of files in the folder
        Files := GetFilesInFolder(FolderPath);

        foreach FileName in Files do begin
            FileType := GetFileExtension(FileName);
            if FileTypes <> '' then begin
                if not MatchFileType(FileType, FileTypeArray) then
                    continue;
            end;

            CreationDate := GetFileCreationDateTime(FileName);

            if not EDIFileRec.Get(FileName) then begin
                EDIFileRec.Init();
                EDIFileRec."File Name" := FileName;
                EDIFileRec."Creation Date" := CreationDate;
                EDIFileRec.Status := EDIFileRec.Status::Pending;
                EDIFileRec.Insert();
            end else begin
                if DateTime2Date(CreationDate) < CalcDate('<-30D>', CurrentDateTime) then begin
                    CreateAlert(EDIFileRec);
                end;
            end;
        end;
    end;

    local procedure GetFilesInFolder(FolderPath: Text[250]): List of [Text]
    var
        FileManagement: Codeunit "File Management";
        Files: List of [Text];
    begin
        FileManagement.GetFiles(FolderPath, Files);
        exit(Files);
    end;

    local procedure GetFileExtension(FileName: Text[250]): Text[10]
    var
        DotPosition: Integer;
    begin
        DotPosition := StrPos(FileName, '.');
        if DotPosition > 0 then
            exit(CopyStr(FileName, DotPosition, MaxStrLen(FileName) - DotPosition + 1))
        else
            exit('');
    end;

    local procedure GetFileCreationDateTime(FileName: Text[250]): DateTime
    var
        FileManagement: Codeunit "File Management";
        CreationDateTime: DateTime;
    begin
        CreationDateTime := FileManagement.GetCreationTimeStamp(FileName);
        exit(CreationDateTime);
    end;

    local procedure MatchFileType(FileExtension: Text[10]; FileTypeArray: Array of [10] Text): Boolean
    var
        i: Integer;
    begin
        for i := 0 to ArrayLen(FileTypeArray) - 1 do begin
            if FileExtension = FileTypeArray[i] then
                exit(true);
        end;
        exit(false);
    end;

    local procedure CreateAlert(EDIFileRec: Record "EDI Files")
    var
        EDIAlertRec: Record "EDI Alerts";
        EDISettingsRec: Record "EDI Settings";
    begin
        if not EDISettingsRec.FindFirst() then
            Error('EDI Settings not configured.');

        EDIAlertRec.Init();
        EDIAlertRec."File Name" := EDIFileRec."File Name";
        EDIAlertRec."Alert Timestamp" := CurrentDateTime;
        EDIAlertRec."Recipient" := EDISettingsRec."Email Recipient";
        EDIAlertRec.Insert();

        // Call EDI_Alert_Sender to send email notification
        Codeunit.Run(Codename::"EDI Alert Sender", EDIAlertRec);
    end;
    
}

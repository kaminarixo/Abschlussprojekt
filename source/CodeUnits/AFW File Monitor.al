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
        AFWSettingsRec: Record "AFW Settings";
        AFWFileRec: Record "AFW Files";
        AFWAlertRec: Record "AFW Alerts";
        FolderPath: Text[250];
        FileTypes: Text[250];
        FileTypeArray: Array of [10] Text;
        CreationDate: DateTime;
        Files: List of [Text];
        FileName: Text[250];
        FileType: Text[10];
    
    begin
        if not AFWSettingsRec.FindFirst() then
            Error('AFW Settings not configured.');

        FolderPath := AFWSettingsRec."Folder Path";
        FileTypes := AFWSettingsRec."File Types";
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

            if not AFWFileRec.Get(FileName) then begin
                AFWFileRec.Init();
                AFWFileRec."File Name" := FileName;
                AFWFileRec."Creation Date" := CreationDate;
                AFWFileRec.Status := AFWFileRec.Status::Pending;
                AFWFileRec.Insert();
            end else begin
                if DateTime2Date(CreationDate) < CalcDate('<-30D>', CurrentDateTime) then begin
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

    local procedure CreateAlert(AFWFileRec: Record "AFW Files")
    var
        AFWAlertRec: Record "AFW Alerts";
        AFWSettingsRec: Record "AFW Settings";
    begin
        if not AFWSettingsRec.FindFirst() then
            Error('AFW Settings not configured.');

        AFWAlertRec.Init();
        AFWAlertRec."File Name" := AFWFileRec."File Name";
        AFWAlertRec."Alert Timestamp" := CurrentDateTime;
        AFWAlertRec."Recipient" := AFWSettingsRec."Email Recipient";
        AFWAlertRec.Insert();

        // Call AFW_Alert_Sender to send email notification
        Codeunit.Run(Codename::"AFW Alert Sender", AFWAlertRec);
    end;
    
}
*/
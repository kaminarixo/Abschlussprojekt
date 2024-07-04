table 50101 "AFW Files"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "File Name"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'File Name';
        }
        field(3; "Creation Date"; DateTime)
        {
            DataClassification = ToBeClassified;
            Caption = 'Creation Date';
        }
        field(4; "Status"; Enum "AFW File Status")
        {
            DataClassification = ToBeClassified;
            Caption = 'Status';
        }
        field(5; "Folder Path"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Folder Path';
        }
        field(6; "File Types"; Enum "AFW File Types")
        {
            DataClassification = ToBeClassified;
            Caption = 'File Types';
        }
        field(7; "Email Recipient"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Email Recipient';
            ExtendedDatatype = EMail;
        }
        field(8; "Monitoring Interval"; Enum "AFW Monitoring Interval")
        {
            DataClassification = ToBeClassified;
            Caption = 'Monitoring Interval';
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

    var
        LastPrimaryKey: Code[10];

    trigger OnInsert()
    var
        AFWFiles: Record "AFW Files";
    begin
        if "Primary Key" = '' then begin
            AFWFiles.SetCurrentKey("Primary Key");
            AFWFiles.SetAscending("Primary Key", true);
            if AFWFiles.FindLast() then
                LastPrimaryKey := AFWFiles."Primary Key";
            "Primary Key" := IncStr(LastPrimaryKey);
        end;
    end;

    trigger OnModify()
    begin
        // Optional: Code to perform actions on modify
    end;

    trigger OnDelete()
    begin
        // Optional: Code to perform actions on delete
    end;
}

table 50100 "AFW Settings"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Folder Path"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Folder Path';
            Description = 'The path of the folder to be monitored.';

            trigger OnValidate()
            begin
                if "Folder Path" = '' then
                    Error('Folder Path must not be empty.');
            end;
        }
        field(2; "Monitoring Interval"; Enum "AFW Monitoring Interval")
        {
            DataClassification = ToBeClassified;
            Caption = 'Monitoring Interval (Minutes)';
            Description = 'The interval at which the folder should be monitored.';
        }
        field(3; "File Types"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'File Types';
            Description = 'Comma-separated list of file types to be monitored. Leave empty to monitor all file types.';
        }
        field(4; "Email Recipient"; Text[250])
        {
            DataClassification = ToBeClassified;
            ExtendedDatatype = EMail;
            Caption = 'Email Recipient';
            Description = 'The email address to send alerts to.';

            trigger OnValidate()
            begin
                if "Email Recipient" = '' then
                    Error('Email Recipient must not be empty.');
            end;
        }
    }

    keys
    {
        key(PK; "Folder Path")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        // Optional: Code to initialize default values or perform actions on insert
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

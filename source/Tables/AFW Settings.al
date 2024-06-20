table 50100 "AFW Settings"
{
    DataClassification = ToBeClassified;
    DataPerCompany = false;
    Caption = 'AFW Settings';
    LookupPageId = 50103;

    fields
    {
        field(1; "Folder Path"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Folder Path';
            Description = 'The path of the folder to be monitored.';
            Editable = true;

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
        field(5; "Is Active"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Is Active';
            Description = 'Indicates if the setting is active.';
        }
        field(6; "Last Checked"; DateTime)
        {
            DataClassification = ToBeClassified;
            Caption = 'Last Checked';
            Description = 'The date and time of the last folder check.';
        }
        field(7; "Created By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Created By';
            Description = 'The user who created the setting.';
        }
        field(8; "Created At"; DateTime)
        {
            DataClassification = ToBeClassified;
            Caption = 'Created At';
            Description = 'The date and time when the setting was created.';
        }
        field(9; "Modified By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Modified By';
            Description = 'The user who last modified the setting.';
        }
        field(10; "Modified At"; DateTime)
        {
            DataClassification = ToBeClassified;
            Caption = 'Modified At';
            Description = 'The date and time when the setting was last modified.';
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
        "Created By" := UserId();
        "Created At" := CurrentDateTime();
    end;

    trigger OnModify()
    begin
        // Optional: Code to perform actions on modify
        "Modified By" := UserId();
        "Modified At" := CurrentDateTime();
    end;

    trigger OnDelete()
    begin
        // Optional: Code to perform actions on delete
    end;
}

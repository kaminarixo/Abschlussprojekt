table 50100 "EDI Settings"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Folder Path"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Folder Path';
        }
        field(2; "Monitoring Interval"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Monitoring Interval (Minutes)';
        }
        field(3; "File Types"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'File Types';
        }
        field(4; "Email Recipient"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Email Recipient';
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

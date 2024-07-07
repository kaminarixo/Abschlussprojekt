table 50102 "AFW Alerts"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Primary key';
            Description = 'This is the primary key';
        }
        field(2; "File Name"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'File Name';
        }
        field(3; "Alert Timestamp"; DateTime)
        {
            DataClassification = ToBeClassified;
            Caption = 'Alert Timestamp';
        }
        field(4; "Recipient"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Recipient';
        }
    }

    keys
    {
        key(PK; "File Name", "Alert Timestamp")
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

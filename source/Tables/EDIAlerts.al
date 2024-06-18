table 50102 "EDI Alerts"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "File Name"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'File Name';
        }
        field(2; "Alert Timestamp"; DateTime)
        {
            DataClassification = ToBeClassified;
            Caption = 'Alert Timestamp';
        }
        field(3; "Recipient"; Text[250])
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

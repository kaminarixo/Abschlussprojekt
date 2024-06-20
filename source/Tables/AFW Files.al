table 50101 "AFW Files"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "File Name"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'File Name';
        }
        field(2; "Creation Date"; DateTime)
        {
            DataClassification = ToBeClassified;
            Caption = 'Creation Date';
        }
        field(3; "Status"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Status';
            OptionMembers = Pending,Processed,Error;
        }
    }

    keys
    {
        key(PK; "File Name")
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

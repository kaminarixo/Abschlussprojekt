table 50103 "AFW File Types"
{
    DataClassification = ToBeClassified;
    Caption = 'AFW File Types', Comment = 'DEU="AFW Datentypen"';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Primary key', Comment = 'DEU="Primärschlüssel"';
            Description = 'Dies ist der Primärschlüssel.';
        }
        field(2; "Description"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Description', Comment = 'DEU="Beschreibung"';
            Description = 'Die Beschreibung des Dateityps.';
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}
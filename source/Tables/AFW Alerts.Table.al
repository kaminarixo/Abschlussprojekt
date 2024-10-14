table 50102 "AFW Alerts"
{
    DataClassification = ToBeClassified;
    Caption = 'AFW Alerts', Comment = 'DEU="AFW Meldungen"';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Primary key', Comment = 'DEU="Primärschlüssel"';
            Description = 'Dies ist der Primärschlüssel';
        }
        field(2; "File ID"; Guid)
        {
            DataClassification = ToBeClassified;
            Caption = 'File ID', Comment = 'DEU="Datei-ID"';
            Description = 'Die eindeutige ID der Datei, die den Alarm ausgelöst hat';
        }
        field(3; "Alert Timestamp"; DateTime)
        {
            DataClassification = ToBeClassified;
            Caption = 'Alert Timestamp', Comment = 'DEU="Alarmzeitstempel"';
            Description = 'Der Zeitstempel, wann der Alarm ausgelöst wurde';
        }
        field(4; "Alert Message"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Alert Message', Comment = 'DEU="Alarmnachricht"';
            Description = 'Die Nachricht, die den Alarm beschreibt';
        }
        field(5; "Recipient"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Recipient', Comment = 'DEU="Empfänger"';
            Description = 'Die E-Mail-Adresse des Empfängers für den Alarm';
        }
        field(6; "File Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Description = 'Der Name der Datei, bei der es einen Fehler gab';
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        AFWFunctions: Codeunit "AFW Functions";
    begin
        if Rec."Primary Key" = '' then
            Rec."Primary Key" := AFWFunctions.GenerateNextPrimaryKey(Rec);
    end;
}
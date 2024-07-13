table 50101 "AFW Jobs"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Primary key', Comment = 'DEU="Primärschlüssel"';
            Description = 'Dies ist der Primärschlüssel';
        }
        field(2; "Job Name"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Job Name', Comment = 'DEU="Jobname"';
            Description = 'Der Name des Jobs';

        }
        field(3; "Status"; Enum "AFW Job Status")
        {
            DataClassification = ToBeClassified;
            Caption = 'Status', Comment = 'DEU="Status"';
            Description = 'Der aktuelle Status des Jobs';
        }
        field(4; "Folder Path"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Folder Path', Comment = 'DEU="Ordnerpfad"';
            Description = 'Der Pfad des Ordners, der überwacht wird';
        }
        field(5; "File Types"; Enum "AFW File Types")
        {
            DataClassification = ToBeClassified;
            Caption = 'File Types', Comment = 'DEU="Dateitypen"';
            Description = 'Die Dateitypen, die im Ordner überwacht werden';

        }
        field(6; "Email Recipient"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Email Recipient', Comment = 'DEU="E-Mail-Empfänger"';
            ExtendedDatatype = EMail;
            Description = 'Die E-Mail-Adresse des Empfängers für Benachrichtigungen';

        }
        field(7; "Monitoring Interval"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Monitoring Interval', Comment = 'DEU="Überwachungsintervall"';
            Description = 'Das Intervall, in dem der Ordner überwacht wird, in Minuten.';

        }
        field(8; "Minutes Between Emails"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Minutes Between Emails', Comment = 'DEU="Minuten zwischen E-Mails"';
            Description = 'Die Anzahl der Minuten, die zwischen dem Senden von E-Mails bei einem Fehler gewartet werden soll';

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
        LastPrimaryKey: Code[10];
        AFWJobs: Record "AFW Jobs";
    begin
        If AFWJobs.Count() = 0 then
            Rec."Primary Key" := '1'
        else
            If Rec."Primary Key" = '' then begin
                AFWJobs.SetCurrentKey("Primary Key");
                AFWJobs.SetAscending("Primary Key", true);
                if AFWJobs.FindLast() then
                    LastPrimaryKey := AFWJobs."Primary Key";
                Rec."Primary Key" := IncStr(LastPrimaryKey);
            end;

    end;
}

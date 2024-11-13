table 50101 "AFW Jobs"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Primary key', Comment = 'DEU="Primärschlüssel"';
            Description = 'Dies ist der Primärschlüssel.';
        }
        field(2; "Job Name"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Job Name', Comment = 'DEU="Jobname"';
            Description = 'Der Name des Jobs.';
        }
        field(3; "Status"; Enum "AFW Job Status")
        {
            DataClassification = ToBeClassified;
            Caption = 'Status', Comment = 'DEU="Status"';
            Description = 'Der aktuelle Status des Jobs.';
        }
        field(4; "Folder Path"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Folder Path', Comment = 'DEU="Ordnerpfad"';
            Description = 'Der Pfad des Ordners, der überwacht wird.';
        }
        field(5; "File Types"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'File Types', Comment = 'DEU="Dateitypen"';
            TableRelation = "AFW File Types"."Primary Key";
            trigger OnLookup()
            var
                AFWFileTypes: Record "AFW File Types";
                AFWFileTypesList: Page "AFW File Types List";
            begin
                // Setze die Ansicht für die Dateitypenliste
                AFWFileTypesList.SetTableView(AFWFileTypes);
                AFWFileTypesList.LookupMode(true);
                if AFWFileTypesList.RunModal() = Action::LookupOK then begin
                    // Hole den ausgewählten Dateityp
                    AFWFileTypesList.GetRecord(AFWFileTypes);
                    Rec."File Types" := AFWFileTypes."Primary Key";
                end;
            end;
        }
        field(6; "Email Recipient"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Email Recipient', Comment = 'DEU="E-Mail-Empfänger"';
            ExtendedDatatype = EMail;
            Description = 'Die E-Mail-Adresse des Empfängers für Benachrichtigungen.';
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
            Description = 'Die Anzahl der Minuten, die zwischen dem Senden von E-Mails bei einem Fehler gewartet werden soll.';
        }
        field(9; "Last Checked"; DateTime)
        {
            DataClassification = ToBeClassified;
            Caption = 'Last Checked', Comment = 'DEU="Zuletzt überprüft"';
            Description = 'Der Zeitpunkt der letzten Überprüfung des Ordners.';
        }
        field(10; "Last EMail Sent"; DateTime)
        {
            DataClassification = ToBeClassified;
            Caption = 'Last E-Mail sent', Comment = 'DEU="Zuletzt gesendete E-Mail"';
            Description = 'Der Zeitpunkt der zuletzt gesendeten E-Mail.';
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
        NoSeriesManagement: Codeunit "No. Series";
    begin
        // Generiere den nächsten Primärschlüssel für den Job
        Rec."Primary Key" := NoSeriesManagement.GetNextNo('AFW Jobs NS', Today, true);
    end;
}
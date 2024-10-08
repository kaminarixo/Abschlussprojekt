table 50100 "AFW Setup"
{
    DataClassification = ToBeClassified;
    DataPerCompany = false;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Primary key', Comment = 'DEU="Primärschlüssel"';
            Description = 'Dies ist der Primärschlüssel.';
        }
        field(2; "Enable Monitoring"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Enable Monitoring', Comment = 'DEU="Überwachung aktivieren"';
            Description = 'Ein Schalter, um die Überwachung global zu aktivieren oder zu deaktivieren.';
        }
        field(3; "Enable Logging"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Enable Logging', Comment = 'DEU="Protokollierung aktivieren"';
            Description = 'Ein Schalter, um die Protokollierung von Ereignissen zu aktivieren oder zu deaktivieren.';
        }
        field(4; "Sender's Address"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Sender''s Address', Comment = 'DEU="Absenderadresse"';
            Description = 'Die E-Mail-Adresse, von der die E-Mails gesendet werden sollen.';

            trigger OnLookup()
            var
                EmailAccountVar: Record "Email Account";
            begin
                EmailAccountVar.Reset();
                if Page.RunModal(Page::"Email Accounts", EmailAccountVar) = Action::LookupOK then
                    "Sender's Address" := EmailAccountVar."Email Address";
            end;
        }
        field(5; "Log File Path"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Log File Path', Comment = 'DEU="Protokolldateipfad"';
            Description = 'Der Pfad, in dem die Protokolldateien gespeichert werden sollen.';
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

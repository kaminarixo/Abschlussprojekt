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
            trigger OnValidate()
            var
                AFWFunctions: Codeunit "AFW Functions";
            begin
                // Überprüfen, ob die Überwachung deaktiviert werden soll
                if not Rec."Enable Monitoring" then
                    if not AFWFunctions.ConfirmDeactivation(Rec) then begin
                        // Aktion abgebrochen
                        Message('Aktion abgebrochen.');
                        "Enable Monitoring" := true;
                    end else
                        // Überwachungsjobs stoppen
                        AFWFunctions.StopMonitoringJobs();
            end;
        }
        field(3; "Sender's Address"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Sender''s Address', Comment = 'DEU="Absenderadresse"';
            Description = 'Die E-Mail-Adresse, von der die E-Mails gesendet werden sollen.';

            trigger OnLookup()
            var
                EmailAccountVar: Record "Email Account";
            begin
                // E-Mail-Konten anzeigen und Absenderadresse auswählen
                EmailAccountVar.Reset();
                if Page.RunModal(Page::"Email Accounts", EmailAccountVar) = Action::LookupOK then
                    "Sender's Address" := EmailAccountVar."Email Address";
            end;
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
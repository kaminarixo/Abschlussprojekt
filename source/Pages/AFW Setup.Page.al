page 50100 "AFW Setup"
{
    PageType = Card;
    UsageCategory = Administration;
    SourceTable = "AFW Setup";
    ApplicationArea = All;
    Caption = 'AFW Setup', Comment = 'DEU="AFW Einrichtung"';
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = true;
    Editable = true;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General Settings', Comment = 'DEU="Allgemeine Einstellungen"';

                field("Enable Monitoring"; Rec."Enable Monitoring")
                {
                    ApplicationArea = All;
                    ToolTip = 'Globally enable or disable monitoring.', Comment = 'DEU="Überwachung global aktivieren oder deaktivieren."';
                    Editable = true;
                }
                field("Enable Logging"; Rec."Enable Logging")
                {
                    ApplicationArea = All;
                    ToolTip = 'Enable or disable logging of events.', Comment = 'DEU="Protokollierung von Ereignissen aktivieren oder deaktivieren."';
                    Editable = true;
                }
                field("Sender's Address"; Rec."Sender's Address")
                {
                    ApplicationArea = All;
                    ToolTip = 'The email address from which to send emails.', Comment = 'DEU="Die E-Mail-Adresse, von der die E-Mails gesendet werden sollen."';
                    Editable = true;
                }
                field("Log File Path"; Rec."Log File Path")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specify the path where the log files should be stored.', Comment = 'DEU="Geben Sie den Pfad an, in dem die Protokolldateien gespeichert werden sollen."';
                    Editable = true;
                }
            }
            group(EmailBodies)
            {
                Caption = 'Email Bodies', Comment = 'DEU="E-Mail-Bodys"';

                field(ErrorEmailBody; Rec."Error Email Body")
                {
                    ApplicationArea = All;
                    Caption = 'Error Email Body', Comment = 'DEU="Fehler-E-Mail-Body"';
                    ToolTip = 'The body of the email for error messages.', Comment = 'DEU="Der Body der E-Mail für Fehlermeldungen."';
                    MultiLine = true;
                }
                field(WarningEmailBody; Rec."Warning Email Body")
                {
                    ApplicationArea = All;
                    Caption = 'Warning Email Body', Comment = 'DEU="Warnung-E-Mail-Body"';
                    ToolTip = 'The body of the email for warning messages.', Comment = 'DEU="Der Body der E-Mail für Warnmeldungen."';
                    MultiLine = true;
                }
                field(InfoEmailBody; Rec."Info Email Body")
                {
                    ApplicationArea = All;
                    Caption = 'Info Email Body', Comment = 'DEU="Info-E-Mail-Body"';
                    ToolTip = 'The body of the email for informational messages.', Comment = 'DEU="Der Body der E-Mail für Informationsmeldungen."';
                    MultiLine = true;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(CreateNumberSeries)
            {
                ApplicationArea = All;
                Caption = 'Create No. Series', Comment = 'DEU="Nummernserien erstellen"';
                ToolTip = 'Erstellt die notwendigen Nummernserien für die Erweiterung.';
                Image = Setup;

                trigger OnAction()
                var
                    AFWFunctions: Codeunit "AFW Functions";
                begin
                    AFWFunctions.CreateOrCheckNumberSeries();
                end;
            }
            action(CreateJobQueue)
            {
                ApplicationArea = All;
                Caption = 'Create Job Queue Job', Comment = 'DEU="Job bei der Aufgabenwarteschlange erstellen"';
                ToolTip = 'Erstellt den notwendigen Eintrag bei der Aufgabenwarteschlangeposten für die Erweiterung.';
                Image = Setup;

                trigger OnAction()
                var
                    AFWFunctions: Codeunit "AFW Functions";
                begin
                    AFWFunctions.CreateOrCheckJobQueue();
                    ;
                end;
            }
            action(SendTestEmail)
            {
                ApplicationArea = All;
                Caption = 'Send Test Email', Comment = 'DEU="Test-E-Mail senden"';
                ToolTip = 'Send a test email to verify the sender''s address.', Comment = 'DEU="Senden Sie eine Test-E-Mail, um die Absenderadresse zu überprüfen."';
                Image = Email;

                trigger OnAction()
                var
                    AFWFunctions: Codeunit "AFW Functions";
                    RecipientAddress: Text;
                    EmailInputPage: Page "Email Input Page";
                begin
                    EmailInputPage.SetSenderAddress(Rec."Sender's Address");
                    if EmailInputPage.RunModal() = Action::OK then begin
                        EmailInputPage.GetRecipientAddress(RecipientAddress);
                        AFWFunctions.SendTestEmail(Rec."Sender's Address", RecipientAddress);
                    end;
                end;
            }
            action(CheckFile)
            {
                ApplicationArea = All;
                Caption = 'Check file', Comment = 'DEU="Datei prüfen"';
                ToolTip = 'Test the file for its existence and accessibility', Comment = 'DEU="Testen Sie die Datei auf seine Existenz und Erreichbarkeit"';
                Image = AnalysisView;
                trigger OnAction()
                var
                    AFWFunctions: Codeunit "AFW Functions";
                begin
                    AFWFunctions.CheckFile(Rec."Log File Path");
                end;
            }
            action(CheckPath)
            {
                ApplicationArea = All;
                Caption = 'Check directory', Comment = 'DEU="Pfad prüfen"';
                ToolTip = 'Test the directory for its existence and accessibility', Comment = 'DEU="Testen Sie den Pfad auf seine Existenz und Erreichbarkeit"';
                Image = AnalysisView;
                trigger OnAction()
                var
                    AFWFunctions: Codeunit "AFW Functions";
                begin
                    AFWFunctions.CheckPath(Rec."Log File Path");
                end;
            }
            action(CheckJobs)
            {
                ApplicationArea = All;
                Caption = 'Check jobs', Comment = 'DEU="Jobs prüfen"';
                ToolTip = 'Test the jobs for its existence and accessibility', Comment = 'DEU="Testen Sie die Jobs auf seine Existenz und Erreichbarkeit"';
                Image = AnalysisView;
                trigger OnAction()
                var
                    AFWFunctions: Codeunit "AFW Functions";
                begin
                    AFWFunctions.CheckJobs;
                end;
            }
        }
    }
    trigger OnOpenPage()
    var
        AFWFunctions: Codeunit "AFW Functions";
    begin
        AFWFunctions.InitializeSetup(Rec);
    end;
}
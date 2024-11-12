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
                field("Sender's Address"; Rec."Sender's Address")
                {
                    ApplicationArea = All;
                    ToolTip = 'The email address from which to send emails.', Comment = 'DEU="Die E-Mail-Adresse, von der die E-Mails gesendet werden sollen."';
                    Editable = true;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Setup)
            {
                ApplicationArea = All;
                Caption = 'Setup', Comment = 'DEU="Vorbereitung"';
                Image = Setup;
                Tooltip = 'Complete all important preparations.', Comment = 'DEU="Führen Sie alle wichtigen Vorbereitungen aus."';

                trigger OnAction()
                var
                    AFWFunctions: Codeunit "AFW Functions";
                begin
                    AFWFunctions.Setup();
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
        }
    }
    trigger OnOpenPage()
    var
        AFWFunctions: Codeunit "AFW Functions";
    begin
        AFWFunctions.InitializeSetup(Rec);
    end;
}
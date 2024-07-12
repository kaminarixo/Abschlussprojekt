page 50100 "AFW Setup"
{
    PageType = Card;
    UsageCategory = Administration;
    SourceTable = "AFW Settings";
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
                    ToolTip = 'The email address from which to send emails.', Comment = 'DEU="Die E-Mail-Adresse, von der die E-Mails gesendert werden sollen."';
                    Editable = true;
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        if not Rec.Get() then begin
            Rec.Init();
            Rec."Primary Key" := '';
            Rec.Insert(true);
        end;
    end;
}

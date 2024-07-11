page 50100 "AFW Setup"
{
    PageType = Card;
    UsageCategory = Administration;
    SourceTable = "AFW Settings";
    ApplicationArea = All;
    Caption = 'AFW Setup';
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = true;

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
                field("Log File Path"; Rec."Log File Path")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specify the path where the log files should be stored.', Comment = 'DEU="Geben Sie den Pfad an, in dem die Protokolldateien gespeichert werden sollen."';
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

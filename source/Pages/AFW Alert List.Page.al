page 50102 "AFW Alert List"
{
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "AFW Alerts";
    Caption = 'AFW Alert List', Comment = 'DEU="AFW Meldungsliste"';
    ModifyAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Primary Key"; Rec."Primary Key")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the primary key of the alert.', Comment = 'DEU="Gibt den Primärschlüssel der Fehlermeldung an."';
                }
                field("Job Code"; Rec."Job Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Job Code', Comment = 'DEU="Gibt den Job Code des Jobs an."';
                }
                field("File Name"; Rec."File Name")
                {
                    ApplicationArea = All;
                    Caption = 'File Name', Comment = 'DEU="Dateiname"';
                    ToolTip = 'Specifies the name of the file that triggered the alert.', Comment = 'DEU="Gibt den Namen der Datei an, die den Alarm ausgelöst hat."';
                }
                field("Alert Timestamp"; Rec."Alert Timestamp")
                {
                    ApplicationArea = All;
                    Caption = 'Alert Timestamp', Comment = 'DEU="Alarmzeitstempel"';
                    ToolTip = 'Specifies the timestamp when the alert was triggered.', Comment = 'DEU="Gibt den Zeitstempel an, wann der Alarm ausgelöst wurde."';
                }
                field("Recipient"; Rec."Recipient")
                {
                    ApplicationArea = All;
                    Caption = 'Recipient', Comment = 'DEU="Empfänger"';
                    ToolTip = 'Specifies the email address of the recipient for the alert.', Comment = 'DEU="Gibt die E-Mail-Adresse des Empfängers für den Alarm an."';
                }
                field("Alert Message"; Rec."Alert Message")
                {
                    ApplicationArea = All;
                    Caption = 'Alert Message', Comment = 'DEU="Alarmnachricht"';
                    ToolTip = 'Specifies the message that describes the alert.', Comment = 'DEU="Gibt die Nachricht an, die den Alarm beschreibt."';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Refresh List")
            {
                ApplicationArea = All;
                Caption = 'Refresh List', Comment = 'DEU="Liste aktualisieren"';
                ToolTip = 'Refreshes the list of alerts.', Comment = 'DEU="Aktualisiert die Liste der Alarme."';
                Image = Refresh;

                trigger OnAction()
                begin
                    CurrPage.Update(true);
                end;
            }
            action("Report")
            {
                ApplicationArea = All;
                Caption = 'Report', Comment = 'DEU="Bericht"';
                Tooltip = 'A report on the alerts.', Comment = 'DEU="Ein Bericht über die Meldungen."';
                Image = Report;

                trigger OnAction()
                var
                    AFWAlertReport: Report "AFW Alert Report";
                begin
                    AFWAlertReport.Run();
                end;
            }


        }
    }
}
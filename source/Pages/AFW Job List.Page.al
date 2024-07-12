page 50101 "AFW Job List"
{
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "AFW Jobs";
    ApplicationArea = All;
    Caption = 'AFW Job List', Comment = 'DEU="AFW Job Liste"';
    CardPageId = "AFW Job Card";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                Caption = 'General', Comment = 'DEU="Allgemein"';

                field("Primary Key"; Rec."Primary Key")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the primary key of the job.', Comment = 'DEU="Gibt den Primärschlüssel des Jobs an."';
                }
                field("Job Name"; Rec."Job Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the job.', Comment = 'DEU="Gibt den Namen des Jobs an."';
                }
                field("Status"; Rec."Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the current status of the job.', Comment = 'DEU="Gibt den aktuellen Status des Jobs an."';
                }
                field("Folder Path"; Rec."Folder Path")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the path of the folder to be monitored.', Comment = 'DEU="Gibt den Pfad des zu überwachenden Ordners an."';
                }
                field("File Types"; Rec."File Types")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the file types to be monitored. Leave empty to monitor all file types.', Comment = 'DEU="Gibt die zu überwachenden Dateitypen an. Lassen Sie das Feld leer, um alle Dateitypen zu überwachen."';
                }
                field("Email Recipient"; Rec."Email Recipient")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the email address to send alerts to.', Comment = 'DEU="Gibt die E-Mail-Adresse an, an die Benachrichtigungen gesendet werden sollen."';
                }
                field("Monitoring Interval"; Rec."Monitoring Interval")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the interval at which the folder should be monitored.', Comment = 'DEU="Gibt das Intervall an, in dem der Ordner überwacht werden soll."';
                }
                field("Minutes Between Emails"; Rec."Minutes Between Emails")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of minutes to wait between sending emails on error.', Comment = 'DEU="Gibt die Anzahl der Minuten an, die zwischen dem Senden von E-Mails bei einem Fehler gewartet werden soll."';
                }
            }
        }
    }
}
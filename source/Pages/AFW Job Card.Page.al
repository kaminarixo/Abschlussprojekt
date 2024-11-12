page 50103 "AFW Job Card"
{
    PageType = Card;
    SourceTable = "AFW Jobs";
    ApplicationArea = All;
    Caption = 'AFW Job Creation', Comment = 'DEU="AFW Job Erstellung"';
    layout
    {
        area(content)
        {
            group(JobInformation)
            {
                Caption = 'Job Information', Comment = 'DEU="Job-Informationen"';
                field("Job Name"; Rec."Job Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specify the name of the job.', Comment = 'DEU="Geben Sie den Namen des Jobs an."';
                    NotBlank = true;
                }
                field("Status"; Rec."Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'The current status of the job.', Comment = 'DEU="Der aktuelle Status des Jobs."';
                    Editable = false;
                }
            }
            group(MonitoringDetails)
            {
                Caption = 'Monitoring Details', Comment = 'DEU="Überwachungsdetails"';
                field("Folder Path"; Rec."Folder Path")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specify the path of the folder to be monitored.', Comment = 'DEU="Geben Sie den Pfad des zu überwachenden Ordners an."';
                    NotBlank = true;
                    trigger OnValidate()
                    var
                        AFWFunctions: Codeunit "AFW Functions";
                    begin
                        AFWFunctions.CheckPath(Rec."Folder Path");
                    end;
                }
                field("File Types"; Rec."File Types")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specify the file types to be monitored. Leave empty to monitor all file types.', Comment = 'DEU="Geben Sie die zu überwachenden Dateitypen an. Lassen Sie das Feld leer, um alle Dateitypen zu überwachen."';
                }
            }
            group(NotificationSettings)
            {
                Caption = 'Notification Settings', Comment = 'DEU="Benachrichtigungseinstellungen"';
                field("Email Recipient"; Rec."Email Recipient")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specify the email address to send alerts to.', Comment = 'DEU="Geben Sie die E-Mail-Adresse an, an die Benachrichtigungen gesendet werden sollen."';
                    NotBlank = true;
                }
                field("Monitoring Interval"; Rec."Monitoring Interval")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specify the interval at which the folder should be monitored.', Comment = 'DEU="Geben Sie das Intervall an, in welchem der Ordner überwacht werden soll."';
                    NotBlank = true;
                }
                field("Minutes Between Emails"; Rec."Minutes Between Emails")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specify the number of minutes to wait between sending emails on error.', Comment = 'DEU="Geben Sie die Anzahl der Minuten an, die zwischen dem Senden von E-Mails bei einem Fehler gewartet werden soll."';
                    NotBlank = true;
                }

            }
        }
    }
}
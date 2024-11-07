page 50101 "AFW Job List"
{
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "AFW Jobs";
    ApplicationArea = All;
    Caption = 'AFW Job List', Comment = 'DEU="AFW Job Liste"';
    CardPageId = "AFW Job Card";
    InsertAllowed = true;
    ModifyAllowed = false;
    DeleteAllowed = false;

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
                    ToolTip = 'Specifies the interval at which the folder should be monitored.', Comment = 'DEU="Das Intervall, in dem der Ordner überwacht wird, in Minuten."';
                }
                field("Minutes Between Emails"; Rec."Minutes Between Emails")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of minutes to wait between sending emails on error.', Comment = 'DEU="Gibt die Anzahl der Minuten an, die zwischen dem Senden von E-Mails bei einem Fehler gewartet werden soll."';
                }
                field("Last Checked"; Rec."Last Checked")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the timestamp of the last check of the folder.', Comment = 'DEU="Gibt den Zeitstempel der letzten Überprüfung des Ordners an."';
                }
                field("Last EMail Sent"; Rec."Last EMail Sent")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the timestamp of the last sent E-Mail', Comment = 'DEU="Gibt den Zeitstempel der zuletzt gesendeten Fehler Mail an."';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(SetJobToReady)
            {
                ApplicationArea = All;
                Caption = 'Set Job to Ready', Comment = 'DEU="Job auf Ready setzen"';
                ToolTip = 'Set the job status to Ready if all entries are correct.', Comment = 'DEU="Setze den Jobstatus auf Ready, wenn alle Einträge korrekt sind."';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    AFWFunctions: Codeunit "AFW Functions";
                    AFWJobs: Record "AFW Jobs";
                begin
                    // Überprüfen, ob ein Eintrag ausgewählt ist
                    if not AFWJobs.Get(Rec."Primary Key") then
                        Error('Es wurde kein Job ausgewählt.');

                    // Aufruf der Funktion in der CodeUnit
                    AFWFunctions.SetJobStatusToReady(AFWJobs);

                    // Aktualisieren der Liste
                    CurrPage.Update(false);
                end;
            }

            action(SetJobToStopped)
            {
                ApplicationArea = All;
                Caption = 'Set Job to Stopped', Comment = 'DEU="Job auf Stopped setzen"';
                ToolTip = 'Set the job status to Stopped.', Comment = 'DEU="Setze den Jobstatus auf Stopped."';
                Image = Stop;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    AFWFunctions: Codeunit "AFW Functions";
                    AFWJobs: Record "AFW Jobs";
                begin
                    // Überprüfen, ob ein Eintrag ausgewählt ist
                    if not AFWJobs.Get(Rec."Primary Key") then
                        Error('Es wurde kein Job ausgewählt.');

                    // Aufruf der Funktion in der CodeUnit
                    AFWFunctions.SetJobStatusToStopped(AFWJobs);

                    // Aktualisieren der Liste
                    CurrPage.Update();
                end;
            }
        }
    }
}
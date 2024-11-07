dotnet
{
    assembly(mscorlib)
    {
        type(System.IO.Directory; Directory) { }
        type(System.IO.FileInfo; FileInfo) { }
        type(System.String; ListeDotNet) { }
        type(System.Array; ArrayDotNet) { }
    }
}
codeunit 50100 "AFW Functions"
{
    var
        Directory: DotNet Directory;
        FileInfo: DotNet FileInfo;

    trigger OnRun()
    begin
        CheckJobs();
    end;

    // Initialisiert die Setup-Tabelle mit Standardwerten.
    procedure InitializeSetup(var SetupRec: Record "AFW Setup")
    begin
        if not SetupRec.Get() then begin
            SetupRec.Init();
            SetupRec."Primary Key" := '';
            SetupRec."Enable Monitoring" := true; // Standardmäßig aktiviert
            SetupRec."Enable Logging" := true; // Standardmäßig aktiviert
            SetupRec.Insert(true);
        end;
    end;

    procedure CreateOrCheckJobQueue()
    var
        JobQueue: Record "Job Queue Entry";
        JobQueueCategory: Record "Job Queue Category";
        JobQueueCategoryPriority: Enum "Job Queue Priority";
    begin
        // Überprüfen ob es eine Aufgabenwarteschlangekategorie 'AFW' bereits gibt, wenn nicht dann anlegen
        If not JobQueueCategory.Get('AFW') then begin
            JobQueueCategory.Init();
            JobQueueCategory.Code := 'AFW';
            JobQueueCategory.Description := 'AFW - AmouFileWatch';
            JobQueueCategory.Insert(true);
        end;
        // Überprüfen, ob ein Aufgabenwarteschlangenposten für die Codeunit 50100 existiert
        JobQueue.SetRange("Object Type to Run", JobQueue."Object Type to Run"::Codeunit);
        JobQueue.SetRange("Object ID to Run", 50100); // Codeunit 50100
        if JobQueue.IsEmpty() then begin
            // Wenn kein Posten existiert, erstelle einen neuen
            JobQueue.Init();
            JobQueue."Object Type to Run" := JobQueue."Object Type to Run"::Codeunit;
            JobQueue."Object ID to Run" := 50100; // Codeunit 50100
            JobQueue.ID := CreateGuid();
            JobQueue."User ID" := UserId();
            JobQueue.Description := 'Der Job für die Erweiterung AFW';
            JobQueue."Job Queue Category Code" := 'AFW';
            JobQueue."Priority Within Category" := JobQueueCategoryPriority::High;
            JobQueue."Recurring Job" := true;
            JobQueue."Run on Mondays" := true;
            JobQueue."Run on Tuesdays" := true;
            JobQueue."Run on Wednesdays" := true;
            JobQueue."Run on Thursdays" := true;
            JobQueue."Run on Fridays" := true;
            JobQueue."Run on Saturdays" := true;
            JobQueue."Run on Sundays" := true;
            JobQueue."No. of Minutes between Runs" := 1; // Jede Minute
            JobQueue."Maximum No. of Attempts to Run" := 10;
            JobQueue."Starting Time" := 000000T;
            JobQueue."Ending Time" := 235959T;
            JobQueue."Earliest Start Date/Time" := CurrentDateTime;
            JobQueue.Status := JobQueue.Status::Ready;
            JobQueue.Insert(true);
            Message('Aufgabenwarteschlangenposten für Codeunit 50100 wurde erstellt.');
        end else begin
            Message('Aufgabenwarteschlangenposten für Codeunit 50100 existiert bereits.');
        end;
    end;

    procedure CreateOrCheckNumberSeries()
    var
        NoSeries: Record "No. Series";
        NoSeriesLine: Record "No. Series Line";
    begin
        // AFW Alerts NS
        if not NoSeries.Get('AFW Alerts NS') then begin
            NoSeries.Init();
            NoSeries.Code := 'AFW Alerts NS';
            NoSeries.Description := 'Nummernserie für AFW Alerts';
            NoSeries."Date Order" := true;   // Chronologische Vergabe
            NoSeries."Default Nos." := true; // Standardnummern
            NoSeries."Manual Nos." := false; // Manuelle Vergabe
            NoSeries.Insert(true);
            Message('Nummernserie "AFW Alerts NS" wurde erstellt.');
            // Nummernserienzeile für AFW Alerts NS erstellen
            NoSeriesLine.Init();
            NoSeriesLine."Series Code" := 'AFW Alerts NS';
            NoSeriesLine."Line No." := 10000;
            NoSeriesLine."Starting No." := 'Aler100000'; // Startwert
            NoSeriesLine."Ending No." := 'Aler999999'; // Endwert
            NoSeriesLine.Insert(true);
        end else begin
            Message('Nummernserie "AFW Alerts NS" existiert bereits.');
        end;

        // AFW Jobs NS
        if not NoSeries.Get('AFW Jobs NS') then begin
            NoSeries.Init();
            NoSeries.Code := 'AFW Jobs NS';
            NoSeries.Description := 'Nummernserie für AFW Jobs';
            NoSeries."Date Order" := true;   // Chronologische Vergabe
            NoSeries."Default Nos." := true; // Standardnummern
            NoSeries."Manual Nos." := false; // Manuelle Vergabe
            NoSeries.Insert(true);
            Message('Nummernserie "AFW Jobs NS" wurde erstellt.');
            // Nummernserienzeile für AFW Jobs NS erstellen, falls noch nicht vorhanden
            NoSeriesLine.Init();
            NoSeriesLine."Series Code" := 'AFW Jobs NS';
            NoSeriesLine."Line No." := 10000;
            NoSeriesLine."Starting No." := 'Job100000'; // Startwert
            NoSeriesLine."Ending No." := 'Job999999'; // Endwert
            NoSeriesLine.Insert(true);
        end else begin
            Message('Nummernserie "AFW Jobs NS" existiert bereits.');
        end;
    end;

    // Zeigt einen Bestätigungsdialog an, wenn Überwachung oder Protokollierung deaktiviert werden soll.
    procedure ConfirmDeactivation(SetupRec: Record "AFW Setup"): Boolean
    var
        ConfirmMessage: Text;
    begin
        ConfirmMessage := 'Sind Sie sicher, dass Sie die Überwachung/Protokollierung deaktivieren möchten?';
        exit(Confirm(ConfirmMessage, true));
    end;

    // Stoppt alle zugehörigen Jobs, wenn die Überwachung deaktiviert wird.
    procedure StopMonitoringJobs()
    var
        Jobs: Record "AFW Jobs";
        StoppedStatus: Enum "AFW Job Status";
    begin
        // Setze den Status auf "Stopped"
        StoppedStatus := StoppedStatus::Stopped;

        // Finde alle Jobs, die nicht bereits gestoppt sind
        Jobs.SetFilter(Status, '<>%1', StoppedStatus);

        if Jobs.FindSet() then
            repeat
                Jobs.Status := StoppedStatus;
                Jobs.Modify();
            until Jobs.Next() = 0;

        Message('Alle Überwachungsjobs wurden gestoppt.');
    end;

    /// Startet alle zugehörigen Jobs, die gestoppt sind.
    procedure StartMonitoringJobs()
    var
        Jobs: Record "AFW Jobs";
        StartStatus: Enum "AFW Job Status";
    begin
        // Setze den Status auf "Ready"
        StartStatus := StartStatus::Ready;

        // Finde alle Jobs, die gestoppt sind
        Jobs.SetRange(Status, StartStatus::Stopped);

        if Jobs.FindSet() then
            repeat
                Jobs.Status := StartStatus;
                Jobs.Modify();
            until Jobs.Next() = 0;

        Message('Alle Überwachungsjobs wurden gestartet.');
    end;

    // Sendet eine Test-E-Mail von der Setup-Seite aus.
    procedure SendTestEmail(SenderAddress: Text; RecipientAddress: Text)
    var
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        EmailAccount: Record "Email Account";
    begin
        EmailMessage.Create(RecipientAddress, 'Test-E-Mail', 'Dies ist eine Test-E-Mail.', true);
        Email.Send(EmailMessage);
        Message('Test-E-Mail wurde gesendet.');
    end;

    // Bei Fehlern in CheckJobs wird die Mail weggeschickt
    procedure SendEmailNotification(JobRec: Record "AFW Jobs"; FileName: Text)
    var
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        EmailAccount: Record "Email Account";
    begin
        EmailMessage.Create(JobRec."Email Recipient", 'File Change Notification', StrSubstNo('The file %1 has been changed.', FileName), true);
        Email.Send(EmailMessage);
    end;
    // Datei überprüfen
    procedure CheckFile(Pfad: Text)
    begin
        If File.Exists(Pfad) then begin
            Message('Es wurde folgende Datei geprüft:\%1\Die Datei existiert.', Pfad);
        end else
            Message('Es wurde folgende Datei geprüft:\%1\Die Datei existiert nicht.', Pfad);
    end;

    // Pfad überprüfen
    procedure CheckPath(Pfad: Text): Boolean
    var
        PfadVar: File;
    begin
        Pfad := Pfad + '\PathCheckFile.txt';
        if (PfadVar.Create(Pfad)) then begin

        end else begin
            Message('Der Pfad existiert nicht.');
            exit(false);
        end;
        PfadVar.Close();
        File.Erase(Pfad);
        exit(true)

    end;

    // Überprüft den Job und setzt den Status auf "Ready", wenn alle Einträge korrekt sind.
    procedure SetJobStatusToReady(var JobRec: Record "AFW Jobs")
    begin
        // Überprüfen, ob alle Pflichtfelder ausgefüllt sind
        if JobRec."Job Name" = '' then
            Error('Der Jobname darf nicht leer sein.');

        if JobRec."Folder Path" = '' then
            Error('Der Ordnerpfad darf nicht leer sein.');

        if JobRec."Email Recipient" = '' then
            Error('Die E-Mail-Adresse des Empfängers darf nicht leer sein.');

        if JobRec."Monitoring Interval" <= 0 then
            Error('Das Überwachungsintervall muss größer als 0 sein.');

        if JobRec."Minutes Between Emails" <= 0 then
            Error('Die Anzahl der Minuten zwischen E-Mails muss größer als 0 sein.');

        // Wenn alle Überprüfungen erfolgreich sind, setze den Status auf "Ready"
        If CheckPath(JobRec."Folder Path") then begin
            JobRec.Status := JobRec.Status::Ready;
            JobRec.Modify();
        end;
    end;

    // Setzt den Status des Jobs auf "Stopped".
    procedure SetJobStatusToStopped(var JobRec: Record "AFW Jobs")
    begin
        // Setze den Status auf "Stopped"
        JobRec.Status := JobRec.Status::Stopped;
        JobRec.Modify();
    end;

    // Prüft alle Jobs
    // - Wenn Pfad nicht gefunden, dann wird Job auf "Error" gesetzt
    procedure CheckJobs()
    var
        AFWJobs: Record "AFW Jobs";
        Alerts: Record "AFW Alerts";
        FileName: Text;
        Files: DotNet ArrayDotNet;
        File: Text;
        i: Integer;
        FileInfo: DotNet FileInfo;
        CurrentTime: DateTime;
        MonitoringInterval: Duration;
        LastChecked: DateTime;
        NoSeriesManagement: Codeunit "No. Series";
        EmailSent: Boolean;
        EmailInterval: Duration;
    begin
        AFWJobs.SetRange(Status, AFWJobs.Status::Ready);
        if AFWJobs.FindSet() then
            repeat
                EMailSent := false;
                if Directory.Exists(AFWJobs."Folder Path") then begin
                    Files := Directory.GetFiles(AFWJobs."Folder Path");
                    for i := 0 to Files.Length - 1 do begin
                        File := Files.GetValue(i);
                        FileInfo := FileInfo.FileInfo(File);
                        FileName := FileInfo.Name;

                        // Überprüfe, ob die Datei den richtigen Typ hat
                        if IsFileTypeAllowed(AFWJobs."File Types", FileName) then begin
                            // Überprüfe, ob die Datei älter ist als das Überwachungsintervall
                            CurrentTime := CurrentDateTime;
                            MonitoringInterval := AFWJobs."Monitoring Interval" * 60000; // Umrechnung in Millisekunden
                            LastChecked := AFWJobs."Last Checked";

                            if (CurrentTime - FileInfo.LastWriteTime) > MonitoringInterval then begin
                                // Überprüfe, ob die E-Mail bereits innerhalb des Intervalls gesendet wurde
                                EmailInterval := AFWJobs."Minutes Between Emails" * 60000; // Umrechnung in Millisekunden
                                if AFWJobs."Last EMail Sent" = 0DT then begin
                                    // Sende E-Mail, wenn die Datei älter ist als das Intervall
                                    SendEmailNotification(AFWJobs, FileName);
                                    AFWJobs."Last EMail Sent" := CurrentDateTime;
                                    AFWJobs.Modify(true);
                                    EmailSent := true;
                                end else begin
                                    if (CurrentTime - AFWJobs."Last EMail Sent") > EmailInterval then begin
                                        // Sende E-Mail, wenn die Datei älter ist als das Intervall
                                        SendEmailNotification(AFWJobs, FileName);
                                        AFWJobs."Last EMail Sent" := CurrentDateTime;
                                        AFWJobs.Modify(true);
                                        EmailSent := true;
                                    end;
                                end;


                                // Aktualisiere den Zeitstempel der letzten Überprüfung
                                AFWJobs."Last Checked" := CurrentDateTime;
                                AFWJobs.Modify();

                                // Protokolliere den Alarm
                                Alerts.Init();
                                Alerts."Primary Key" := NoSeriesManagement.GetNextNo('AFW Alerts NS', Today, true); // Nummernserie verwenden
                                Alerts."File ID" := CreateGuid();
                                Alerts."Alert Timestamp" := CurrentDateTime;
                                Alerts."Alert Message" := StrSubstNo('Datei %1 ist älter als das Überwachungsintervall.', FileName);
                                Alerts."Recipient" := AFWJobs."Email Recipient";
                                Alerts."File Name" := FileName;
                                Alerts.Insert();
                            end;
                        end;
                    end;

                    // Wenn keine E-Mail gesendet wurde, aktualisiere den Zeitstempel der letzten Überprüfung
                    if not EmailSent then begin
                        AFWJobs."Last Checked" := CurrentDateTime;
                        AFWJobs.Modify();
                    end;
                end else begin
                    AFWJobs.Status := AFWJobs.Status::Error;
                    AFWJobs.Modify();
                    // Protokolliere den Fehler
                    Alerts.Init();
                    Alerts."Primary Key" := NoSeriesManagement.GetNextNo('AFW Alerts NS', Today, true); // Nummernserie verwenden
                    Alerts."File ID" := CreateGuid();
                    Alerts."Alert Timestamp" := CurrentDateTime;
                    Alerts."Alert Message" := StrSubstNo('Pfad %1 wurde nicht gefunden.', AFWJobs."Folder Path");
                    // Wenn Mail versendet wurde, dann Empfänger in Alert Tabelle
                    if EmailSent then begin
                        Alerts."Recipient" := AFWJobs."Email Recipient";
                    end;
                    Alerts."File Name" := '';
                    Alerts.Insert();
                end;
            until AFWJobs.Next() = 0;
    end;

    // Hilfsfunktion zur Überprüfung des Dateityps
    procedure IsFileTypeAllowed(FileTypes: Enum "AFW File Types"; FileName: Text): Boolean
    var
        FileExtension: Text;
        LastDotPos: Integer;
    begin
        if FileTypes = FileTypes::All then
            exit(true);

        // Finde die Position des letzten Punktes im Dateinamen
        LastDotPos := StrLen(FileName);
        while LastDotPos > 0 do begin
            if FileName[LastDotPos] = '.' then
                break;
            LastDotPos -= 1;
        end;

        if LastDotPos = 0 then
            exit(false); // Keine Erweiterung gefunden

        // Extrahiere die Erweiterung
        FileExtension := CopyStr(FileName, StrLen(FileName) - LastDotPos + 1);

        case FileTypes of
            FileTypes::PDF:
                exit(FileExtension = 'pdf');
            FileTypes::DOCX:
                exit(FileExtension = 'docx');
            FileTypes::XLSX:
                exit(FileExtension = 'xlsx');
            FileTypes::TXT:
                exit(FileExtension = 'txt');
            FileTypes::CSV:
                exit(FileExtension = 'csv');
        end;
    end;

    procedure CheckJobsADHOC(var JobRec: Record "AFW Jobs")
    begin

    end;
}
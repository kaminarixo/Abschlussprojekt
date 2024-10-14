codeunit 50100 "AFW Functions"
{
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

    // Generiert den nächsten Primärschlüssel für den Job.
    procedure GenerateNextPrimaryKey(var JobRec: Record "AFW Jobs"): Code[10]
    var
        LastPrimaryKey: Code[10];
        AFWJobs: Record "AFW Jobs";
    begin
        if AFWJobs.Count() = 0 then
            exit('1');

        AFWJobs.SetCurrentKey("Primary Key");
        AFWJobs.SetAscending("Primary Key", true);
        if AFWJobs.FindLast() then
            LastPrimaryKey := AFWJobs."Primary Key";

        exit(IncStr(LastPrimaryKey));
    end;

    // Generiert den nächsten Primärschlüssel für die Alerts.
    procedure GenerateNextPrimaryKey(var AlertsRec: Record "AFW Alerts"): Code[10]
    var
        LastPrimaryKey: Code[10];
        AFWAlerts: Record "AFW Alerts";
    begin
        if AFWAlerts.Count() = 0 then
            exit('1');

        AFWAlerts.SetCurrentKey("Primary Key");
        AFWAlerts.SetAscending("Primary Key", true);
        if AFWAlerts.FindLast() then
            LastPrimaryKey := AFWAlerts."Primary Key";

        exit(IncStr(LastPrimaryKey));
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
            Message('Der Pfad existiert');
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
        JobRec.Status := JobRec.Status::Ready;
        JobRec.Modify();
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
        Jobs: Record "AFW Jobs";
        Path: Text;
        FileManagement: Codeunit "File Management";
    begin
        if Jobs.FindSet() then
            repeat
                Path := Jobs."Folder Path";
                //Sleep(5000);
                If CheckPath(Path) then begin
                    Message('passt');
                end else begin
                    Jobs.Status := Jobs.Status::Error;
                    Jobs.Modify();
                end;


            until Jobs.Next() = 0;
    end;

    // Eintrag als Meldung machen
    procedure CreateErrorDataset()
    begin

    end;
}
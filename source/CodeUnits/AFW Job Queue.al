/*
codeunit 50102 "AFW Job Queue"
{
    Subtype = Normal;

    var
        JobQueueEntry: Record "Job Queue Entry";
        AFWSettingsRec: Record "AFW Settings";

    trigger OnRun()
    begin
        ScheduleJob();
    end;

    local procedure ScheduleJob()
    var
        JobQueueEntry: Record "Job Queue Entry";
        NextRunDateTime: DateTime;
        NextRunDate: Date;
    begin
        if not AFWSettingsRec.FindFirst() then
            Error('AFW Settings not configured.');

        // Berechnen des nächsten Ausführungszeitpunkts basierend auf dem Überwachungsrhythmus
        NextRunDate := CalcDate('+' + Format(AFWSettingsRec."Monitoring Interval") + 'M', Today());
        NextRunDateTime := CreateDateTime(NextRunDate, Time());

        JobQueueEntry.Init();
        JobQueueEntry."Job Queue Category Code" := ''; // Setzen Sie dies auf eine Kategorie, wenn erforderlich
        JobQueueEntry."Object Type to Run" := JobQueueEntry."Object Type to Run"::Codeunit;
        JobQueueEntry."Object ID to Run" := Codeunit::"AFW File Monitor";
        JobQueueEntry."Description" := 'Scheduled AFW File Monitoring';
        JobQueueEntry."Earliest Start Date/Time" := NextRunDateTime;
        JobQueueEntry.Status := JobQueueEntry.Status::Ready;
        JobQueueEntry.Insert();
    end;

    procedure RunWithParameters()
    begin
        ScheduleJob();
    end;
}
*/
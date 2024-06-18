/*
codeunit 50102 "EDI Job Queue"
{
    Subtype = Normal;

    var
        JobQueueEntry: Record "Job Queue Entry";
        EDISettingsRec: Record "EDI Settings";

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
        if not EDISettingsRec.FindFirst() then
            Error('EDI Settings not configured.');

        // Berechnen des nächsten Ausführungszeitpunkts basierend auf dem Überwachungsrhythmus
        NextRunDate := CalcDate('+' + Format(EDISettingsRec."Monitoring Interval") + 'M', Today());
        NextRunDateTime := CreateDateTime(NextRunDate, Time());

        JobQueueEntry.Init();
        JobQueueEntry."Job Queue Category Code" := ''; // Setzen Sie dies auf eine Kategorie, wenn erforderlich
        JobQueueEntry."Object Type to Run" := JobQueueEntry."Object Type to Run"::Codeunit;
        JobQueueEntry."Object ID to Run" := Codeunit::"EDI File Monitor";
        JobQueueEntry."Description" := 'Scheduled EDI File Monitoring';
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
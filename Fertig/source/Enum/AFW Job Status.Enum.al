enum 50100 "AFW Job Status"
{
    Extensible = false;
    Caption = 'AFW Job Status', Comment = 'DEU="AFW Job Status"';

    value(0; Ready)
    {
        Caption = 'Ready', Comment = 'DEU="Bereit"';
    }
    value(1; NotReady)
    {
        Caption = 'Not Ready', Comment = 'DEU="Nicht Bereit"';
    }
    value(2; InProgress)
    {
        Caption = 'In Progress', Comment = 'DEU="In Bearbeitung"';
    }
    value(3; Stopped)
    {
        Caption = 'Stopped', Comment = 'DEU="Gestoppt"';
    }
    value(4; Error)
    {
        Caption = 'Error', Comment = 'DEU="Fehler"';
    }
}
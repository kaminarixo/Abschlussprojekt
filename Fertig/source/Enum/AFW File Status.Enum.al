enum 50100 "AFW Job Status"
{
    Extensible = false;
    Caption = 'AFW Job Status', Comment = 'DEU="AFW Job Status"';

    value(0; Ready)
    {
        Caption = 'Ready', Comment = 'DEU="Bereit"';
    }
    value(1; InProgress)
    {
        Caption = 'In Progress', Comment = 'DEU="In Bearbeitung"';
    }
}
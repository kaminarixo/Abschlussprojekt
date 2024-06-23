enum 50101 "AFW File Status"
{
    Extensible = false;
    Caption = 'AFW File Status';

    value(0; Pending)
    {
        Caption = 'Pending';
    }
    value(1; Processed)
    {
        Caption = 'Processed';
    }
    value(2; Error)
    {
        Caption = 'Error';
    }
}

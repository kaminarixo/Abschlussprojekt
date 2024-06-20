page 50102 "AFW Alert List"
{
    PageType = List;
    ApplicationArea = All;
    SourceTable = "AFW Alerts";
    Caption = 'AmouFileWatch Alert List';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("File Name"; 'File Name')
                {
                    ApplicationArea = All;
                }
                field("Alert Timestamp"; 'Alert Timestamp')
                {
                    ApplicationArea = All;
                }
                field("Recipient"; 'Recipient')
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Refresh List")
            {
                ApplicationArea = All;
                Caption = 'Refresh List';
                trigger OnAction()
                begin
                    CurrPage.Update(true);
                end;
            }
        }
    }
}

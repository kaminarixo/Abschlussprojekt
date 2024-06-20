page 50101 "AFW File List"
{
    PageType = List;
    ApplicationArea = All;
    SourceTable = "AFW Files";
    Caption = 'AmouFileWatch File List';

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
                field("Creation Date"; 'Creation Date')
                {
                    ApplicationArea = All;
                }
                field("Status"; 'Status')
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

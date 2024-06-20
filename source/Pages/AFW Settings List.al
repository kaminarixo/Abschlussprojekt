page 50103 "AFW Settings List"
{
    PageType = List;
    SourceTable = "AFW Settings";
    ApplicationArea = All;
    Caption = 'AFW Settings List';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Folder Path"; 'Folder Path')
                {
                    ApplicationArea = All;
                }
                field("Monitoring Interval"; 'Monitoring Interval')
                {
                    ApplicationArea = All;
                }
                field("File Types"; 'File Types')
                {
                    ApplicationArea = All;
                }
                field("Email Recipient"; 'Email Recipient')
                {
                    ApplicationArea = All;
                }
                field("Is Active"; 'Is Active')
                {
                    ApplicationArea = All;
                }
                field("Last Checked"; 'Last Checked')
                {
                    ApplicationArea = All;
                }
                field("Created By"; 'Created By')
                {
                    ApplicationArea = All;
                }
                field("Created At"; 'Created At')
                {
                    ApplicationArea = All;
                }
                field("Modified By"; 'Modified By')
                {
                    ApplicationArea = All;
                }
                field("Modified At"; 'Modified At')
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
            action("New Setting")
            {
                Caption = 'New Setting';
                ApplicationArea = All;
                ToolTip = 'Create a new AFW Setting.';

                trigger OnAction()
                begin
                    PAGE.RunModal(PAGE::"AFW Setup", Rec);
                end;
            }
        }
    }
}

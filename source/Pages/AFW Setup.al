page 50100 "AFW Setup"
{
    PageType = Card;
    SourceTable = "AFW Settings";
    ApplicationArea = All;
    Caption = 'AFW Setup';

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General Settings';

                field("Enable Monitoring"; Rec."Enable Monitoring")
                {
                    ApplicationArea = All;
                    ToolTip = 'Globally enable or disable monitoring.';
                    Editable = true;
                }
                field("Enable Logging"; Rec."Enable Logging")
                {
                    ApplicationArea = All;
                    ToolTip = 'Enable or disable logging of events.';
                    Editable = true;
                }
                field("Log File Path"; Rec."Log File Path")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specify the path where the log files should be stored.';
                    Editable = true;
                }
            }
        }

        area(factboxes)
        {
            // Optional: Add additional FactBoxes here
        }
    }

    actions
    {
        area(processing)
        {
            action("Test Settings")
            {
                Caption = 'Test Settings';
                ApplicationArea = All;
                ToolTip = 'Test the current settings to ensure they are correct.';
                Image = TestDatabase;

                trigger OnAction()
                begin
                    // Add code to test the settings
                    Message('Settings are correct.');
                end;
            }
        }
    }
}

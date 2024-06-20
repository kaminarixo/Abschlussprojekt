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

                field("Folder Path"; 'Folder Path')
                {
                    ApplicationArea = All;
                    ToolTip = 'Specify the path of the folder to be monitored.';
                }
                field("Monitoring Interval"; 'Monitoring Interval')
                {
                    ApplicationArea = All;
                    ToolTip = 'Specify the interval at which the folder should be monitored.';
                }
                field("File Types"; 'File Types')
                {
                    ApplicationArea = All;
                    ToolTip = 'Specify the file types to be monitored. Leave empty to monitor all file types.';
                }
                field("Email Recipient"; 'Email Recipient')
                {
                    ApplicationArea = All;
                    ToolTip = 'Specify the email address to send alerts to.';
                }
            }
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

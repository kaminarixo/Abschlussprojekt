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
                    Editable = true;
                }
                field("Monitoring Interval"; 'Monitoring Interval')
                {
                    ApplicationArea = All;
                    ToolTip = 'Specify the interval at which the folder should be monitored.';
                    Editable = true;
                }
                field("File Types"; 'File Types')
                {
                    ApplicationArea = All;
                    ToolTip = 'Specify the file types to be monitored. Leave empty to monitor all file types.';
                    Editable = true;
                }
                field("Email Recipient"; 'Email Recipient')
                {
                    ApplicationArea = All;
                    ToolTip = 'Specify the email address to send alerts to.';
                    Editable = true;
                }
                field("Is Active"; 'Is Active')
                {
                    ApplicationArea = All;
                    ToolTip = 'Indicates if the setting is active.';
                    Editable = true;
                }
                field("Last Checked"; 'Last Checked')
                {
                    ApplicationArea = All;
                    ToolTip = 'The date and time of the last folder check.';
                    Editable = false;
                }
                field("Created By"; 'Created By')
                {
                    ApplicationArea = All;
                    ToolTip = 'The user who created the setting.';
                    Editable = false;
                }
                field("Created At"; 'Created At')
                {
                    ApplicationArea = All;
                    ToolTip = 'The date and time when the setting was created.';
                    Editable = false;
                }
                field("Modified By"; 'Modified By')
                {
                    ApplicationArea = All;
                    ToolTip = 'The user who last modified the setting.';
                    Editable = false;
                }
                field("Modified At"; 'Modified At')
                {
                    ApplicationArea = All;
                    ToolTip = 'The date and time when the setting was last modified.';
                    Editable = false;
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

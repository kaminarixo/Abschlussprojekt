page 50100 "EDI Setup"
{
    PageType = Card;
    ApplicationArea = All;
    SourceTable = "EDI Settings";
    Caption = 'EDI Setup';

    layout
    {
        area(content)
        {
            group(Group)
            {
                Caption = 'Settings';
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
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Save Settings")
            {
                ApplicationArea = All;
                Caption = 'Save Settings';
                trigger OnAction()
                begin
                    // Optional: Code to save the settings
                    Message('Settings saved successfully.');
                end;
            }
        }
    }
}

page 50103 "AFW Job Card"
{
    PageType = Card;
    SourceTable = "AFW Files";
    ApplicationArea = All;
    Caption = 'AFW Job Creation';

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Folder Path"; Rec."Folder Path")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specify the path of the folder to be monitored.';
                }
                field("File Types"; Rec."File Types")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specify the file types to be monitored. Leave empty to monitor all file types.';
                }
                field("Email Recipient"; Rec."Email Recipient")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specify the email address to send alerts to.';
                }
                field("Job Status"; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'The current status of the job.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Start Job")
            {
                Caption = 'Start Job';
                ApplicationArea = All;
                ToolTip = 'Start the monitoring job.';

                trigger OnAction()
                begin
                    // Code to start the job
                end;
            }
        }
    }
}

page 50103 "AFW Job Card"
{
    PageType = Card;
    UsageCategory = Tasks;
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

                field("File Name"; Rec."File Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specify the name of the file.';
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'The date and time when the file was created.';
                }
                field("Status"; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'The current status of the job.';
                }
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
                field("Monitoring Interval"; Rec."Monitoring Interval")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specify the interval at which the folder should be monitored.';
                }
            }
        }
    }
}
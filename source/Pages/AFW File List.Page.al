page 50101 "AFW File List"
{
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "AFW Files";
    CardPageId = "AFW Job Card";
    Caption = 'AmouFileWatch File List';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("File Name"; Rec."File Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'The name of the file being monitored.';
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'The date and time when the job was created.';
                }
                field("Status"; Rec."Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'The current status of the file.';
                }
                field("Folder Path"; Rec."Folder Path")
                {
                    ApplicationArea = All;
                    ToolTip = 'The path of the folder containing the file.';
                }
                field("File Types"; Rec."File Types")
                {
                    ApplicationArea = All;
                    ToolTip = 'The file types being monitored.';
                }
                field("Email Recipient"; Rec."Email Recipient")
                {
                    ApplicationArea = All;
                    ToolTip = 'The email recipient for alerts related to this file.';
                }
            }
        }
    }
}


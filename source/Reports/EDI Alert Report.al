report 50100 "EDI Alert Report"
{
    Caption = 'EDI Alert Report';
    ProcessingOnly = false;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("EDI Alerts"; "EDI Alerts")
        {
            column(File_Name; "File Name")
            {

            }
            column(Alert_Timestamp; "Alert Timestamp")
            {

            }
            column("Recipient"; "Recipient")
            {

            }
        }
    }


    requestpage
    {
        layout
        {
            area(content)
            {
                group(Group)
                {
                    field("From Date"; 'FromDate')
                    {
                        ApplicationArea = All;
                    }
                    field("To Date"; 'ToDate')
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }


    }
}
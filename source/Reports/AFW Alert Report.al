report 50100 "EDI Alert Report"
{
    Caption = 'EDI Alert Report';
    ProcessingOnly = false;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'source/Reports/AFW Alert Report.Layout.rdl';

    dataset
    {
        dataitem("Company Information"; "Company Information")
        {
            column(CompanyPicture; CompanyInfoVar.Picture)
            {

            }
            column(CompanyName; Name)
            {

            }
            column(HeutigesDatum; CopyStr(Format(Today), 1, 8))
            {

            }
            column(ReportName; CurrReport.ObjectId())
            {

            }
        }
        dataitem("EDI Alerts"; "EDI Alerts")
        {
            column("File_Name"; "File Name")
            {
                // Caption kann entfernt werden, da sie veraltet ist
            }
            column("Alert_Timestamp"; "Alert Timestamp")
            {
                // Caption kann entfernt werden, da sie veraltet ist
            }
            column("Recipient"; "Recipient")
            {
                // Caption kann entfernt werden, da sie veraltet ist
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
                    field("From Date"; FromDate)
                    {
                        ApplicationArea = All;
                    }
                    field("To Date"; ToDate)
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }
    }

    var
        FromDate: Date;
        ToDate: Date;
        CompanyInfoVar: Record 79;

    trigger OnInitReport()
    begin
        CompanyInfoVar.GET;
        CompanyInfoVar.CalcFields(Picture);
    end;
}

/*
    trigger OnPreReport()
    begin
        if FromDate <> 0D then
            "EDI Alerts".SetRange("Alert Timestamp", CreateDateTime(FromDate, 000000T), CreateDateTime(ToDate, 235959T));
    end;
}
*/

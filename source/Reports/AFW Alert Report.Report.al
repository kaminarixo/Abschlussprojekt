report 50100 "AFW Alert Report"
{
    Caption = 'AFW Alert Report';
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
        dataitem("AFW Alerts"; "AFW Alerts")
        {
            column("File_Name"; "File Name")
            {

            }
            column("Alert_Timestamp"; "Alert Timestamp")
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

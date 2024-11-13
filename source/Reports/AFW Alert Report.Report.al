report 50100 "AFW Alert Report"
{
    // Der Titel des Berichts in Deutsch und Englisch
    Caption = 'AFW Alert Bericht', Comment = 'ENU="AFW Alert Report"';

    // Der Bericht wird nicht nur zur Verarbeitung verwendet, sondern auch angezeigt
    ProcessingOnly = false;

    // Kategorie des Berichts für die Benutzeroberfläche
    UsageCategory = ReportsAndAnalysis;

    // Standardlayout des Berichts (RDLC)
    DefaultLayout = RDLC;

    // Pfad zum RDLC-Layout
    RDLCLayout = 'source/Reports/AFW Alert Report.Layout.rdl';

    dataset
    {
        // Datenelement für die Firmeninformationen
        dataitem("Company Information"; "Company Information")
        {
            // Spalte für das Firmenlogo
            column(CompanyPicture; CompanyInfoVar.Picture)
            {

            }

            // Spalte für den Firmennamen
            column(CompanyName; Name)
            {

            }

            // Spalte für das heutige Datum
            column(HeutigesDatum; CopyStr(Format(Today), 1, 8))
            {

            }

            // Spalte für den Namen des Berichts
            column(ReportName; CurrReport.ObjectId())
            {

            }
        }

        // Datenelement für die AFW Alerts
        dataitem("AFW Alerts"; "AFW Alerts")
        {
            // Spalte für den Dateinamen
            column("File_Name"; "File Name")
            {

            }

            // Spalte für den Zeitstempel des Alarms
            column("Alert_Timestamp"; "Alert Timestamp")
            {

            }

            // Spalte für den Empfänger
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
                    // Feld für das Startdatum
                    field("From Date"; FromDate)
                    {
                        // Anwendungsbereich für das Feld
                        ApplicationArea = All;

                        // Beschreibung in Deutsch und Englisch
                        Caption = 'Von Datum', Comment = 'ENU="From Date"';
                    }

                    // Feld für das Enddatum
                    field("To Date"; ToDate)
                    {
                        // Anwendungsbereich für das Feld
                        ApplicationArea = All;

                        // Beschreibung in Deutsch und Englisch
                        Caption = 'Bis Datum', Comment = 'ENU="To Date"';
                    }
                }
            }
        }
    }

    var
        // Variable für das Startdatum
        FromDate: Date;

        // Variable für das Enddatum
        ToDate: Date;

        // Variable für die Firmeninformationen
        CompanyInfoVar: Record 79;

    // Trigger, der beim Initialisieren des Berichts ausgeführt wird
    trigger OnInitReport()
    begin
        // Firmeninformationen laden
        CompanyInfoVar.GET;

        // Firmenlogo berechnen
        CompanyInfoVar.CalcFields(Picture);
    end;
}
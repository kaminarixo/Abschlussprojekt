page 50105 "AFW File Types List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "AFW File Types";
    Caption = 'AFW File Types', Comment = 'DEU="AFW Datentypen"';

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Primary Key"; Rec."Primary Key")
                {
                    ApplicationArea = All;
                    Caption = 'Primary Key', Comment = 'DEU="Primärschlüssel"';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Description', Comment = 'DEU="Beschreibung"';
                }
            }
        }
    }
}
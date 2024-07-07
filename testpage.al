pageextension 50144 testext extends "Vendor List"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
    }
    trigger OnOpenPage()
    var
        myInt: Codeunit "TestCodeUnit";
    begin
        myInt.Run();
    end;


}
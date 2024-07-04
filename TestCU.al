codeunit 50149 TestCodeUnit
{
    trigger OnRun()
    begin
        MyFile := 'C:\Users\thoma\desktop\EDI';
        //if File.Exists(MyFile) then
        Message('Es hat die Datei %1 gefunden.', MyFile);
    end;

    var
        MyFile: Text[250];
}
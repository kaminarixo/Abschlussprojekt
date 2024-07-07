codeunit 50149 TestCodeUnit
{
    trigger OnRun()
    var
        TestFile: File;
        FileName: Text;
    begin
        FileName := 'C:\TestFolder\TestFile2.txt';
        if exists(FileName) then begin
            TestFile.WriteMode(true);
            TestFile.Open(FileName);
            TestFile.Write('Hello World');
            TestFile.Close;
        end else
            Message('%1 does not exist.', FileName);
    end;
}

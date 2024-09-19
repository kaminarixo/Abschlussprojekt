codeunit 50149 TestCodeUnit
{
    trigger OnRun()
    var
        FilePath: Text;
        FileExists: Boolean;
    begin
        // Dynamische Erstellung des Pfades
        FilePath := STRSUBSTNO('C:\\%1\%2\%3\%4\%5', 'Users', 'thoma', 'desktop', 'EDI', 'Test.txt');

        // Debugging-Meldung, um sicherzustellen, dass der Pfad korrekt verwendet wird
        Message('Überprüfe Datei: %1', FilePath);

        // Verwenden Sie die File.Exists Methode zur Überprüfung der Datei
        FileExists := File.Exists(FilePath);
        Message('Prüfung abgeschlossen: %1', Format(FileExists));

        if FileExists then
            Message('Datei existiert.')
        else
            Message('Datei existiert nicht.');
    end;
}

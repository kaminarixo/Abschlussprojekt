codeunit 50101 "AFW Alert Sender"
{
    Subtype = Normal;

    var
        EmailAccount: Record "Email Account";
        Emailmessage: Codeunit "Email Message";
        usersetup: Record "User Setup";
        BodyMessage: Text;
        AddBodyMessage: Text;
        EmailSend: Codeunit Email;
        Recipients: List of [Text];

    trigger OnRun()
    begin
        // Code to execute when this Codeunit is called directly
    end;

    local procedure SendAlertEmail(FileName: Text[250]; AlertTimestamp: DateTime; Recipient: Text[250])
    begin
        // Reset and find the SMTP email account
        EmailAccount.Reset();
        EmailAccount.SetFilter("Connector", 'SMTP');
        if EmailAccount.FindLast() then begin
            // Prepare the email body
            Clear(BodyMessage);
            Clear(AddBodyMessage);
            BodyMessage := StrSubstNo('An alert has been triggered for the file: %1 at %2.', FileName, Format(AlertTimestamp));
            AddBodyMessage := '<br/><br/>This is an automatically generated email. Please do not reply to this email.<br/>';

            // Add recipient
            Recipients.Add(Recipient);

            // Create and send the email
            Emailmessage.Create(Recipients, 'AFW Alert Notification', BodyMessage + AddBodyMessage, true);
            EmailSend.Send(Emailmessage, Enum::"email scenario"::Default);
        end else
            Error('SMTP Email Account not configured.');
    end;

    procedure RunWithParameters(FileName: Text[250]; AlertTimestamp: DateTime; Recipient: Text[250])
    begin
        SendAlertEmail(FileName, AlertTimestamp, Recipient);
    end;
}

codeunit 50101 "EDI Alert Sender"
{
    Subtype = Normal;

    trigger OnRun()
    begin
        // Code to execute when this Codeunit is called directly
    end;

    local procedure SendAlertEmail(FileName: Text[250]; AlertTimestamp: DateTime; Recipient: Text[250])
    var
        SMTPMail: Codeunit "Email Message";
        MailSetup: Record "Email Account";
        Body: Text[1024];
    begin
        // Check if SMTP Mail Setup is configured
        if not MailSetup.Get() then
            Error('SMTP Mail Setup is not configured.');

        // Prepare the email body
        Body := StrSubstNo('An alert has been triggered for the file: %1 at %2.', FileName, Format(AlertTimestamp));

        // Send the email
        SMTPMail.CreateMessage(
            MailSetup."From Address",
            Recipient,
            'EDI Alert Notification',
            Body,
            false);
        SMTPMail.Send();
    end;

    procedure RunWithParameters(FileName: Text[250]; AlertTimestamp: DateTime; Recipient: Text[250])
    begin
        SendAlertEmail(FileName, AlertTimestamp, Recipient);
    end;
}

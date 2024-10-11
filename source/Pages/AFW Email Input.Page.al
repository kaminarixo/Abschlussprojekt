page 50104 "Email Input Page"
{
    PageType = StandardDialog;
    Caption = 'Enter Recipient Email Address', Comment = 'DEU="Empfänger-E-Mail-Adresse eingeben"';
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field(RecipientAddress; RecipientAddress)
                {
                    ApplicationArea = All;
                    Caption = 'Recipient Email Address', Comment = 'DEU="Empfänger-E-Mail-Adresse"';
                    ToolTip = 'Enter the email address of the recipient.', Comment = 'DEU="Geben Sie die E-Mail-Adresse des Empfängers ein."';
                }
            }
        }
    }

    var
        RecipientAddress: Text;
        SenderAddress: Text;

    procedure SetSenderAddress(Address: Text)
    begin
        SenderAddress := Address;
    end;

    procedure GetRecipientAddress(var Address: Text)
    begin
        Address := RecipientAddress;
    end;
}
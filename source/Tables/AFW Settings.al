table 50100 "AFW Settings"
{
    DataClassification = ToBeClassified;
    DataPerCompany = false;
    
    fields
    {
        field(1; "Enable Monitoring"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Enable Monitoring';
            Description = 'A switch to globally enable or disable monitoring.';
        }
        field(2; "Enable Logging"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Enable Logging';
            Description = 'A switch to enable or disable logging of events.';
        }
        field(3; "Log File Path"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Log File Path';
            Description = 'The path where the log files should be stored.';
        }
    }

    keys
    {
        key(PK; "Enable Monitoring")
        {
            Clustered = true;
        }
    }
}

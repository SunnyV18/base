tableextension 50113 "Social Media" extends Customer
{
    fields
    {
        field(50100; facebook; Text[50])
        {
            Caption = 'facebook';
            DataClassification = ToBeClassified;
        }
        field(50101; Instagram; Text[50])
        {
            Caption = 'Instagram';
            DataClassification = ToBeClassified;
        }
        field(50102; Twitter; Text[50])
        {
            Caption = 'Twitter';
            DataClassification = ToBeClassified;
        }
        field(50103; LinkedIn; Text[50])
        {
            Caption = 'LinkedIn';
            DataClassification = ToBeClassified;
        }
        field(50104; "Office Address"; Text[200])
        {
            Caption = 'Office Address';
            DataClassification = ToBeClassified;
        }

    }
}

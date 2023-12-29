table 50121 "ShopDetails"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(520; "Shop ID"; Code[10])
        {
            DataClassification = ToBeClassified;



        }
        field(521; "Shop Name "; Text[100])
        {
            DataClassification = ToBeClassified;

        }
        field(522; "Shop Phone Number"; Code[11])
        {
            DataClassification = ToBeClassified;

        }
        field(523; "Shop Address"; Text[200])
        {
            DataClassification = ToBeClassified;

        }
    }

    keys
    {
        key(Key1; "Shop ID")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}
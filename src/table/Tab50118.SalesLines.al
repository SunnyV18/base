table 50118 "SalesLines"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(515; "Customer Id"; Integer)
        {
            DataClassification = ToBeClassified;

        }
        field(516; "Query"; Text[500])
        {
            DataClassification = ToBeClassified;

        }
        field(517; "Description"; Text[1000])
        {
            DataClassification = ToBeClassified;

        }

    }

    keys
    {
        key(Key1; "Customer Id")
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
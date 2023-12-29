table 50111 MyTable
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Emp code"; Code[10])
        {
            DataClassification = ToBeClassified;

        }
        field(10; "Emp Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Dep Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Salary"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(30; DOJ; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(40; Gender; Option)
        {
            OptionMembers = M,F,T,DoNotDisclose;
            DataClassification = ToBeClassified;
        }
        field(50; City; Option)
        {
            OptionMembers = Nagpur,Mumbai,Pune,Delhi,Banglore,Kanpur;
            DataClassification = ToBeClassified;
        }
        field(60; "ForNum1"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(70; "ForNum2"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(80; "ForNum3"; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Emp code")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin
        Message('Data Insert');

    end;

    trigger OnModify()
    begin
        Message('Data Modified');

    end;

    trigger OnDelete()
    begin
        Message('Data Deleted');

    end;

    trigger OnRename()
    begin
        Message('Data Renamed');

    end;

}
table 50119 "Customer Data"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(501; "Customer Name"; Text[200])
        {
            DataClassification = ToBeClassified;

        }
        field(502; "Customer Id"; Integer)
        {
            DataClassification = ToBeClassified;

        }
        field(503; "Amount"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(504; "Product Type"; Option)
        {
            OptionMembers = Electronics,Electrical,Hardware,Other;
            DataClassification = ToBeClassified;

        }
        field(505; "Product Name"; Text[200])
        {
            DataClassification = ToBeClassified;

        }
        field(506; "Payment Type"; Option)
        {
            OptionMembers = UPI,Cash,Card;
            DataClassification = ToBeClassified;

        }
        field(507; "Transcation Id"; Code[50])
        {

            DataClassification = ToBeClassified;

        }
        field(508; "DATE & TIME"; DateTime)
        {
            DataClassification = ToBeClassified;

        }
        field(509; "Customer Address"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(510; "Shop Location"; Option)
        {
            OptionMembers = Mumbai,Nagpur,Nashik,Amravati,Delhi,Banglore,Kanpur,Nodia,Amritsar;
            DataClassification = ToBeClassified;

        }
        field(511; "Customer ContactNo"; Code[30])
        {
            DataClassification = ToBeClassified;

        }
        field(512; "Sales Person ID"; Integer)
        {
            DataClassification = ToBeClassified;

        }
        field(513; "GST No"; Integer)
        {
            // FieldClass=FlowField;
            DataClassification = ToBeClassified;


        }
        field(514; "Sales Person Name"; Text[100])
        {
            DataClassification = ToBeClassified;

        }
        field(515; "Shop ID"; Code[10])
        {
            //FieldClass = FlowField;
            DataClassification = ToBeClassified;
            TableRelation = "ShopDetails";
            // CalcFormula = lookup("ShopDetails"."Shop ID" where("Shop ID" = field("Shop ID")));
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                CalcFields("Shop Name ");

            end;

        }
        field(516; "Shop Name "; Text[100])
        {
            FieldClass = FlowField;
            // DataClassification = ToBeClassified;
            CalcFormula = lookup("ShopDetails"."Shop Name " where("Shop ID" = field("Shop ID")));


        }
        field(517; "Shop Phone Number"; Code[11])
        {
            FieldClass = FlowField;
            // DataClassification = ToBeClassified;
            CalcFormula = lookup("ShopDetails"."Shop Phone Number" where("Shop ID" = field("Shop ID")));


        }
        field(518; "Shop Address"; Text[200])
        {
            // DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = lookup("ShopDetails"."Shop Address" where("Shop ID" = field("Shop ID")));


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
        Message('Done!');

    end;

    trigger OnRename()
    begin
        Message('Done!');
    end;

}
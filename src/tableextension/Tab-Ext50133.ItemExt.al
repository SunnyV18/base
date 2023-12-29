tableextension 50133 ItemExt extends Item
{
    fields
    {
        field(10002; Name; Text[50])
        {
            DataClassification = ToBeClassified;
            // FieldClass = FlowField;
            // CalcFormula = lookup("Sales Line".Name where("No." = field(Name)));
            // CalcFormula = lookup(Item.Name where("No." = field("No.")));
            // trigger OnValidate()
            // var
            //     myInt: Integer;
            // begin
            //     CalcFields("No.");

            // end;

        }
    }

    var
        myInt: Integer;
}
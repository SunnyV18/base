tableextension 50136 "Posted Sales Invoice Ext" extends "Sales Invoice Line"
{
    fields
    {
        field(50100; Name; Text[50])
        {
            DataClassification = ToBeClassified;

        }
        // Add changes to table fields here
    }

    var
        myInt: Integer;
}
tableextension 50139 "Sales Line Ext212" extends "Sales Invoice Header"
{
    fields
    {
        field(50100; Name; Text[50])
        {

            DataClassification = ToBeClassified;
            // FieldClass = FlowField;
            // CalcFormula = lookup(Item.Name where("No." = field("No.")));
            // trigger OnValidate()
            // var
            //     myInt: Integer;
            // begin
            //     CalcFields("No.");

            // end;
        }
    }

}

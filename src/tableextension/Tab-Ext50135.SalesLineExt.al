tableextension 50135 "Sales Line Ext" extends "Sales Line"
{
    fields
    {
        field(50100; Name; Text[50])
        {

            DataClassification = ToBeClassified;
            //  FieldClass = FlowField;
            //   CalcFormula = lookup(Item.Name where("No." = field("No.")));
            trigger OnValidate()
            var
                myInt: Integer;

            begin
                CalcFields("No.");




            end;
        }
        field(10102; TotalTotal; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                salesheder: Record "Sales Header";
                myInt: Integer;
            begin

            end;

        }

        modify("Line Amount")
        {
            trigger OnBeforeValidate()
            var
                salesheder: Record "Sales Header";
            begin
                salesheder.Reset();
                salesheder.SetRange("No.", rec."Document No.");
                salesheder.SetRange("Document Type", rec."Document Type");
                if salesheder.FindFirst() then begin
                    salesheder.TotalAmount := rec.TotalTotal;
                end;


            end;
        }
        modify("No.")
        {
            trigger OnBeforeValidate()
            var
                salesheder: Record "Sales Header";
            begin
                clear(salesheder.GrandTotal);
                salesheder.Reset();
                salesheder.SetRange("No.", rec."Document No.");
                // salesheder.SetRange("Document Type", rec."Document Type");
                if salesheder.FindFirst() then begin
                    salesheder.GrandTotal := rec.TotalTotal;
                end;


            end;
        }
    }


}
tableextension 50138 "Sales Line Ext1" extends "Sales Header"
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
        field(10101; TotalAmount; Decimal)
        {
            DataClassification = ToBeClassified;



        }
        field(10102; GrandTotal; Decimal)
        {
            DataClassification = ToBeClassified;

        }

        // modify("Amount Including VAT")
        // {
        //     trigger OnAfterValidate()
        //     var
        //         myInt: Integer;
        //     begin
        //         rec.GrandTotal := rec.TotalAmount;

        //     end;

        // }


    }
    var
        SalesLine: Record "Sales Line";


}

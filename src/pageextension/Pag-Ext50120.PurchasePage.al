pageextension 50120 "Purchase Page" extends "Purchase Order"
{
    layout
    {
        addafter("Document Date")
        {


            field("Vendor Address"; Rec."Vendor Address")
            {
                ApplicationArea = all;


            }
            field("vendor Amount"; Rec."vendor Amount")
            {
                ApplicationArea = all;


            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}
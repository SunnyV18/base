pageextension 50137 "Posted Sales Invoice Page" extends "Posted Sales Invoice Subform"
{
    layout
    {
        addafter("No.")
        {
            field(Name; Rec.Name)
            {
                ApplicationArea = All;
                // trigger OnLookup()
                // var
                //     myInt: Integer;
                // begin

                // end;
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
// pageextension 50140 "Sales Order Subform Ext1rw" extends "Posted Sales Invoice"
// {
//     layout
//     {
//         addafter("No.")
//         {
//             field(Name; Rec.Name)
//             {
//                 ApplicationArea = All;
//                 // trigger OnLookup()
//                 // var
//                 //     myInt: Integer;
//                 // begin

//                 // end;
//             }
//         }

//     }

//     actions
//     {
//         // Add changes to page actions here
//     }

//     var
//         myInt: Integer;
// }
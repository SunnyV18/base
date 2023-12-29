tableextension 50100 purchaseheaer extends "Purch. Inv. Header"
{

    fields
    {
        field(60100; "E-Mail"; Boolean)
        {
            Caption = 'E-Mail';
            DataClassification = ToBeClassified;
        }
    }
}
// tableextension 50101 "Automail3" extends "Sales Header"
// {
//     fields
//     {
//         // Add changes to table fields here
//     }

//     keys
//     {
//         // Add changes to keys here
//     }

//     fieldgroups
//     {
//         // Add changes to field groups here
//     }

//     var
//         myInt: Integer;
// }

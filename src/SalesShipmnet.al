// pageextension 50100 "Sales Shipment Button" extends "Posted Sales Shipment"
// {


//     actions
//     {
//         addlast(processing)
//         {
//             action("Delivery Naote")
//             {
//                 ApplicationArea = all;
//                 Promoted = true;
//                 PromotedCategory = New;
//                 // RunObject = report 50106;
//                 trigger OnAction()
//                 var
//                     shimpmentheader: Record "Sales Shipment Header";

//                 begin
//                     shimpmentheader.Reset();
//                     shimpmentheader.SetRange("No.", Rec."No.");
//                     Report.RunModal(50110, true, true, shimpmentheader);


//                 end;
//             }
//         }

//         // Add changes to page actions here
//     }

//     var
//         myInt: Integer;
// }
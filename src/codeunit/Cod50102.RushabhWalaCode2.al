
codeunit 50102 RushabhWalaCode2
{
    // trigger OnRun()
    // begin
    // end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnBeforeSendPostedDocumentRecord, '', false, false)]
    local procedure "Sales-Post_OnBeforeSendPostedDocumentRecord"(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean; var DocumentSendingProfile: Record "Document Sending Profile");
    begin
        IsHandled := true;
        // SalesHeader.SentMailAttachmnet123(SalesHeader);
    end;
    // [EventSubscriber(ObjectType::Table, Database::"Purchase Header", OnBeforeSendRecords, '', false, false)]
    // local procedure OnBeforeSendRecords(var PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean);
    // begin
    //     IsHandled := true;
    //     PurchaseHeader.SentMailAttachmnet(PurchaseHeader);
    // end;

    var
        myInt: Integer;
}





// pageextension 80142 abcd extends "Sales Invoice"
// {
//     layout
//     {
//         // Add changes to page layout here
//     }

//     actions
//     {
//         addlast(navigation)
//         {
//             action(tadaa)
//             {
//                 ApplicationArea = All;
//                 Promoted = true;
//                 PromotedCategory = New;
//                 trigger OnAction()
//                 var
//                     codeunit1: Codeunit RushabhWalaCode;
//                     bbb: Record "Sales Header";
//                 begin
//                     bbb.SentMailAttachmnet(Rec);
//                 end;
//             }


//         }
//     }

//     var
//         myInt: Integer;
//     // Email: Codeunit "Email";
// }



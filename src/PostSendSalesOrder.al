// codeunit 50100 "Sales Invoice Email"
// {

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post and Send", 'OnCodeOnAfterConfirmPostAndSend', '', false, false)]
//     local procedure OnBeforePostAndSend(var SalesHeader: Record "Sales Header")
//     var
//         //SmtpMailSetup: Record "SMTP Mail Setup";
//         //Mail: Codeunit "SMTP Mail";
//         EmailMessage: Codeunit "Email Message";
//         Email: Codeunit Email;
//         Recipients: List of [Text];
//         Subject: Text;
//         Body: Text;
//         Customer: Record Customer;
//         CUSEMAIL: Text[50];
//         Compinfo: Record "Company Information";
//         SalesPostedTitle: Label 'The Sales Document %2 of Customer %1 has been posted.';
//         SalesPostedMsg: Label 'Dear Manager<br><br>The Sales Document <font color="red"><strong>%2</strong></font> of Customer <strong>%1</strong> has been posted.<br> The total amount is <strong>%3</strong>. <br>The Posted Invoice Number is <strong>%4</strong>. <br> User ID <strong>%5</strong>';
//     begin
//         if Customer.get(SalesHeader."Sell-to Customer No.") then
//             CUSEMAIL := Customer."E-Mail";

//         Recipients.Add(CUSEMAIL);
//         Recipients.Add('yash@cocoonitservices.com');
//         SalesHeader.CalcFields("Amount Including VAT");
//         Subject := StrSubstNo(SalesPostedTitle, SalesHeader."Sell-to Customer Name", SalesHeader."No.");
//         Body := StrSubstNo(SalesPostedMsg, SalesHeader."Sell-to Customer Name", SalesHeader."No.", SalesHeader."Amount Including VAT", SalesHeader."No.", UserId);
//         EmailMessage.Create(Recipients, Subject, Body, true);
//         Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
//     end;

// }


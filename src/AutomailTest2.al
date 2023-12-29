// codeunit 50100 "AutomailTest2"
// {
//     // [EventSubscriber(ObjectType::Codeunit, Codeunit::"post", OnBeforeSendRecords, '', false, false)]
//     // local procedure OnBeforeSendRecords(var PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean);
//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnBeforeSendPostedDocumentRecord, '', false, false)]
//     local procedure OnBeforeSendPostedDocumentRecord(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean; var DocumentSendingProfile: Record "Document Sending Profile");
//     begin
//         IsHandled := true;
//         SalesHeader.SentMailAttachmnet(SalesHeader);

//     end;

//     procedure SentMailAttachmnet(var SalesHeader: Record "Sales Header")
//     var
//         EmailAccount: Record "Email Account";
//         EmailMsg: Codeunit "Email Message";
//         flag: Boolean;
//         BodyText: text;
//         outstream: OutStream;
//         instream: InStream;
//         reportPO: report 202;
//         tempblob: Codeunit "Temp Blob";
//         Vendor: record Customer;
//         VendEmail: text;
//         Email: Codeunit Email;
//     begin
//         if Vendor.get(SalesHeader."Bill-to Customer No.") then
//             VendEmail := Vendor."E-Mail";
//         BodyText := '<B>Greetings from Kwality Foods</B>' + '<br><br>' + '<br>Dear Sir/Madam,' + '<br>Please find the attached Purchase Order.'
//          + '<br>Kindly arrange to despatch the Material along with COA .';
//         // BodyText := 'Dear ' + 'SIR' + ',<br>' + '<br>Please find the below mentioned Details of PO.';
//         EmailMsg.Create(VendEmail, 'Purchase Order ' + SalesHeader."No.", BodyText, TRUE);
//         reportPO.SetTableView(SalesHeader);
//         tempblob.CreateOutStream(outstream);
//         flag := reportPO.SaveAs('', ReportFormat::Pdf, outstream);
//         tempblob.CreateInStream(instream);
//         EmailMsg.AddAttachment('Purchase Order ' + SalesHeader."No." + '.pdf', 'PDF', instream);
//         EmailMsg.AppendToBody('<br><br>');
//         EmailMsg.AppendToBody('<p style="color:red;"><U>1.Note : COA is Mandatory without COA material will not unloaded</U></p>');
//         EmailMsg.AppendToBody('<br>1.Delivery Location :Harohalli ( Industrial Area 2ND Phase)');
//         EmailMsg.AppendToBody('<br><B>2.Dispatch date:' + Format('') + '</B>');
//         EmailMsg.AppendToBody('<br><B>3.Payment Terms :' + SalesHeader."Payment Terms Code" + '</B>');
//         EmailMsg.AppendToBody('<br><B>4.Delivery :Harohalli Industrial area</B>');
//         EmailMsg.AppendToBody('<br>5.Special Note : Material should be delivery before 4.30 to factory if its reached after 4.30 Material will be unloaded next day.');
//         EmailMsg.AppendToBody('<br>6.No Hamali ( Unloaders )  allowed inside till Covid -19 clear');
//         EmailMsg.AppendToBody('<br>7.Material Should be as per Specification only.');
//         EmailMsg.AppendToBody('<br>8.RM above one ton Weighment is Mandatory');
//         EmailMsg.AppendToBody('<br>9.RM materials Should be Free from Foreign particles');
//         EmailMsg.AppendToBody('<br>10.Any quality deviation Entire lot will be rejected');
//         EmailMsg.AppendToBody('<br><br>');
//         EmailMsg.AppendToBody('<U><B>11.Billing and Delivery Address :</U></B>');
//         EmailMsg.AppendToBody('<br><br>');
//         EmailMsg.AppendToBody('<B>Pagariya Food Products Pvt Ltd.,</B>');
//         EmailMsg.AppendToBody('<br><B>Factory:</B>' + 'Unit Plot No # 302 A, Phase -2,');
//         EmailMsg.AppendToBody('<br>KIADB Industrial Estate, Harohalli');
//         EmailMsg.AppendToBody('<br>Taluka Kanakapura, Dist Ramanagara,');
//         EmailMsg.AppendToBody('<br>Pin Code: 562 112, Karnataka State, India.');
//         EmailMsg.AppendToBody('<br>GST :' + '<B>29AAFCP2699J1ZQ .');
//         if flag then begin
//             Email.Send(EmailMsg, Enum::"Email Scenario"::Default);
//             // SMTPMail.Send;
//             MESSAGE('mail Sent Successfuly');

//         end;
//     end;


// }
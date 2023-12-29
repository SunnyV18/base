// codeunit 50102 SendEmailAuto //Tenanat Error
// {
//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post and Send", 'OnAfterPostAndBeforeSend', '', false, false)]
//     local procedure OnAfterPostAndBeforeSend(var SalesHeader: Record "Sales Header")
//     var
//         Vendor: Record Customer;
//         PurchHdr: Record "Sales Invoice Header";
//         Subject: Text[100];
//         AttachementTempBlob: Codeunit "Temp Blob";
//         AttachmentInstream: InStream;
//         AttachementOutstream: OutStream;
//         FileMgt: Codeunit "File Management";
//         recPurchref: RecordRef;
//         repRequestForQuote: Report 1306;
//         MailSent: Boolean;
//         FilePath: Text;

//         //2
//         EmailMessage: Codeunit "Email Message";
//         Email: Codeunit Email;
//         Receipent: List of [Text];

//         CCReceipent2: List of [Text];
//         Body: Text;
//         Contact: Record Contact;
//     begin
//         // if SalesHeader."E-Mail" = true then //yash
//         // Error('Mail has been already sent so you can not sent again');

//         IF (SalesHeader."Sell-to Customer No." <> '') THEN BEGIN
//             Vendor.GET(SalesHeader."Sell-to Customer No.");
//             Vendor.TESTFIELD(Vendor."E-Mail");
//             //AttachementTempBlob.CreateOutStream(AttachementOutstream);
//             //repRequestForQuote.SetTableView(SalesHeader);
//             // repRequestForQuote.setdocno(SalesHeader."No.");
//             // repRequestForQuote.SaveAs('', ReportFormat::Pdf, AttachementOutstream);
//             // AttachementTempBlob.CreateInStream(AttachmentInstream);
//             // Receipent.Add(Contact."E-Mail");

//             Receipent.Add(Vendor."E-Mail");
//             //Subject := StrSubstNo('Hello test 123');
//             CCReceipent2.Add('yogender.rana@robo-soft.net');
//             CLEAR(Subject);
//             // IF PurchHeader."Requisition No." <> '' THEN
//             //    Subject := 'IMR No.: ' + PurchHeader."Requisition No." + ' ';
//             Subject += 'Sales Invoice No.: ' + SalesHeader."No.";
//             Body := 'Dear Vendor,' + SalesHeader."Sell-to Customer Name" + '</br>';//Amit Modifid
//             Body += '</br>';
//             Body += 'Please find attached Invoice' + '</br>';
//             Body += 'kindly do payment' + '</br>';
//             Body += '</br>';
//             Body += '</br>';
//             body += 'Regards' + '</br>';
//             Body += USERID + '</br>';
//             //Body += 'Chief Executive Officer (CEO)' + '</br>';
//             Body += '<h7 style="color:blue;"></h7>' + '</br>';
//             //Body += '<p style="color:blue;">''Chief Executive Officer (CEO)' + '</p>' + '</br>';
//             // Body += '<a href="https://robo-soft.com/wp-content/uploads/2019/02/mictosoft-gold-partner-in-dubai.jpg" target="_blank"><img src="https://robo-soft.com/wp-content/uploads/2019/02/mictosoft-gold-partner-in-dubai.jpg" width = "516" height = "136"/></a>' + '</br>';
//             //Body += '<img src="C:\Users\amit.pandey\Desktop\New folder (2)\AlPrac\AlPrac\logo.jpg"></br>';
//             // Body += '<b>Robosoft Solution Pvt Ltd.</b>, 301-302, Arya Arcade, Vikhroli station road, Vikhroli West, Mumbai, 400 079, <b>India.</b>' + '</br>';
//             // Body += '<b>Robosoft Solution LLC.</b>, 232, Regus Bldg., D-Ring Road, Al Madder Al Qadeem Street, Doha, PO Box 32522,<b> Qatar.</b>' + '</br>';
//             // Body += '<b>Robosoft Solutions DMCC.</b>, 2104, One lake plaza, Cluster T, Jumeirah lakes towers, Dubai, <b>UAE.</b>' + '</br>';
//             // Body += '<b>Robosoft Dynamics Solution LLC.</b>, 1259, Lakeside drive, #1214, Sunnyvale, CA -94085, <b>USA.</b>' + '</br>';
//             // Body += '<b>Robosoft Consulting Ltd.</b>, 3, Jubilee house, Great Warley, Brentwood, CM13 3FR, Essex, <b>UK</b>' + '</br>' + '</br>' + '</br>' + '</br>' + '</br>';
//             EmailMessage.Create(Receipent, Subject, Body, true, CCReceipent2, CCReceipent2);
//             EmailMessage.AddAttachment('PurchInvReport.Pdf', 'PDF', AttachmentInstream);
//             Email.Send(EmailMessage, Enum::"Email Scenario"::Default)// then
//                                                                      //     MailSent := true;

//             //if MailSent then
//             // PurchaseInvoiceHeaderEdit.UpdatePurchaseInvoiceHeader(PurchHeader, MailSent, TODAY);
//         end;
//     end;



//     //     EmailAccount: Record "Email Account";
//     //     Email: Codeunit Email;
//     //     EmailMsg: Codeunit "Email Message";
//     //     flag: Boolean;
//     //     BodyText: text;
//     //     outstream: OutStream;
//     //     instream: InStream;
//     //     reportPO: report 1306;
//     //     tempblob: Codeunit "Temp Blob";
//     //     Vendor: record Customer;
//     //     VendEmail: text;
//     // begin
//     //     if Vendor.get(SalesHeader."Sell-to Customer No.") then
//     //         VendEmail := Vendor."E-Mail";
//     //     BodyText := '<B>Greetings from Kwality Foods</B>' + '<br><br>' + '<br>Dear Sir/Madam,' + '<br>Please find the attached Purchase Order.'
//     //      + '<br>Kindly arrange to despatch the Material along with COA .';
//     //     // BodyText := 'Dear ' + 'SIR' + ',<br>' + '<br>Please find the below mentioned Details of PO.';
//     //     EmailMsg.Create(VendEmail, 'Sales Order ' + SalesHeader."No.", BodyText, TRUE);
//     //     //  reportPO.SetTableView(SalesHeader);
//     //     tempblob.CreateOutStream(outstream);
//     //     //flag := reportPO.SaveAs('', ReportFormat::Pdf, outstream);
//     //     tempblob.CreateInStream(instream);
//     //     //   EmailMsg.Create(torecipients, 'NEW CONFIRMED ORDER INVOICE COPY', '', true, ccRecipients, BccRecipients);
//     //     EmailMsg.AppendToBody('Dear Sir / Madam, <BR><BR>');
//     //     EmailMsg.AppendToBody(Vendor.Name + ' <BR><BR>');
//     //     // RecLoc.SETFILTER(Code, RecSalesInv."Location Code");
//     //     //EmailMsg.AppendToBody('THANK YOU DR FOR SHARING YOUR VALUABLE ORDER RECEIVED AT OUR OFFICE ON:',RecSalesInv."Posting Date", ' Dated.<BR>');
//     //     MESSAGE('BodyText: %1', BodyText);
//     //     EmailMsg.AppendToBody('THANK YOU DR FOR SHARING YOUR VALUABLE ORDER RECEIVED AT OUR OFFICE ON:' + SalesHeader."No." + ' and Date: ' + FORMAT(SalesHeader."Posting Date"));
//     //     MESSAGE('Email Body After Appending Line 1: %1', EmailMsg);
//     //     EmailMsg.AppendToBody('<BR><BR>');

//     //     EmailMsg.AppendToBody('WE ARE SHARING YOU THE INVOICE COPY ATTACHED TO THIS MAIL. THEDETAILS OF CONFIRMED ORDER WITH PRODUCTS IS AS FOLLOWS:<BR><BR>');
//     //     EmailMsg.AppendToBody('INVOICE NO.' + SalesHeader."No." + '<BR>' + 'DATE OF BILLING' + Format(SalesHeader."Order Date") + '<BR>' + 'AmountRs' + '<BR>' + 'Due Date For Period' + Format(SalesHeader."Due Date") + '<BR>' + 'CREDIT PERIOD' + SalesHeader."Payment Terms Code");
//     //     EmailMsg.AppendToBody('WE LOOK FORWARD TO YOUR CONTINOUS SUPPORT FOR OUR ESTEEMED GLOBAL BRANDS., <BR>');
//     //     EmailMsg.AppendToBody('DR SHARING YOU OUR COMPANY CURRENT ACCOUNT BANK DETAILS BANK DETAILS/ QR CODE IMAGE');
//     //     //EmailMsg.AppendToBody(' BANK Name' + ."Bank Name" + ' BANK NO.' + CompanyInfo."Bank Account No.");
//     //     EmailMsg.AppendToBody('Regards, <BR>');
//     //     EmailMsg.AppendToBody('Code Works Successfuly');

//     //     // if flag then begin
//     //     Email.Send(EmailMsg, Enum::"Email Scenario"::Default);
//     //     // SMTPMail.Send;
//     //     MESSAGE('mail Sent Successfuly');

//     // end;

// }
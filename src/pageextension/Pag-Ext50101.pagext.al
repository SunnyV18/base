pageextension 50101 pagext extends "Posted Sales Shipment"
{
    actions
    {
        addlast(processing)
        {
            action("Delivery Notes")
            {
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = New; //we also select process for process we can use same action button present in shipment page and for new we can create new button
                // RunObject = report 50106;
                trigger OnAction()
                var
                    shimpmentheader: Record "Sales Shipment Header";

                begin
                    shimpmentheader.Reset();
                    shimpmentheader.SetRange("No.", Rec."No.");// For this Report only data fetch we use this setrange for same no in report
                    Report.RunModal(50110, true, true, shimpmentheader);


                end;
            }

        }
    }
}

pageextension 50100 pagext2 extends "Posted Sales Shipments"
{
    actions
    {
        addlast(processing)
        {
            action("Delivery Notes")
            {
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = New; //we also select process for process we can use same action button present in shipment page and for new we can create new button
                // RunObject = report 50106;
                trigger OnAction()
                var
                    shimpmentheader: Record "Sales Shipment Header";

                begin
                    shimpmentheader.Reset();
                    shimpmentheader.SetRange("No.", Rec."No.");// For this Report only data fetch we use this setrange for same no in report
                    Report.RunModal(50110, true, true, shimpmentheader);


                end;
            }

        }
    }
}
// pageextension 50102 pagext4 extends "Sales Order"
// {
//     // actions
// {
//     addlast(processing)
//     {
//         action("Purchase Order Report")
//         {
//             ApplicationArea = all;
//             Promoted = true;
//             PromotedCategory = Process;
//             // RunObject = report 50106;
//             trigger OnAction()
//             var
//                 shimpmentheader: Record "sales Header";

//             begin
//                 shimpmentheader.Reset();
//                 shimpmentheader.SetRange("No.", Rec."No.");
//                 Report.RunModal(50110, true, true, shimpmentheader);


//             end;
//         }

//     }
// }




//}
// pageextension 50105 pagext2 extends "Posted Sales Credit Memos"
// {
//     actions
//     {
//         addlast(processing)
//         {
//             action("Purchase Order Report")
//             {
//                 ApplicationArea = all;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 // RunObject = report 50106;
//                 trigger OnAction()
//                 var
//                     shimpmentheader: Record "Sales Cr.Memo Header";

//                 begin
//                     shimpmentheader.Reset();
//                     shimpmentheader.SetRange("No.", Rec."No.");
//                     Report.RunModal(50105, true, true, shimpmentheader);


//                 end;
//             }

//         }
//     }




// }
pageextension 50103 "Test123" extends "Sales Invoice"
{
    layout
    {
        addafter(SellToEmail)
        {
            // field("E-Mail Sent"; Rec."E-Mail Sent")
            // {
            //     ApplicationArea = all;
            // }
        }
    }
    actions

    {
        addlast(processing)
        {
            action(Test)
            {
                PromotedCategory = New;
                Promoted = true;
                ApplicationArea = all;
                trigger OnAction()
                var
                    PurchHeader: Record "Sales Header";
                    Vendor: Record Customer;
                    // PurchHdr: Record "Sales Header";
                    Subject: Text[100];
                    AttachementTempBlob: Codeunit "Temp Blob";
                    AttachmentInstream: InStream;
                    AttachementOutstream: OutStream;
                    FileMgt: Codeunit "File Management";
                    recPurchref: RecordRef;
                    repRequestForQuote: Report 50113;
                    //new
                    MailSent: Boolean;
                    FilePath: Text;
                begin
                    PurchHeader.get;
                    // if PurchHeader."E-Mail sent" = true then
                    //     Error('Mail has been already sent so you can not sent again');

                    IF (PurchHeader."Bill-to Customer No." <> '') THEN BEGIN
                        Vendor.GET(PurchHeader."Bill-to Customer No.");
                        Vendor.TESTFIELD(Vendor."E-Mail");
                        AttachementTempBlob.CreateOutStream(AttachementOutstream);
                        repRequestForQuote.SetTableView(PurchHeader);
                        // repRequestForQuote.SetDocNo(PurchHeader."No.");
                        repRequestForQuote.SaveAs('', ReportFormat::Pdf, AttachementOutstream);
                        AttachementTempBlob.CreateInStream(AttachmentInstream);
                        // Receipent.Add(Contact."E-Mail");Receipent.Add(Vendor."E-Mail");
                        CC.Add('lalitchoudhri7071@gmail.com');

                        //  Receipent.Add('pradeep.maurya@robo-soft.net');
                        //  Receipent.Add('neha.borse@robo-soft.net');
                        CLEAR(Subject);
                        // IF PurchHeader."Requisition No." <> '' THEN
                        //    Subject := 'IMR No.: ' + PurchHeader."Requisition No." + ' ';
                        Subject += 'NEW CONFIRMED ORDER INVOICE COPY' + PurchHeader."No.";
                        Body := 'DEAR ,' + PurchHeader."Sell-to Customer Name" + '</br>';
                        Body += '</br>';
                        Body += 'THANK YOU DR FOR SHARING YOUR VALUABLE ORDER RECEIVED AT OUR OFFICE ON ' + PurchHeader."No." + ' AND DATE.' + Format(PurchHeader."Posting Date") + '</br>';
                        Body += '</br>';
                        Body += 'WE ARE SHARING YOU THE INVOICE COPY ATTACHED TO THIS MAIL.' + '</br>';
                        Body += 'THEDETAILS OF CONFIRMED ORDER WITH PRODUCTS IS AS FOLLOWS:' + '</br>';
                        Body += ('INVOICE NO.' + PurchHeader."No." + '<BR>' + 'DATE OF BILLING' + Format(PurchHeader."Order Date") + '<BR>' + 'AmountRs' + '<BR>' + 'Due Date For Period' + Format(PurchHeader."Due Date") + '<BR>' + 'CREDIT PERIOD' + PurchHeader."Payment Terms Code");
                        Body += ('WE LOOK FORWARD TO YOUR CONTINOUS SUPPORT FOR OUR ESTEEMED GLOBAL BRANDS., <BR>');
                        Body += ('DR SHARING YOU OUR COMPANY CURRENT ACCOUNT BANK DETAILS BANK DETAILS/ QR CODE IMAGE');
                        Body += (' BANK Name' + CompanyInfo."Bank Name" + ' BANK NO.' + CompanyInfo."Bank Account No." + '<BR>');
                        Body += ('Regards, <BR>');
                        Body += (CompanyInfo.Name + '<BR>');
                        Body += USERID;
                        EmailMessage.Create(Receipent, Subject, Body, true, CC, CC);
                        EmailMessage.AddAttachment('Report.Pdf', 'PDF', AttachmentInstream);
                        if Email.Send(EmailMessage, Enum::"Email Scenario"::Default) then
                            MailSent := true;
                        Message('%1', MailSent);
                        CompanyInfo.get();
                        // if MailSent then//     PurchaseInvoiceHeaderEdit.UpdatePurchaseInvoiceHeader(PurchHeader, MailSent, TODAY);
                    end;
                end;

            }
        }




    }
    var

        //   automail2: Codeunit 50103;  
        aabb: Code[20];
        CompanyInfo: Record "Company Information";
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        Receipent: List of [Text];
        Body: Text;

        Contact: Record 5050;
        CC: List of [Text];

    // procedure EmailRFQAttachment(PurchHeader: Record "Sales Header")
    // var
    //     Vendor: Record Customer;
    //     PurchHdr: Record "Sales Header";
    //     Subject: Text[100];
    //     AttachementTempBlob: Codeunit "Temp Blob";
    //     AttachmentInstream: InStream;
    //     AttachementOutstream: OutStream;
    //     FileMgt: Codeunit "File Management";
    //     recPurchref: RecordRef;
    //     repRequestForQuote: Report 50113;
    //     //new
    //     MailSent: Boolean;
    //     FilePath: Text;
    // //PurchaseInvoiceHeaderEdit: Codeunit 50002;
    // begin
    //     if PurchHeader."E-Mail sent" = true then
    //         Error('Mail has been already sent so you can not sent again');

    //     IF (PurchHeader."Sell-to Customer No." <> '') THEN BEGIN
    //         Vendor.GET(PurchHeader."Sell-to Customer No.");
    //         Vendor.TESTFIELD(Vendor."E-Mail");
    //         AttachementTempBlob.CreateOutStream(AttachementOutstream);
    //         repRequestForQuote.SetTableView(PurchHeader);
    //         // repRequestForQuote.SetDocNo(PurchHeader."No.");
    //         repRequestForQuote.SaveAs('', ReportFormat::Pdf, AttachementOutstream);
    //         AttachementTempBlob.CreateInStream(AttachmentInstream);
    //         // Receipent.Add(Contact."E-Mail");Receipent.Add(Vendor."E-Mail");
    //         CC.Add('lalitchoudhri7071@gmail.com');

    //         //  Receipent.Add('pradeep.maurya@robo-soft.net');
    //         //  Receipent.Add('neha.borse@robo-soft.net');
    //         CLEAR(Subject);
    //         // IF PurchHeader."Requisition No." <> '' THEN
    //         //    Subject := 'IMR No.: ' + PurchHeader."Requisition No." + ' ';
    //         Subject += 'NEW CONFIRMED ORDER INVOICE COPY' + PurchHeader."No.";
    //         Body := 'DEAR ,' + PurchHeader."Sell-to Customer Name" + '</br>';
    //         Body += '</br>';
    //         Body += 'THANK YOU DR FOR SHARING YOUR VALUABLE ORDER RECEIVED AT OUR OFFICE ON ' + PurchHeader."No." + ' AND DATE.' + Format(PurchHeader."Posting Date") + '</br>';
    //         Body += '</br>';
    //         Body += 'WE ARE SHARING YOU THE INVOICE COPY ATTACHED TO THIS MAIL.' + '</br>';
    //         Body += 'THEDETAILS OF CONFIRMED ORDER WITH PRODUCTS IS AS FOLLOWS:' + '</br>';
    //         Body += ('INVOICE NO.' + PurchHeader."No." + '<BR>' + 'DATE OF BILLING' + Format(PurchHeader."Order Date") + '<BR>' + 'AmountRs' + '<BR>' + 'Due Date For Period' + Format(PurchHeader."Due Date") + '<BR>' + 'CREDIT PERIOD' + PurchHeader."Payment Terms Code");
    //         Body += ('WE LOOK FORWARD TO YOUR CONTINOUS SUPPORT FOR OUR ESTEEMED GLOBAL BRANDS., <BR>');
    //         Body += ('DR SHARING YOU OUR COMPANY CURRENT ACCOUNT BANK DETAILS BANK DETAILS/ QR CODE IMAGE');
    //         Body += (' BANK Name' + CompanyInfo."Bank Name" + ' BANK NO.' + CompanyInfo."Bank Account No." + '<BR>');
    //         Body += ('Regards, <BR>');
    //         Body += (CompanyInfo.Name + '<BR>');
    //         Body += USERID;
    //         EmailMessage.Create(Receipent, Subject, Body, true, CC, CC);
    //         EmailMessage.AddAttachment('Report.Pdf', 'PDF', AttachmentInstream);
    //         if Email.Send(EmailMessage, Enum::"Email Scenario"::Default) then
    //             MailSent := true;
    //         Message('%1', MailSent);
    //         CompanyInfo.get();
    //         // if MailSent then//     PurchaseInvoiceHeaderEdit.UpdatePurchaseInvoiceHeader(PurchHeader, MailSent, TODAY);
    //     end;
    // end;


    // var
    //     CompanyInfo: Record "Company Information";
    //     EmailMessage: Codeunit "Email Message";
    //     Email: Codeunit Email;
    //     Receipent: List of [Text];
    //     Body: Text;

    //     Contact: Record 5050;
    //     CC: List of [Text];    
    // salHeader: Record "Sales Header";
    //Lalit Code****************
    // procedure OnAfterPostAndBeforeSend(var SalesHeader: Record "Sales Header")
    // var
    //     Vendor: Record Customer;
    //     PurchHdr: Record "Sales Invoice Header";
    //     Subject: Text[100];
    //     AttachementTempBlob: Codeunit "Temp Blob";
    //     AttachmentInstream: InStream;
    //     AttachementOutstream: OutStream;
    //     FileMgt: Codeunit "File Management";
    //     recPurchref: RecordRef;
    //     repRequestForQuote: Report 1306;
    //     MailSent: Boolean;
    //     FilePath: Text;

    //     //2
    //     EmailMessage: Codeunit "Email Message";
    //     Email: Codeunit Email;
    //     Receipent: List of [Text];

    //     CCReceipent2: List of [Text];
    //     Body: Text;
    //     Contact: Record Contact;
    // begin
    //     // if SalesHeader."E-Mail" = true then //yash
    //     // Error('Mail has been already sent so you can not sent again');

    //     IF (SalesHeader."No." <> '') THEN BEGIN
    //         Vendor.GET(SalesHeader."No.");
    //         Vendor.TESTFIELD(Vendor."E-Mail");
    //         //AttachementTempBlob.CreateOutStream(AttachementOutstream);
    //         //repRequestForQuote.SetTableView(SalesHeader);
    //         // repRequestForQuote.setdocno(SalesHeader."No.");
    //         // repRequestForQuote.SaveAs('', ReportFormat::Pdf, AttachementOutstream);
    //         // AttachementTempBlob.CreateInStream(AttachmentInstream);
    //         // Receipent.Add(Contact."E-Mail");

    //         Receipent.Add(Vendor."E-Mail");
    //         //Subject := StrSubstNo('Hello test 123');
    //         CCReceipent2.Add('yash@cocoonitservices.com');
    //         CLEAR(Subject);
    //         // IF PurchHeader."Requisition No." <> '' THEN
    //         //    Subject := 'IMR No.: ' + PurchHeader."Requisition No." + ' ';
    //         Subject += 'Sales Invoice No.: ' + SalesHeader."No.";
    //         Body := 'Dear Vendor,' + SalesHeader."Sell-to Customer Name" + '</br>';//Amit Modifid
    //         Body += '</br>';
    //         Body += 'Please find attached Invoice' + '</br>';
    //         Body += 'kindly do payment' + '</br>';
    //         Body += '</br>';
    //         Body += '</br>';
    //         body += 'Regards' + '</br>';
    //         Body += USERID + '</br>';
    //         //Body += 'Chief Executive Officer (CEO)' + '</br>';
    //         Body += '<h7 style="color:blue;"></h7>' + '</br>';
    //         //Body += '<p style="color:blue;">''Chief Executive Officer (CEO)' + '</p>' + '</br>';
    //         // Body += '<a href="https://robo-soft.com/wp-content/uploads/2019/02/mictosoft-gold-partner-in-dubai.jpg" target="_blank"><img src="https://robo-soft.com/wp-content/uploads/2019/02/mictosoft-gold-partner-in-dubai.jpg" width = "516" height = "136"/></a>' + '</br>';
    //         //Body += '<img src="C:\Users\amit.pandey\Desktop\New folder (2)\AlPrac\AlPrac\logo.jpg"></br>';
    //         // Body += '<b>Robosoft Solution Pvt Ltd.</b>, 301-302, Arya Arcade, Vikhroli station road, Vikhroli West, Mumbai, 400 079, <b>India.</b>' + '</br>';
    //         // Body += '<b>Robosoft Solution LLC.</b>, 232, Regus Bldg., D-Ring Road, Al Madder Al Qadeem Street, Doha, PO Box 32522,<b> Qatar.</b>' + '</br>';
    //         // Body += '<b>Robosoft Solutions DMCC.</b>, 2104, One lake plaza, Cluster T, Jumeirah lakes towers, Dubai, <b>UAE.</b>' + '</br>';
    //         // Body += '<b>Robosoft Dynamics Solution LLC.</b>, 1259, Lakeside drive, #1214, Sunnyvale, CA -94085, <b>USA.</b>' + '</br>';
    //         // Body += '<b>Robosoft Consulting Ltd.</b>, 3, Jubilee house, Great Warley, Brentwood, CM13 3FR, Essex, <b>UK</b>' + '</br>' + '</br>' + '</br>' + '</br>' + '</br>';
    //         EmailMessage.Create(Receipent, Subject, Body, true, CCReceipent2, CCReceipent2);
    //         EmailMessage.AddAttachment('PurchInvReport.Pdf', 'PDF', AttachmentInstream);
    //         Email.Send(EmailMessage, Enum::"Email Scenario"::Default)// then
    //                                                                  //     MailSent := true;

    //         //if MailSent then
    //         // PurchaseInvoiceHeaderEdit.UpdatePurchaseInvoiceHeader(PurchHeader, MailSent, TODAY);
    //     end;
    // end;
    //Second Code***********************8
    // procedure SentMailAttachmnetSO(var SalesHeader: Record "Sales Header")
    // var
    //     EmailAccount: Record "Email Account";
    //     EmailMsg: Codeunit "Email Message";
    //     Email: Codeunit Email;
    //     flag: Boolean;
    //     BodyText: text;
    //     outstream: OutStream;
    //     instream: InStream;
    //     reportPO: report 1306;
    //     tempblob: Codeunit "Temp Blob";
    //     Customer: record Customer;
    //     CustEmail: text;
    // begin
    //     if Customer.get(SalesHeader."Sell-to Customer No.") then
    //         CustEmail := Customer."E-Mail";
    //     BodyText := '<B>Greetings from Kwality Foods</B>' + '<br><br>' + '<br>Dear Sir/Madam,' + '<br>Please find the attached Purchase Order.'
    //      + '<br>Kindly arrange to despatch the Material along with COA .';
    //     // BodyText := 'Dear ' + 'SIR' + ',<br>' + '<br>Please find the below mentioned Details of PO.';
    //     EmailMsg.Create(CustEmail, 'Purchase Order ' + SalesHeader."No.", BodyText, TRUE);
    //     //reportPO.SetTableView(SalesHeader);
    //     tempblob.CreateOutStream(outstream);
    //     flag := reportPO.SaveAs('', ReportFormat::Pdf, outstream);
    //     tempblob.CreateInStream(instream);
    //     EmailMsg.AddAttachment('Purchase Order ' + SalesHeader."No." + '.pdf', 'PDF', instream);
    //     EmailMsg.AppendToBody('<br><br>');
    //     EmailMsg.AppendToBody('<p style="color:red;"><U>1.Note : COA is Mandatory without COA material will not unloaded</U></p>');
    //     EmailMsg.AppendToBody('<br>1.Delivery Location :Harohalli ( Industrial Area 2ND Phase)');
    //     EmailMsg.AppendToBody('<br><B>2.Dispatch date:' + Format(SalesHeader."Document Date") + '</B>');
    //     EmailMsg.AppendToBody('<br><B>3.Payment Terms :' + SalesHeader."Payment Terms Code" + '</B>');
    //     EmailMsg.AppendToBody('<br><B>4.Delivery :Harohalli Industrial area</B>');
    //     EmailMsg.AppendToBody('<br>5.Special Note : Material should be delivery before 4.30 to factory if its reached after 4.30 Material will be unloaded next day.');
    //     EmailMsg.AppendToBody('<br>6.No Hamali ( Unloaders )  allowed inside till Covid -19 clear');
    //     EmailMsg.AppendToBody('<br>7.Material Should be as per Specification only.');
    //     EmailMsg.AppendToBody('<br>8.RM above one ton Weighment is Mandatory');
    //     EmailMsg.AppendToBody('<br>9.RM materials Should be Free from Foreign particles');
    //     EmailMsg.AppendToBody('<br>10.Any quality deviation Entire lot will be rejected');
    //     EmailMsg.AppendToBody('<br><br>');
    //     EmailMsg.AppendToBody('<U><B>11.Billing and Delivery Address :</U></B>');
    //     EmailMsg.AppendToBody('<br><br>');
    //     EmailMsg.AppendToBody('<B>Pagariya Food Products Pvt Ltd.,</B>');
    //     EmailMsg.AppendToBody('<br><B>Factory:</B>' + 'Unit Plot No # 302 A, Phase -2,');
    //     EmailMsg.AppendToBody('<br>KIADB Industrial Estate, Harohalli');
    //     EmailMsg.AppendToBody('<br>Taluka Kanakapura, Dist Ramanagara,');
    //     EmailMsg.AppendToBody('<br>Pin Code: 562 112, Karnataka State, India.');
    //     EmailMsg.AppendToBody('<br>GST :' + '<B>29AAFCP2699J1ZQ .');
    //     if flag then begin
    //         Email.Send(EmailMsg, Enum::"Email Scenario"::Default);
    //         // SMTPMail.Send;
    //         MESSAGE('mail Sent Successfuly');

    //     end;
    // end;

    // 1st code*************
    // procedure AutoMailAttacmentTest(SalesInvNo: Code[20])
    // var
    //     EmailAccount: Record "Email Account";
    //     EmailMsg: Codeunit "Email Message";
    //     Email: Codeunit Email;
    //     CompanyInfo: Record "Company Information";
    //     FileName: Text;
    //     FileManagment: Codeunit "File Management";
    //     //TempBlob: Record 99008535 temporary;
    //     gFileName: Text;
    //     RepPurReceipt: Report "Purchase - Receipt";
    //     RecSalesInv: Record "Sales Invoice Header";
    //     RecCustomer: Record Customer;
    //     RepSalesInv: Report "Standard Sales - Invoice";
    //     gPurRecHdr: Record "Purch. Rcpt. Header";
    //     GVendor: Record Vendor;
    //     RecSalesCrMemoHdr: Record "Sales Cr.Memo Header";
    //     RepSalesCrMemo: Report "Standard Sales - Credit Memo";
    //     RepSalesInvoice: Report 1306;//tk
    //     FileManagment1: Codeunit "File Management";
    //     PathSalesInvoiceNo: Text;
    //     PathSalesCRNNo: Text;
    //     Statement: Report "Standard Statement";
    //     RecLoc: Record Location;
    //     torecipients: List of [Text];

    //     ccRecipients: List of [Text];

    //     BccRecipients: List of [Text];
    //     tempBlob: Codeunit "Temp Blob";
    //     out: OutStream;
    //     instr: InStream;
    //     ReportId: Integer;

    //     RecRef: RecordRef;
    //     MyPath: Text;
    // begin
    //     PathSalesInvoiceNo := CONVERTSTR(SalesInvNo, '/', '-');
    //     gFileName := 'F:\SalesInvoiceMail\sales Invoice ' + PathSalesInvoiceNo + '.pdf';
    //     CompanyInfo.GET;
    //     RecSalesInv.RESET;
    //     RecSalesInv.SETRANGE("No.", SalesInvNo);
    //     IF RecSalesInv.FINDFIRST THEN BEGIN
    //         RecCustomer.RESET;
    //         RecCustomer.GET(RecSalesInv."Sell-to Customer No.");
    //         //RecCustomer.TESTFIELD("E-Mail");
    //         IF RecCustomer."E-Mail" <> '' THEN BEGIN

    //             CLEAR(RepSalesInv);
    //             RepSalesInv.SETTABLEVIEW(RecSalesInv);
    //             // RepSalesInv.SAVEASPDF(gFileName);
    //             CLEAR(RepSalesInvoice);
    //             RepSalesInvoice.SETTABLEVIEW(RecSalesInv);
    //             //RepSalesInvoice.SAVEASPDF(gFileName);
    //             //  REPORT.SAVEASPDF(50003, gFileName, RecSalesInv);//Rushab Commented
    //             Report.SaveAs(50003, '', ReportFormat::Pdf, out, RecRef);//Rushab add new
    //             tempBlob.CreateInStream(instr);
    //             //MyPath := StrSubstNo('%2_%1.pdf', SalesInvNo, 'Purchase Receipt');    

    //             //SLEEP(1000);

    //             EmailAccount.GET;
    //             EmailAccount.TESTFIELD(Connector);
    //             //EmailMsg.Create(EmailAccount."Email Address", EmailAccount."Email Address", RecCustomer."E-Mail", 'Kwality- Sales Invocie Attachment', '', TRUE);
    //             torecipients.Add(RecCustomer."E-Mail");
    //             ccRecipients.Add('Salesadmin@Kwalityspices.com');
    //             ccRecipients.Add('it@Kwalityspices.com');
    //             // SmtpMail.AddCC('Salesadmin@Kwalityspices.com');
    //             // SmtpMail.AddCC('it@kwalityspices.com');
    //             // SmtpMail.AddCC('dhananjaya@Kwalityspices.com');
    //             EmailMsg.Create(torecipients, 'Kwality- Sales Invocie Attachment', '', true, ccRecipients, BccRecipients);
    //             EmailMsg.AppendToBody('Dear Sir / Madam, <BR><BR>');
    //             EmailMsg.AppendToBody(RecCustomer.Name + ' <BR><BR>');
    //             RecLoc.SETFILTER(Code, RecSalesInv."Location Code");
    //             EmailMsg.AppendToBody('Please find attached Details of the Sales Invoice No.:' + RecSalesInv."No." + ' Dated: ' + FORMAT(RecSalesInv."Posting Date") + ' Shipped from ' + RecLoc.Name + 'against your order.');
    //             EmailMsg.AppendToBody('<BR><BR>');
    //             EmailMsg.AppendToBody('Please contact the Shipping centre for further details.<BR><BR>');
    //             EmailMsg.AppendToBody('Regards, <BR>');
    //             EmailMsg.AppendToBody('Stores Department <BR>');
    //             EmailMsg.AppendToBody('PAGARIYA FOOD PRODUCTS PVT. LTD. <BR>');
    //             EmailMsg.AppendToBody('"An ISO 22000: 2005 certified company" <BR>');
    //             EmailMsg.AppendToBody('Plot No-302A, Phase-2, KIADB Industrial Area, <BR>');
    //             EmailMsg.AppendToBody('Harohalli, Taluk Kanakapura, Dist: Ramanagara – 562112 <BR>');
    //             EmailMsg.AppendToBody('Phone: 080-29760165 <BR>');
    //             EmailMsg.AppendToBody('www.kwalityspices.com <BR><BR>');
    //             EmailMsg.AppendToBody('Auto generated email please do not reply to the mail<BR><BR>');
    //             EmailMsg.AppendToBody('Attachment of the Sales Should be sent along with the Email.');
    //             EmailMsg.AddAttachment(gFileName, 'Posted Sales Invoice-Kwality.pdf', '');
    //             //SLEEP(3000);
    //             Email.Send(EmailMsg, Enum::"Email Scenario"::Default);
    //             MESSAGE('Mail Sent Successful!');
    //         END;
    //     END;
    // end;

    //Tetnant error****************
    // procedure SentMailAttachmnet(SalesHeader: Record "Sales Header")
    // var
    //     EmailAccount: Record "Email Account";
    //     EmailMsg: Codeunit "Email Message";
    //     Email: Codeunit Email;
    //     flag: Boolean;
    //     BodyText: text;
    //     outstream: OutStream;
    //     instream: InStream;
    //     reportPO: report 1306;
    //     tempblob: Codeunit "Temp Blob";
    //     Customer: record Customer;
    //     VendEmail: text;
    // begin
    //     if Customer.get(SalesHeader."Sell-to Customer No.") then
    //         VendEmail := Customer."E-Mail";
    //     BodyText := '<B>Greetings from Kwality Foods</B>' + '<br><br>' + '<br>Dear Sir/Madam,' + '<br>Please find the attached Purchase Order.'
    //      + '<br>Kindly arrange to despatch the Material along with COA .';
    //     // BodyText := 'Dear ' + 'SIR' + ',<br>' + '<br>Please find the below mentioned Details of PO.';
    //     EmailMsg.Create(VendEmail, 'Purchase Order ' + SalesHeader."No.", BodyText, TRUE);
    //     // reportPO.SetTableView(SalesHeader); //yash
    //     tempblob.CreateOutStream(outstream);
    //     //flag := reportPO.SaveAs('', ReportFormat::Pdf, outstream); //yash
    //     tempblob.CreateInStream(instream);
    //     EmailMsg.AddAttachment('Purchase Order ' + SalesHeader."No." + '.pdf', 'PDF', instream);
    //     EmailMsg.AppendToBody('<br><br>');
    //     EmailMsg.AppendToBody('<p style="color:red;"><U>1.Note : COA is Mandatory without COA material will; not unloaded</U></p>');
    //     EmailMsg.AppendToBody('<br>1.Delivery Location :Harohalli ( Industrial Area 2ND Phase)');
    //     EmailMsg.AppendToBody('<br><B>2.Dispatch date:' + Format(SalesHeader."Posting Date") + '</B>');
    //     EmailMsg.AppendToBody('<br><B>3.Payment Terms :' + SalesHeader."Payment Terms Code" + '</B>');
    //     EmailMsg.AppendToBody('<br><B>4.Delivery :Harohalli Industrial area</B>');
    //     EmailMsg.AppendToBody('<br>5.Special Note : Material should be delivery before 4.30 to factory if its reached after 4.30 Material will be unloaded next day.');
    //     EmailMsg.AppendToBody('<br>6.No Hamali ( Unloaders )  allowed inside till Covid -19 clear');
    //     EmailMsg.AppendToBody('<br>7.Material Should be as per Specification only.');
    //     EmailMsg.AppendToBody('<br>8.RM above one ton Weighment is Mandatory');
    //     EmailMsg.AppendToBody('<br>9.RM materials Should be Free from Foreign particles');
    //     EmailMsg.AppendToBody('<br>10.Any quality deviation Entire lot will be rejected');
    //     EmailMsg.AppendToBody('<br><br>');
    //     EmailMsg.AppendToBody('<U><B>11.Billing and Delivery Address :</U></B>');
    //     EmailMsg.AppendToBody('<br><br>');
    //     EmailMsg.AppendToBody('<B>Pagariya Food Products Pvt Ltd.,</B>');
    //     EmailMsg.AppendToBody('<br><B>Factory:</B>' + 'Unit Plot No # 302 A, Phase -2,');
    //     EmailMsg.AppendToBody('<br>KIADB Industrial Estate, Harohalli');
    //     EmailMsg.AppendToBody('<br>Taluka Kanakapura, Dist Ramanagara,');
    //     EmailMsg.AppendToBody('<br>Pin Code: 562 112, Karnataka State, India.');
    //     EmailMsg.AppendToBody('<br>GST :' + '<B>29AAFCP2699J1ZQ .');
    //     //yash  if flag then begin
    //     Email.Send(EmailMsg, Enum::"Email Scenario"::Default);
    //     // SMTPMail.Send;
    //     MESSAGE('mail Sent Successfuly');


    // end;
}












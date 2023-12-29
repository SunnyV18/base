codeunit 50100 lalitcodeAutomail
{
    // trigger OnRun()
    // begin
    // end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnBeforeSendPostedDocumentRecord, '', false, false)]
    local procedure "Sales-Post_OnBeforeSendPostedDocumentRecord"(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean; var DocumentSendingProfile: Record "Document Sending Profile");
    begin
        IsHandled := true;
        //SalesHeader.EmailRFQAttachment(SalesHeader);
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

tableextension 50105 MyExtension4 extends "Sales Prepayment %"
{
    fields
    {
        field(60100; "E-Mail Sent"; Boolean)
        {
            Caption = 'E-Mail Sent';
            DataClassification = ToBeClassified;
        }
        // Add changes to table fields here
    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }


    procedure EmailRFQAttachment(PurchHeader: Record "Sales Header")
    var
        Vendor: Record Customer;
        PurchHdr: Record "Sales Header";
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
    //PurchaseInvoiceHeaderEdit: Codeunit 50002;
    begin
        // if PurchHeader."E-Mail sent" = true then
        //     Error('Mail has been already sent so you can not sent again');

        IF (PurchHeader."Sell-to Customer No." <> '') THEN BEGIN
            Vendor.GET(PurchHeader."Sell-to Customer No.");
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


    var
        CompanyInfo: Record "Company Information";
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        Receipent: List of [Text];
        Body: Text;

        Contact: Record 5050;
        CC: List of [Text];
}
// reportextension 50100 PurchaseInvoiceReportExt1 extends 50113
// {
//     dataset
//     {
//         modify(Header)
//         {
//             trigger OnBeforePreDataItem()
//             var
//             begin
//                 if glDocNo <> '' then
//                     SetRange("No.", glDocNo);
//             end;
//         }
//     }
//     procedure setdocno(DocNo: Code[20])
//     begin
//         glDocNo := DocNo;
//     end;

//     var
//         glDocNo: Code[20];
// }
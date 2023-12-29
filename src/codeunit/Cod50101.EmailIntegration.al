codeunit 50101 "Email Integration"
{
    procedure EmailAttachment(PurchHeader: Record "Purch. Inv. Header")
    var
        Vendor: Record Vendor;
        PurchHdr: Record "Purch. Inv. Header";
        Subject: Text[100];
        AttachementTempBlob: Codeunit "Temp Blob";
        AttachmentInstream: InStream;
        AttachementOutstream: OutStream;
        FileMgt: Codeunit "File Management";
        recPurchref: RecordRef;
        repRequestForQuote: Report 406;
        MailSent: Boolean;
        FilePath: Text;

    begin

        if PurchHeader."E-Mail" = true then //yash
                                            // Error('Mail has been already sent so you can not sent again');

            IF (PurchHeader."Buy-from Vendor No." <> '') THEN BEGIN
                Vendor.GET(PurchHeader."Buy-from Vendor No.");
                Vendor.TESTFIELD(Vendor."E-Mail");
                AttachementTempBlob.CreateOutStream(AttachementOutstream);
                repRequestForQuote.SetTableView(PurchHeader);
                repRequestForQuote.setdocno(PurchHeader."No.");
                repRequestForQuote.SaveAs('', ReportFormat::Pdf, AttachementOutstream);
                AttachementTempBlob.CreateInStream(AttachmentInstream);
                // Receipent.Add(Contact."E-Mail");
                Receipent.Add(Vendor."E-Mail");
                CCReceipent2.Add('yogender.rana@robo-soft.net');
                CLEAR(Subject);
                // IF PurchHeader."Requisition No." <> '' THEN
                //    Subject := 'IMR No.: ' + PurchHeader."Requisition No." + ' ';
                Subject += 'Invoice No.: ' + PurchHeader."No.";
                Body := 'Dear Vendor,' + PurchHeader."Buy-from Vendor Name" + '</br>';//Amit Modifid
                Body += '</br>';
                Body += 'Please find attached Invoice' + '</br>';
                Body += 'kindly do payment' + '</br>';
                Body += '</br>';
                Body += '</br>';
                body += 'Regards' + '</br>';
                Body += USERID + '</br>';
                //Body += 'Chief Executive Officer (CEO)' + '</br>';
                Body += '<h7 style="color:blue;"></h7>' + '</br>';
                //Body += '<p style="color:blue;">''Chief Executive Officer (CEO)' + '</p>' + '</br>';
                Body += '<a href="https://robo-soft.com/wp-content/uploads/2019/02/mictosoft-gold-partner-in-dubai.jpg" target="_blank"><img src="https://robo-soft.com/wp-content/uploads/2019/02/mictosoft-gold-partner-in-dubai.jpg" width = "516" height = "136"/></a>' + '</br>';
                //Body += '<img src="C:\Users\amit.pandey\Desktop\New folder (2)\AlPrac\AlPrac\logo.jpg"></br>';
                Body += '<b>Robosoft Solution Pvt Ltd.</b>, 301-302, Arya Arcade, Vikhroli station road, Vikhroli West, Mumbai, 400 079, <b>India.</b>' + '</br>';
                Body += '<b>Robosoft Solution LLC.</b>, 232, Regus Bldg., D-Ring Road, Al Madder Al Qadeem Street, Doha, PO Box 32522,<b> Qatar.</b>' + '</br>';
                Body += '<b>Robosoft Solutions DMCC.</b>, 2104, One lake plaza, Cluster T, Jumeirah lakes towers, Dubai, <b>UAE.</b>' + '</br>';
                Body += '<b>Robosoft Dynamics Solution LLC.</b>, 1259, Lakeside drive, #1214, Sunnyvale, CA -94085, <b>USA.</b>' + '</br>';
                Body += '<b>Robosoft Consulting Ltd.</b>, 3, Jubilee house, Great Warley, Brentwood, CM13 3FR, Essex, <b>UK</b>' + '</br>' + '</br>' + '</br>' + '</br>' + '</br>';
                EmailMessage.Create(Receipent, Subject, Body, true, CCReceipent2, CCReceipent2);
                EmailMessage.AddAttachment('PurchInvReport.Pdf', 'PDF', AttachmentInstream);
                if Email.Send(EmailMessage, Enum::"Email Scenario"::Default) then
                    MailSent := true;
                Message('%1', MailSent);
                //if MailSent then
                // PurchaseInvoiceHeaderEdit.UpdatePurchaseInvoiceHeader(PurchHeader, MailSent, TODAY);
            end;
    end;

    var
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        Receipent: List of [Text];

        CCReceipent2: List of [Text];
        Body: Text;
        Contact: Record Contact;
}
reportextension 50100 PurchaseInvoiceReportExt extends "Purchase - Invoice"
{
    dataset
    {
        modify("Purch. Inv. Header")
        {
            trigger OnBeforePreDataItem()
            var
            begin
                if glDocNo <> '' then
                    SetRange("No.", glDocNo);
            end;
        }
    }
    procedure setdocno(DocNo: Code[20])
    begin
        glDocNo := DocNo;
    end;

    var
        glDocNo: Code[20];
}
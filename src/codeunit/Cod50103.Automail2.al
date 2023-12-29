codeunit 50103 Automail2
{
    trigger OnRun()
    begin

    end;

    procedure Autoemailforsalesheader(SalesInvNo: Code[20])
    var
        //SalesInvNo: Code[20];
        myInt: Integer;
        EmailAccount: Record "Email Account";
        EmailMsg: Codeunit "Email Message";
        Email: Codeunit Email;
        CompanyInfo: Record "Company Information";
        FileName: Text;
        FileManagment: Codeunit "File Management";
        //TempBlob: Record 99008535 temporary;
        gFileName: Text;
        RepPurReceipt: Report "Purchase - Receipt";
        RecSalesInv: Record "Sales Invoice Header";
        RecCustomer: Record Customer;
        RepSalesInv: Report "Standard Sales - Invoice";
        gPurRecHdr: Record "Purch. Rcpt. Header";
        GVendor: Record Vendor;
        RecSalesCrMemoHdr: Record "Sales Cr.Memo Header";
        RepSalesCrMemo: Report "Standard Sales - Credit Memo";
        RepSalesInvoice: Report 1306;//tk //Yash
        FileManagment1: Codeunit "File Management";
        PathSalesInvoiceNo: Text;
        PathSalesCRNNo: Text;
        Statement: Report "Standard Statement";
        RecLoc: Record Location;
        torecipients: List of [Text];

        ccRecipients: List of [Text];

        BccRecipients: List of [Text];
        tempBlob: Codeunit "Temp Blob";
        out: OutStream;
        instr: InStream;
        ReportId: Integer;

        RecRef: RecordRef;
        MyPath: Text;
        FinalAmount: Decimal;

        Getterms: text[30];
        term: Record "Payment Terms";
    begin
        PathSalesInvoiceNo := CONVERTSTR(SalesInvNo, '/', '-');
        gFileName := 'F:\SalesInvoiceMail\sales Invoice ' + PathSalesInvoiceNo + '.pdf';
        CompanyInfo.GET;
        term.Reset();
        term.SetRange(term.Code, RecSalesInv."Payment Terms Code");
        if term.FindFirst() then begin
            Getterms := term.Description;
        end;
        RecSalesInv.RESET;
        RecSalesInv.SETRANGE("No.", SalesInvNo);
        IF RecSalesInv.FINDFIRST THEN BEGIN
            RecCustomer.RESET;
            RecCustomer.GET(RecSalesInv."Sell-to Customer No.");
            //RecCustomer.TESTFIELD("E-Mail");
            IF RecCustomer."E-Mail" <> '' THEN BEGIN

                CLEAR(RepSalesInv);
                RepSalesInv.SETTABLEVIEW(RecSalesInv);
                // RepSalesInv.SAVEASPDF(gFileName);
                CLEAR(RepSalesInvoice); //yash
                RepSalesInvoice.SETTABLEVIEW(RecSalesInv);//yash
                //RepSalesInvoice.SAVEASPDF(gFileName);
                //  REPORT.SAVEASPDF(50003, gFileName, RecSalesInv);//Rushab Commented
                Report.SaveAs(50003, '', ReportFormat::Pdf, out, RecRef);//Rushab add new
                tempBlob.CreateInStream(instr);
                //MyPath := StrSubstNo('%2_%1.pdf', SalesInvNo, 'Purchase Receipt');     

                //SLEEP(1000);

                EmailAccount.GET;
                EmailAccount.TESTFIELD(Connector);
                //EmailMsg.Create(EmailAccount."Email Address", EmailAccount."Email Address", RecCustomer."E-Mail", 'Kwality- Sales Invocie Attachment', '', TRUE);
                torecipients.Add(RecCustomer."E-Mail");
                ccRecipients.Add('yash@cocoonitservices.com');
                ccRecipients.Add('aryak@cocoonitservices.com');
                // SmtpMail.AddCC('Salesadmin@Kwalityspices.com');
                // SmtpMail.AddCC('it@kwalityspices.com');
                // SmtpMail.AddCC('dhananjaya@Kwalityspices.com');
                EmailMsg.Create(torecipients, 'NEW CONFIRMED ORDER INVOICE COPY', '', true, ccRecipients, BccRecipients);
                EmailMsg.AppendToBody('Dear Sir / Madam, <BR><BR>');
                EmailMsg.AppendToBody(RecCustomer.Name + ' <BR><BR>');
                RecLoc.SETFILTER(Code, RecSalesInv."Location Code");
                //EmailMsg.AppendToBody('THANK YOU DR FOR SHARING YOUR VALUABLE ORDER RECEIVED AT OUR OFFICE ON:',RecSalesInv."Posting Date", ' Dated.<BR>');
                EmailMsg.AppendToBody('THANK YOU DR FOR SHARING YOUR VALUABLE ORDER RECEIVED AT OUR OFFICE ON:' + RecSalesInv."No." + ' and Date: ' + FORMAT(RecSalesInv."Posting Date"));
                EmailMsg.AppendToBody('<BR><BR>');
                EmailMsg.AppendToBody('WE ARE SHARING YOU THE INVOICE COPY ATTACHED TO THIS MAIL. THEDETAILS OF CONFIRMED ORDER WITH PRODUCTS IS AS FOLLOWS:<BR><BR>');
                EmailMsg.AppendToBody('INVOICE NO.' + RecSalesInv."No." + '<BR>' + 'DATE OF BILLING' + Format(RecSalesInv."Order Date") + '<BR>' + 'AmountRs' + '<BR>' + 'Due Date For Period' + Format(RecSalesInv."Due Date") + '<BR>' + 'CREDIT PERIOD' + Getterms);
                EmailMsg.AppendToBody('WE LOOK FORWARD TO YOUR CONTINOUS SUPPORT FOR OUR ESTEEMED GLOBAL BRANDS., <BR>');
                EmailMsg.AppendToBody('DR SHARING YOU OUR COMPANY CURRENT ACCOUNT BANK DETAILS BANK DETAILS/ QR CODE IMAGE');
                EmailMsg.AppendToBody(' BANK Name' + CompanyInfo."Bank Name" + ' BANK NO.' + CompanyInfo."Bank Account No.");
                EmailMsg.AppendToBody('Regards, <BR>');
                EmailMsg.AppendToBody(CompanyInfo.Name + '<BR>');
                // EmailMsg.AppendToBody('PAGARIYA FOOD PRODUCTS PVT. LTD. <BR>');
                // EmailMsg.AppendToBody('"An ISO 22000: 2005 certified company" <BR>');
                // EmailMsg.AppendToBody('Plot No-302A, Phase-2, KIADB Industrial Area, <BR>');
                // EmailMsg.AppendToBody('Harohalli, Taluk Kanakapura, Dist: Ramanagara – 562112 <BR>');
                // EmailMsg.AppendToBody('Phone: 080-29760165 <BR>');
                // EmailMsg.AppendToBody('www.kwalityspices.com <BR><BR>');
                // EmailMsg.AppendToBody('Auto generated email please do not reply to the mail<BR><BR>');
                // EmailMsg.AppendToBody('Attachment of the Sales Should be sent along with the Email.');
                // EmailMsg.AddAttachment(gFileName, 'Posted Sales Invoice-Kwality.pdf', '');
                //SLEEP(3000);
                Email.Send(EmailMsg, Enum::"Email Scenario"::Default);
                MESSAGE('Mail Sent Successful!');
            END;
        END;
    end;

}
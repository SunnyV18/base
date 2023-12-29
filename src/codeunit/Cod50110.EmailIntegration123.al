codeunit 50110 "Email Integration123"
{
    //Naveen Code
    procedure SentMailAttachmnet(var docNo: Code[20])
    var
        SalesHeader: Record "Sales Invoice Header";
        EmailAccount: Record "Email Account";
        EmailMsg: Codeunit "Email Message";
        flag: Boolean;
        BodyText: text;
        outstream: OutStream;
        instream: InStream;
        reportPO: report 1306;
        tempblob: Codeunit "Temp Blob";
        Vendor: record Customer;
        VendEmail: text;
        VendEmail2: text;
        company: Record "Company Information";
    begin
        if SalesHeader.get(docNo) then begin
            if Vendor.get(SalesHeader."Bill-to Customer No.") then
                VendEmail := Vendor."E-Mail";
            VendEmail2 := Vendor."E-Mail";
            BodyText := '<br><br>' + '<br>Dear Sir/Madam,' + '</B>';
            Receipent.Add('nkparea@gmail.com');
            Receipent.ADD(VendEmail);
            // BodyText := 'Dear ' + 'SIR' + ',<br>' + '<br>Please find the below mentioned Details of PO.';
            EmailMsg.Create(Receipent, 'Sales Invoice ' + SalesHeader."No.", BodyText, true);
            reportPO.SetTableView(SalesHeader);
            tempblob.CreateOutStream(outstream);
            //reportPO.setdocno(docNo);
            flag := reportPO.SaveAs('', ReportFormat::Pdf, outstream);

            tempblob.CreateInStream(instream);
            EmailMsg.AddAttachment('Sales Invoice ' + SalesHeader."No." + '.pdf', 'PDF', instream);
            // EmailMsg.AppendToBody('<br><br>');
            //EmailMsg.AppendToBody('<p style="color:red;"><U>1.Note : COA is Mandatory without COA material will not unloaded</U></p>');
            EmailMsg.AppendToBody('<br>Thank you dr for sharing your valuable order received at our office on ' + ' Date : ' + Format(SalesHeader."Posting Date") + '</B>');
            // EmailMsg.AppendToBody('<br>Kindly arrange to despatch the Material along with COA.' + '</B>');
            EmailMsg.AppendToBody('<br><br>');
            EmailMsg.AppendToBody('<br>We are sharing you the invoice copy attached to this mail.' + '</B>');
            EmailMsg.AppendToBody('<br>The details of cofirmed order with products is as follows:' + '</B>');
            EmailMsg.AppendToBody('<br><br>');
            EmailMsg.AppendToBody('<br>Invoice No : ' + SalesHeader."No." + '</B>');
            EmailMsg.AppendToBody('<br>Date of Billing : ' + Format(SalesHeader."Posting Date") + '</B>');
            SalesHeader.CalcFields(Amount);
            EmailMsg.AppendToBody('<br>Amount Rs. : ' + Format(SalesHeader.Amount) + '</B>');
            EmailMsg.AppendToBody('<br>Due date for payment : ' + Format(SalesHeader."Due Date") + '</B>');
            EmailMsg.AppendToBody('<br>Credit Period : ' + SalesHeader."Payment Terms Code" + '</B>');
            EmailMsg.AppendToBody('<br><br>');
            EmailMsg.AppendToBody('<br>We look forward to your continous support for our esteemed global brands.' + '</B>');
            EmailMsg.AppendToBody('<br><br>');
            EmailMsg.AppendToBody('<br>Dr sharing you our company current account bank details.' + '</B>');
            EmailMsg.AppendToBody('<br>Bank details/ QR Code Image' + '</B>');
            EmailMsg.AppendToBody('<br>Bank Name : ' + 'KOTAK MAHINDRA BANK' + '</B>');
            EmailMsg.AppendToBody('<br>IFSC CODE : ' + 'KKBK0001383' + '</B>');
            EmailMsg.AppendToBody('<br>Bank Account No. : ' + '3845591320' + '</B>');
            EmailMsg.AppendToBody('<br>BRANCH NAME : ' + '001383' + '</B>');
            EmailMsg.AppendToBody('<br><br>');
            EmailMsg.AppendToBody('<br>Regards' + '</B>');
            EmailMsg.AppendToBody('<br>' + CompanyName);
            if flag then begin
                Email.Send(EmailMsg, Enum::"Email Scenario"::Default);
                // SMTPMail.Send;
                MESSAGE('mail Sent Successfuly');

            end;

        end;
    end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document-Mailing", OnBeforeSendEmail, '', false, false)]
    // local procedure OnBeforeSendEmail(var TempEmailItem: Record "Email Item" temporary);
    // begin
    //     TempEmailItem."Send CC" := 'nkparea@gmail.com';
    //     // TempEmailItem."Send BCC" := '222@c.com';
    // end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnAfterPostSalesDoc, '', false, false)]
    local procedure OnAfterPostSalesDoc(var SalesHeader: Record "Sales Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; SalesShptHdrNo: Code[20]; RetRcpHdrNo: Code[20]; SalesInvHdrNo: Code[20]; SalesCrMemoHdrNo: Code[20]; CommitIsSuppressed: Boolean; InvtPickPutaway: Boolean; var CustLedgerEntry: Record "Cust. Ledger Entry"; WhseShip: Boolean; WhseReceiv: Boolean; PreviewMode: Boolean)
    var
        saleinvheader: Record "Sales Invoice Header";
        docNo: Code[20];
    begin
        saleinvheader.Reset();
        saleinvheader.SetRange("Pre-Assigned No.", salesHeader."No.");
        saleinvheader.SetRange("Bill-to Customer No.", salesHeader."Bill-to Customer No.");
        if saleinvheader.FindFirst() then begin
            docNo := saleinvheader."No.";
            SentMailAttachmnet(docNo);
        end;
    end;

    var
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        Receipent: List of [Text];
        Body: Text;

        Contact: Record 5050;
        CC: List of [Text];
        CC1: List of [Text];
}
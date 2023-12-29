Report 50111 "Automail"
{
    ProcessingOnly = true;
    UsageCategory = Lists;
    ApplicationArea = all;

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            column(ReportForNavId_1000000000; 1000000000)
            {
            }
            column(Srno; Srno)
            {
            }
            column(CompInfo_Pict; CompInfo.Picture)
            {
            }
            column(Compinfo_Name; CompInfo.Name)
            {
            }
            trigger OnAfterGetRecord()
            begin
                Srno += 1;
                CheckDate := Today - 1;
                CheckDate1 := Today;
                /*CheckDate := 20221121D - 1;
                CheckDate1 := 20221121D;*/
                /*IF CheckDate = "Sales Invoice Transaction API"."Document Date" THEN
                  MakeExcelDataBody
                ELSE
                 CurrReport.SKIP;*/
                //     if(CheckDate = "Sales Header"."Document Date") or (CheckDate1 = Dt2Date("Sales Header".CaseEnd;))then begin
                //         if(CheckDate1 = Dt2Date("Sales Invoice Transaction API"."CASE ID"))then begin
                //             if((("Sales Invoice Transaction API".Type = 'MODIFICATION') or ("Sales Invoice Transaction API".Type = 'CANCELLATION')) and (CheckDate <> "Sales Invoice Transaction API"."Document Date"))then MakeExcelDataBody;
                //         end;
                //         MakeExcelDataBody;
                //     end
                //     else
                //         CurrReport.Skip;
                // //MakeExcelDataBody;
                // end;
                // trigger OnPreDataItem()
                // begin
                //     Srno:=0;
                //     CheckDate:=0D;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(Option)
                {
                    Caption = 'Option';
                    Visible = false;

                    field("From Date :"; FromDate)
                    {
                        ApplicationArea = Basic;
                    }
                    field("To Date :"; ToDate)
                    {
                        ApplicationArea = Basic;
                    }
                }
            }
        }
        actions
        {
        }
    }
    labels
    {
        SNo = 'S. No.';
        NameofGoods = 'Name of Goods';
    }
    trigger OnInitReport()
    begin
        CurrDoc := 'CRONUS';
    end;

    trigger OnPostReport()
    begin
        //CreateExcelbook;
        if PrintToExcel then begin
            CreateExcelbook;
            SendMail();
        end;
    end;

    trigger OnPreReport()
    begin
        ExcelBuf.DeleteAll;
        PrintToExcel := true;
        SharedFileName := 'D:\Reports\Policy Log Report.xlsx'; //Text Variable
        SheetName := 'Policy Log Report.xlsx'; //Text variable
        CompInfo.Get;
        CompInfo.CalcFields(Picture);
        MakeExcelInfo;
    end;

    var
        Srno: Integer;
        IGSTAmt: Decimal;
        SGSTAmt: Decimal;
        CGSTAmt: Decimal;
        ExcelBuf: Record "Excel Buffer";
        CurrDoc: Code[20];
        DocCounter: Integer;
        I: Integer;
        CompInfo: Record "Company Information";
        FromDate: Date;
        ToDate: Date;
        RecCust: Record Customer;
        CustName: Text;
        SGSTGLAcc: Code[20];
        CGSTGLAcc: Code[20];
        IGSTGLAcc: Code[20];
        SGSTEntryNo: Text;
        CGSTEntryNo: Text;
        IGSTEntryNo: Text;
        RecDetailedGSTLedEntry: Record "Detailed GST Ledger Entry";
        "HSN/SACCode": Code[20];
        SGSTComCode: Code[20];
        CGSTComCode: Code[20];
        IGSTComCode: Code[20];
        GSTJuriType: Option Intrastate,Interstate;
        NatureOfSupply: Option B2B,B2C;
        SGSTPer: Decimal;
        CGSTPer: Decimal;
        IGSTPer: Decimal;
        LocStateCode: Code[20];
        BuyerSellerStateCode: Code[20];
        ShippingAddrStateCode: Code[20];
        LocationRegNo: Code[20];
        BuyerSellerRegNo: Code[20];
        GSTGroupType: Option Goods,Service;
        InvoiceType: Code[20];
        RefInvoiceNumber: Code[20];
        EATransactionType: Option " ",B2B,B2C;
        RecVend: Record Vendor;
        RecPIH: Record "Purch. Inv. Header";
        RecPCrH: Record "Purch. Cr. Memo Hdr.";
        RecSIH: Record "Sales Invoice Header";
        RecSCrH: Record "Sales Cr.Memo Header";
        DocDate: Date;
        InvDate: Date;
        MaxLengh: Integer;
        Lenght: Integer;
        GSTBaseAmt: Decimal;
        GSTBaseAmt1: Decimal;
        FileName: Text;
        emailmsg: Codeunit "Email Message";
        PrintToExcel: Boolean;
        SharedFileName: Text;
        SheetName: Text;
        CheckDate: Date;
        CheckDate1: Date;

    procedure MakeExcelInfo()
    begin
        MakeExcelDataHeader;
    end;

    local procedure MakeExcelDataHeader()
    begin
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(CompInfo.Name, false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('Policy Log Report', false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('Date :' + Format(Today - 1), false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        //ExcelBuf.AddColumn('Date :'+FORMAT(20222404D-1),FALSE,'',TRUE,FALSE,TRUE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('Document No.', false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('Document Date', false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('Policy No.', false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('Client Name', false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('Brand Royalty', false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('Dealer Commission', false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('EA Fees', false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('Response', false, '', true, false, true, '', ExcelBuf."cell type"::Text);
    end;

    procedure CreateExcelbook()
    begin
        ExcelBuf.SetFriendlyFilename('Booking FOREIGN Vendors Report.xlsx');
        ExcelBuf.OpenExcel();
        //ExcelBuf.CreateBookAndOpenExcel('D:\Reports\Policy Log Report.xlsx','Policy Log Report','Policy Log Report',COMPANYNAME,USERID);
        //ExcelBuf.CreateBookForJobQueue(SharedFileName, SheetName, '', COMPANYNAME, UserId);//Naveen
    end;

    procedure MakeExcelDataBody()
    begin
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn("Sales Header"."Document Date", false, '', false, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn("Sales Header"."Document Date", false, '', false, false, false, '', ExcelBuf."cell type"::Date);
        ExcelBuf.AddColumn("Sales Header"."No.", false, '', false, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn("Sales Header"."Sell-to Customer Name", false, '', false, false, false, '', ExcelBuf."cell type"::Text);
        // ExcelBuf.AddColumn("Sales Invoice Transaction API"."Brand Royalty", false, '', false, false, false, '', ExcelBuf."cell type"::Number);
        // ExcelBuf.AddColumn("Sales Invoice Transaction API"."Dealer Commission", false, '', false, false, false, '', ExcelBuf."cell type"::Number);
        // ExcelBuf.AddColumn("Sales Invoice Transaction API"."EA Fees", false, '', false, false, false, '', ExcelBuf."cell type"::Number);
        // ExcelBuf.AddColumn("Sales Invoice Transaction API".Response, false, '', false, false, false, '', ExcelBuf."cell type"::Text);
    end;

    procedure EntryCount(DocNo: Code[20]): Integer
    var
        RecGSTLedEntry: Record "GST Ledger Entry";
    begin
    end;

    local procedure SendMail()
    var
        outstrm: OutStream;
        instrm: InStream;
        email: Codeunit Email;
        tempblob: Codeunit "Temp Blob";
        torecipients: List of [Text];
        ccRecipients: List of [Text];
        BccRecipients: List of [Text];
    begin
        //emailmsg.Get;//409
        emailmsg.Create(torecipients, 'Automated Purchase Invoices Log', '', true, ccRecipients, BccRecipients);
        // emailmsg.Create('Navision', SMTPSetup."User E-Mail ID", 'naveen@cocoonitservices.com', 'Policy Details Log From NAV', '', true);//CCIT---Naveen--1511022
        emailmsg.AppendToBody('Dear ' + 'Finance Team,');
        emailmsg.AppendToBody('<br><br>');
        emailmsg.AppendToBody('Please find attachment of Policy Details Log in NAV - ' + Format(CheckDate));
        emailmsg.AppendToBody('<br><br>');
        emailmsg.AppendToBody('Thanks & Regards,');
        emailmsg.AppendToBody('<br><br>');
        emailmsg.AppendToBody('Navision Team.');
        emailmsg.AppendToBody('<br><br>');
        //emailmsg.AddAttachment(SharedFileName, SheetName);
        // emailmsg.AddCC('mmishra@europ-assistance.in;sbompada@europ-assistance.in;supadhyay@europ-assistance.in;nsharma@europ-assistance.in;ssaple.extern@europ-assistance.in;sudeepm@europ-assistance.in;skarale@europ-assistance.in');
        //SMTPMail.AddCC('owais@cocoonitservices.com');
        // emailmsg.Send;  //400
        emailmsg.AddAttachment(FileName, 'EXCEL', instrm);
        email.Send(emailmsg, Enum::"Email Scenario"::Default)
    end;
}

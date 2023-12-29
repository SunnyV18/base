report 50104 "Purchase Order Report Arya"
{
    Caption = 'Purchase Order Report';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'PurchaseOrderReportArya.rdl';

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")

        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.";
            column(No_; "No.") { }
            column(Pay_to_Name; "Pay-to Name")
            {
            }
            column(Pay_to_Address; "Pay-to Address")
            {
            }
            column(Pay_to_Address_2; "Pay-to Address 2")
            {
            }
            column(Pay_to_City; "Pay-to City")
            {
            }
            column(Pay_to_Post_Code; "Pay-to Post Code")
            {
            }
            column(No_DataItemName; "No.")
            {
            }
            column(PostingDate_DataItemName; "Posting Date")
            {
            }
            column(LocationCode_DataItemName; "Location Code")
            {
            }
            column(PaymentTermsCode_DataItemName; "Payment Terms Code")
            {
            }
            column(compName; compinfo.Name) { }
            column(compAddrs1; compinfo.Address) { }
            column(compAddrs2; compinfo."Address 2") { }
            column(compCity; compinfo.City) { }
            column(compSatate; compinfo."State Code") { }
            column(compPAN; compinfo."P.A.N. No.") { }
            column(compGSTNO; compinfo."GST Registration No.") { }
            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLinkReference = "Purchase Header";
                DataItemLink = "Document No." = field("No.");
                column(Description_SalesLine; Description)
                {
                }
                column(Quantity_SalesLine; Quantity)
                {
                }
                column(UnitPrice_SalesLine; "Unit Price (LCY)")
                {
                }
                column(Amount_SalesLine; "Line Amount")
                {
                }
                column(UnitofMeasureCode_SalesLine; "Unit of Measure Code")
                {
                }
                column(HSN_SAC_Code; "HSN/SAC Code") { }
                column(total; total) { }
                column(taxTotal; taxTotal) { }
                column(amountInWordsFinal; amountInWordsFinal) { }
                column(amountInWordsTax; amountInWordsTax) { }
                column(stateDesc; stateDesc) { }
                column(compStatedesc; compStatedesc) { }
                column(CGSTAmount; CGST) { }
                column(CGSTRate; CGSTRate) { }
                column(SGSTAmount; SGST) { }
                column(SGSTRate; SGSTRate) { }
                column(IGSTRate; IGSTRate) { }
                column(IGSTAmount; IGST) { }
                column(billToStatesCode; billToStatesCode) { }
                column(compStateCode; compStateCode) { }
                column(CGSTTotal; CGSTTotal) { }
                column(IGSTTotal; IGSTTotal) { }
                column(TotalAmt; TotalAmt) { }
                column(finalAmt; finalAmt) { }
                column(SGSTTotal; SGSTTotal) { }
                //VOUCHER columns

                column(grandTotal; grandTotal) { }
                column(TotalCGST; TotalCGST) { }
                column(TotalSGST; TotalSGST) { }
                column(TotalIGST; TotalIGST) { }

                trigger OnAfterGetRecord()

                var
                    "Purchase Line": Record "Purchase Line";
                    "Purchase Header": Record "Purchase Header";
                    TaxTransactionValue: Record "Tax Transaction Value";
                begin

                    ClearData();

                    "Purchase Line".Reset();
                    "Purchase Line".SetRange("Document Type", "Purchase Header"."Document Type");
                    "Purchase Line".SetRange("Document No.", "Purchase Header"."No.");
                    "Purchase Line".SetFilter("GST Group Code", '<>%1', '');
                    if "Purchase Line".FindSet() then
                        repeat
                            TaxRecordID := "Purchase Line".RecordId();//NP
                                                                      // PurchaseHeaderRecordID := saleLine.RecordId();
                                                                      //Message('%1', PurchHeaderRecordID);
                            TaxTransactionValue.Reset();
                            TaxTransactionValue.SetRange("Tax Record ID", TaxRecordID);//Np
                            TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
                            TaxTransactionValue.SetFilter("Tax Type", '=%1', 'GST');
                            TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
                            TaxTransactionValue.SetRange("Visible on Interface", true);
                            TaxTransactionValue.SetFilter("Value ID", '%1|%2', 6, 2);
                            if TaxTransactionValue.FindSet() then begin
                                //repeat
                                CGSTRate := TaxTransactionValue.Percent;
                                SGSTRate := TaxTransactionValue.Percent;
                                CGST += TaxTransactionValue.Amount;
                                SGST += TaxTransactionValue.Amount;
                                SGSTtxt := 'SGST';
                                CGSTtxt := 'CGST';
                                TotalCGST += CGST;
                                TotalSGST += SGST;
                            end else begin
                                TaxTransactionValue.Reset();
                                TaxTransactionValue.SetRange("Tax Record ID", TaxRecordID);//NP
                                TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
                                TaxTransactionValue.SetFilter("Tax Type", '=%1', 'GST');
                                TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
                                TaxTransactionValue.SetRange("Visible on Interface", true);
                                TaxTransactionValue.SetFilter("Value ID", '%1', 3);
                                if TaxTransactionValue.FindSet() then
                                    IGSTRate := TaxTransactionValue.Percent;
                                IGST += TaxTransactionValue.Amount;
                                IGSTtxt := 'IGST';
                                TotalIGST += IGST;

                            END;

                            Total += "Purchase Line"."Line Amount";
                        until "Purchase Line".Next() = 0;
                    grandTotal := Total + CGST + SGST + IGST;
                    taxTotal += CGST + IGST + SGST;

                    repcheck.InitTextVariable();
                    repcheck.FormatNoText(noText, grandTotal, ' ');
                    amountInWordsFinal := noText[1] + noText[2];

                    repcheck1.InitTextVariable();
                    repcheck1.FormatNoText(noText2, taxTotal, ' ');
                    amountInWordsTax := noText2[1] + noText2[2]

                end;
            }

            //Posted Sales Header trigger
            trigger OnAfterGetRecord()

            var

                myInt: Integer;

            begin

                //Comp state code and state name
                stateRec.Reset();
                stateRec.SetRange(code, compinfo."State Code");
                if compinfo.FindFirst() then begin
                    compStatedesc := stateRec.Description;
                    compStateCode := stateRec."State Code (GST Reg. No.)";
                end;

                //Pay to state code and state name
                Vendor.Reset();
                Vendor.SetRange(Vendor.Name, "Purchase Header"."Pay-to Name");
                if Vendor.FindFirst() then begin
                    stateRec.Reset();
                    stateRec.SetRange(Code, Vendor."State Code");
                    if stateRec.FindFirst() then begin
                        stateDesc := stateRec.Description;
                        billToStatesCode := stateRec."State Code (GST Reg. No.)";
                    end;
                end;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    // field(No_; "Purchase Header"")

                    // {

                    //     ApplicationArea = All;
                    // }

                }
            }

        }
        actions
        {
            area(processing)

            {

                action(ActionName)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnInitReport()
    var
        myInt: Integer;
    begin

        compStatedesc := '';
        CompStateCode := '';
        compinfo.get();
        if stateRec.Get(compinfo."State Code") then begin
            compStatedesc := stateRec.Description;
            CompStateCode := stateRec."State Code (GST Reg. No.)";
        end;

    end;

    local procedure ClearData()
    Begin
        IGSTRate := 0;
        SGSTRate := 0;
        CGSTRate := 0;
        SGSTtxt := '';
        CGSTtxt := '';
        TotalCGST := 0;
        TotalSGST := 0;
        TotalIGST := 0;
        CGSTtxt := '';
        IGSTtxt := '';

        IGST := 0;
        CGST := 0;
        SGST := 0;
        Clear(amountInWordsFinal);
        grandTotal := 0;

    End;

    var

        myInt: Integer;
        compinfo: Record "Company Information";
        salesInvLine: Record "Purchase Line";
        salesInvHeader: Record "Purchase Header";
        amountInWordsFinal: Text[100];
        amountInWordsTax: Text[100];
        noText: array[2] of Text;
        noText2: array[2] of Text;
        stateRec: Record State;
        stateDesc: Text[50];
        total: Decimal;
        CGSTRate: Decimal;
        CGST: Decimal;
        SGSTRate: Decimal;
        SGST: Decimal;
        IGSTRate: Decimal;
        IGST: Decimal;
        GSTComponentCGST: Code[20];
        GSTComponentSGST: Code[20];
        GSTComponentIGST: Code[20];
        CGSTTotal: Decimal;
        SGSTTotal: Decimal;
        IGSTTotal: Decimal;
        Vendor: Record Vendor;
        "Detailed GST Ledger Entry": Record "Detailed GST Ledger Entry";
        taxTotal: Decimal;
        repCheck: Report Check;
        repcheck1: Report Check;

        compStatedesc: Text[50];
        grandTotal: Decimal;
        billToStatesCode: Code[10];
        compStateCode: Code[10];
        finalAmt: Decimal;
        TotalAmt: Decimal;

        //VOCHER VAR

        "Tax Transaction Value": Record "Tax Transaction Value";
        TotalCGST: Decimal;
        TotalSGST: Decimal;
        TotalIGST: Decimal;
        TotalTDSAmt: Decimal;
        saleLine: Record "Purchase Line";
        saleHeader: Record "Purchase Header";
        TotalAmount: Decimal;
        ItemName: Text[30];
        TaxRecordID: RecordId;
        SGSTtxt: Text[30];
        CGSTtxt: Text[30];
        IGSTtxt: Text[30];
        TaxTransactionValue: Record "Tax Transaction Value";


}
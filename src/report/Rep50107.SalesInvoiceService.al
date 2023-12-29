report 50107 SalesInvoiceService
{
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportTaxInvoiceService.rdl';

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            RequestFilterFields = "No.", "Sell-to Customer No.", "Posting Date";

            column(No_; "No.")
            {
            }
            column(Sell_to_Customer_Name; "Sell-to Customer Name")
            {
            }
            column(Sell_to_Customer_No_; "Sell-to Customer No.")
            {
            }
            column(Sell_to_Address; SelltoAddress)
            {
            }
            column(Sell_to_Address_2; "Selltoaddress2")
            {
            }
            column(Sell_to_City; "SelltoCity")
            {
            }
            column(Sell_to_County; "Sell-to County")
            {
            }
            column(Sell_to_Contact_No_; "Sell-to Contact No.")
            {
            }
            column(Sell_to_Country_Region_Code; "Sell-to Country/Region Code")
            {
            }
            column(Customer_GST_Reg__No_; "CustomerGSTRegNo")
            {
            }
            column(Sell_to_Post_Code; "SelltoPostCode")
            {
            }
            column(CustStateName; CustStateName)
            {
            }
            column(CustStateCode; CustStateCode)
            {
            }
            column(Posting_Date; "Posting Date")
            {
            }
            column(Location_Code; "Location Code")
            {
            }
            column(Due_Date; "Due Date")
            {
            }
            column(Payment_Terms_Code; "Payment Terms Code")
            {
            }
            //column(mode)
            column(RecCompInfo_Name; RecCompInfo.Name)
            {
            }
            column(RecCompInfo_Address; RecCompInfo.Address)
            {
            }
            column(RecCompInfo_Address2; RecCompInfo."Address 2")
            {
            }
            column(RecCompInfo_PinCode; RecCompInfo."Post Code")
            {
            }
            column(RecCompInfo_City; RecCompInfo.City)
            {
            }
            column(RecCompInfo_Country; RecCompInfo.County)
            {
            }
            column(RecCompInfo_PhoneNo; RecCompInfo."Phone No.")
            {
            }
            column(RecCompInfo_GSTRegNo; RecCompInfo."GST Registration No.")
            {
            }
            column(RecCompInfo_Picture; RecCompInfo.Picture)
            {
            }
            column(CompStateName; CompStateName)
            {
            }
            column(CompStateCode; CompStateCode)
            {
            }
            column(RecCompInfo_PANNo; RecCompInfo."P.A.N. No.")
            {
            }
            column(RecCompInfo_SWIFT; RecCompInfo."SWIFT Code")
            {
            }
            column(RecCompInfo_IBAN; RecCompInfo.IBAN)
            {
            }
            column(RecCompInfo_HomePage; RecCompInfo."Home Page")
            {
            }
            column(RecCompInfo_GiroNo; RecCompInfo."Giro No.")
            {
            }
            column(RecCompInfo; RecCompInfo."E-Mail")
            {
            }
            column(Shipment_Method_Code; "Shipment Method Code")
            {
            }
            column(Payment_Method_Code; "Payment Method Code")
            {
            }
            column(Shipping_Agent_Code; "Shipping Agent Code")
            {
            }
            column(Package_Tracking_No_; "Package Tracking No.")
            {
            }
            column(External_Document_No_; "External Document No.")
            {
            }
            column(Order_No_; "Order No.")
            {
            }
            column(Your_Reference; "Your Reference")
            {
            }
            column(PaymentTermsDesc; PaymentTermsDesc)
            {
            }
            column(Comments; Comments)
            {
            }
            column(BankAccount_No; BankAccount."Bank Account No.")
            {
            }
            column(BankAccount_Name; BankAccount.Name)
            {
            }
            column(BankAccount_IFSC; BankAccount."SWIFT Code")
            {
            }
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLinkReference = "Sales Invoice Header";
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = WHERE(Quantity = FILTER(<> 0));

                column(Document_No_; "Document No.")
                {
                }
                column(ItemNo_; "No.")
                {
                }
                column(Description; Description)
                {
                }
                column(Unit_of_Measure_Code; "Unit of Measure Code")
                {
                }
                column(Quantity; Quantity)
                {
                }
                column(Unit_Price; "Unit Price")
                {
                }
                column(Line_Amount; "Line Amount")
                {
                }
                column(ItemName; ItemName)
                {
                }
                column(Shipment_Date; "Shipment Date")
                {
                }
                column(TotalAmount; TotalAmount)
                {
                }
                column(AmountinWords; AmountinWords[1])
                {
                }
                //column(Unit_Price__LCY_; "Unit Price (LCY)") { }
                //column(Direct_Unit_Cost; "Direct Unit Cost") { }
                column(Line_Discount__; "Line Discount %")
                {
                }
                column(Line_Discount_Amount; "Line Discount Amount")
                {
                }
                column(GST_Jurisdiction_Type; "GST Jurisdiction Type")
                {
                }
                column(CGST; CGST)
                {
                }
                column(SGST; SGST)
                {
                }
                column(IGST; IGST)
                {
                }
                column(Rate; Rate)
                {
                }
                column(Rate1; Rate1)
                {
                }
                column(TotalCGST; TotalCGST)
                {
                }
                column(TotalSGST; TotalSGST)
                {
                }
                column(TotalIGST; TotalIGST)
                {
                }
                column(TDSAmt; TDSAmt)
                {
                }
                column(TDSPer; TDSPer)
                {
                }
                column(TotalTDSAmt; TotalTDSAmt)
                {
                }
                column(SrNo; SrNo)
                {
                }
                column(HSN_SAC_Code; "HSN/SAC Code")
                {
                }
                column(HSNSAC; HSNSAC)
                {
                }
                column(TaxableValue; TaxableValue)
                {
                }
                column(CentralTaxRate; CentralTaxRate)
                {
                }
                column(StateTaxAmount; StateTaxAmount)
                {
                }
                column(StateTaxRate; StateTaxRate)
                {
                }
                column(CentralTaxAmount; CentralTaxAmount)
                {
                }
                column(TotalTaxAmount; TotalTaxAmount)
                {
                }
                column(HSNRate1; HSNRate1)
                {
                }
                column(HSNRate2; HSNRate2)
                {
                }
                column(HSNCGST; HSNCGST)
                {
                }
                column(HSNSGST; HSNSGST)
                {
                }
                column(HSNIGST; HSNIGST)
                {
                }
                trigger OnPreDataItem()
                begin
                    SrNo := 0;
                    TotalCGST := 0;
                    TotalSGST := 0;
                    TotalIGST := 0;
                    TotalTDSAmt := 0;
                end;

                trigger OnAfterGetRecord()
                var
                    RecRef: RecordRef;
                    TaxTransval: Record "Tax Transaction Value";
                    SalesHeaderRecordID: RecordId;
                    RecPIL: Record "Sales Invoice Line";
                    RecPIL1: Record "Sales Invoice Line";
                    RecRef1: RecordRef;
                    TaxTransval1: Record "Tax Transaction Value";
                    SalesHeaderRecordID1: RecordId;
                begin
                    SrNo += 1;
                    IF RecItem.Get("Sales Invoice Line"."No.") then ItemName := RecItem.Description;
                    TotalAmount += "Sales Invoice Line".Quantity * "Sales Invoice Line"."Unit Price";
                    //------------------ GST  Calculation
                    SGST := 0;
                    CGST := 0;
                    IGST := 0;
                    Rate := 0;
                    Rate1 := 0;
                    RecRef.OPEN(DATABASE::"Sales Invoice Line");
                    RecRef.SETTABLE(RecPIL);
                    RecPIL.Reset();
                    RecPIL.SetRange("Document No.", "Sales Invoice Header"."No.");
                    RecPIL.SetFilter(RecPIL."GST Group Code", '<>%1', '');
                    if RecPIL.FindSet() then
                        repeat
                            SalesHeaderRecordID := RecPIL.RECORDID;
                            //Message('%1', PurchHeaderRecordID);
                            TaxTransval.Reset();
                            TaxTransval.SetRange("Tax Record ID", SalesHeaderRecordID);
                            TaxTransval.SetFilter("Value Type", '=%1', TaxTransval."Value Type"::COMPONENT);
                            TaxTransval.SetFilter(TaxTransval."Tax Type", '=%1', 'GST');
                            TaxTransval.SetFilter(Percent, '<>%1', 0);
                            if TaxTransval.FindSet() then
                                repeat //Message('%1  %2  %3', TaxTransval.ID, TaxTransval.Amount, TaxTransval.Percent);
                                    IF "Sales Invoice Line"."GST Jurisdiction Type" = "Sales Invoice Line"."GST Jurisdiction Type"::Intrastate THEN BEGIN
                                        Rate := TaxTransval.Percent;
                                        CGST := TaxTransval.Amount;
                                        SGST := TaxTransval.Amount;
                                    END
                                    ELSE
                                        IF ("Sales Invoice Line"."GST Jurisdiction Type" = "Sales Invoice Line"."GST Jurisdiction Type"::Interstate) THEN BEGIN
                                            Rate1 := TaxTransval.Percent;
                                            IGST := TaxTransval.Amount;
                                        END;
                                until TaxTransval.Next() = 0;
                            TotalCGST += CGST;
                            TotalSGST += SGST;
                            TotalIGST += IGST;
                        until RecPIL.Next() = 0;
                    TaxableValue := 0;
                    CentralTaxRate := 0;
                    CentralTaxAmount := 0;
                    StateTaxRate := 0;
                    StateTaxAmount := 0;
                    TotalTaxAmount := 0;
                    HSNSAC := '';
                    HSNCGST := 0;
                    HSNSGST := 0;
                    HSNIGST := 0;
                    HSNRate1 := 0;
                    HSNRate2 := 0;
                    DGST.Reset();
                    DGST.SetRange("Document No.", "Document No.");
                    DGST.SetRange("Document Line No.", "Line No.");
                    if DGST.Find('-') then
                        repeat
                            HSNSAC := dgst."HSN/SAC Code";
                            if (DGST."GST Component Code" = 'CGST') Or (DGST."GST Component Code" = 'SGST') then begin
                                TaxableValue := Abs(dgst."GST Base Amount");
                                HSNRate1 := DGST."GST %";
                                HSNCGST := Abs(DGST."GST Amount");
                                HSNSGST := Abs(DGST."GST Amount");
                                CentralTaxRate := DGST."GST %";
                                CentralTaxAmount := Abs(DGST."GST Amount");
                                StateTaxRate := DGST."GST %";
                                StateTaxAmount := Abs(DGST."GST Amount");
                                TotalTaxAmount := TotalTaxAmount + Abs(DGST."GST Amount");
                                TotalGSTAmount := TotalGSTAmount + Abs(DGST."GST Amount");
                            end
                            else
                                if DGST."GST Component Code" = 'IGST' then begin
                                    HSNRate2 := DGST."GST %";
                                    HSNIGST := Abs(DGST."GST Amount");
                                    TaxableValue := ABS(dgst."GST Base Amount");
                                    CentralTaxRate := DGST."GST %";
                                    CentralTaxAmount := Abs(DGST."GST Amount");
                                    TotalTaxAmount := TotalTaxAmount + Abs(DGST."GST Amount");
                                    TotalGSTAmount := TotalGSTAmount + Abs(DGST."GST Amount");
                                end;
                        until DGST.next = 0;
                    //------------------
                    // SalesInvoiceGST.InitTextVariable;
                    // SalesInvoiceGST.FormatNoText(AmountinWords, ROUND(TotalAmount + TotalGSTAmount), "Sales Invoice Header"."Currency Code");
                end;

                trigger OnPostDataItem()
                var
                    myInt: Integer;
                begin
                end;
            }
            trigger OnAfterGetRecord()
            begin
                CustStateName := '';
                CustStateCode := '';
                TotalGSTAmount := 0;
                RecCust.Get("Sell-to Customer No.");
                if RecState.Get(RecCust."State Code") then begin
                    CustStateName := RecState.Description;
                    CustStateCode := RecState."State Code (GST Reg. No.)";
                end;
                if PaymentTerms.Get("Payment Terms Code") then begin
                    PaymentTermsDesc := PaymentTerms.Description;
                end;
                SalesCommLine.Reset();
                SalesCommLine.SetRange("Document Type", SalesCommLine."Document Type"::"Posted Invoice");
                SalesCommLine.SetRange("No.", "No.");
                if SalesCommLine.Find('-') then
                    repeat
                        Comments := Comments + ' ' + SalesCommLine.Comment;
                    until SalesCommLine.next = 0;
                BankAccount.Reset();
                BankAccount.SetRange("No.", BankAccountNo);
                if BankAccount.Find('-') then;
                if "Ship-to Code" <> '' then begin
                    SelltoAddress := "Ship-to Address";
                    SelltoAddress2 := "Ship-to Address 2";
                    Selltocity := "Ship-to City";
                    SelltoPostCode := "Ship-to Post Code";
                    if ShipToAdd.get(RecCust."No.", "Ship-to Code") then Begin
                        if RecState.Get(ShipToAdd.State) then begin
                            CustStateName := RecState.Description;
                            CustStateCode := RecState."State Code (GST Reg. No.)";
                            CustomerGSTRegNo := ShipToAdd."GST Registration No.";
                        End;
                    end;
                end
                else begin
                    SelltoAddress := "Sell-to Address";
                    SelltoAddress2 := "Sell-to Address 2";
                    Selltocity := "Sell-to City";
                    SelltoPostCode := "Sell-to Post Code";
                    CustomerGSTRegNo := RecCust."GST Registration No.";
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
                group("Report FIlter")
                {
                    field("Bank Account No."; BankAccountNo)
                    {
                        TableRelation = "Bank Account";
                        ApplicationArea = all;
                    }
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
    begin
        CompStateName := '';
        CompStateCode := '';
        RecCompInfo.Get();
        RecCompInfo.CalcFields(Picture);
        if RecState.Get(RecCompInfo."State Code") then begin
            CompStateName := RecState.Description;
            CompStateCode := RecState."State Code (GST Reg. No.)";
        end;
    end;

    var
        BankAccountNo: Code[20];
        BankAccount: Record "Bank Account";
        RecItem: Record Item;
        ItemName: Code[50];
        RecCompInfo: Record "Company Information";
        CGST: Decimal;
        SGST: Decimal;
        IGST: Decimal;
        Rate: Decimal;
        Rate1: Decimal;
        TotalCGST: Decimal;
        TotalSGST: Decimal;
        TotalIGST: Decimal;
        TotalAmount: Decimal;
        TDSAmt: Decimal;
        TDSPer: Decimal;
        TotalTDSAmt: Decimal;
        repCheck: Report Check;
        AmountinWords: array[5] of Text;
        SrNo: Integer;
        RecCust: Record Customer;
        HSNCGST: Decimal;
        HSNSGST: Decimal;
        HSNIGST: Decimal;
        HSNRate1: Decimal;
        HSNRate2: Decimal;
        RecState: Record State;
        CustStateName: text[30];
        CustStateCode: code[20];
        CompStateName: Text[30];
        CompStateCode: code[20];
        DGST: Record "Detailed GST Ledger Entry";
        TaxableValue: Decimal;
        CentralTaxRate: Decimal;
        CentralTaxAmount: Decimal;
        StateTaxRate: Decimal;
        StateTaxAmount: Decimal;
        TotalTaxAmount: Decimal;
        HSNSAC: Code[20];
        TotalGSTAmount: Decimal;
        //SalesInvoiceGST: Report SalesInvoiceGST;
        PaymentTerms: Record "Payment Terms";
        PaymentTermsDesc: Text[100];
        SalesCommLine: Record "Sales Comment Line";
        Comments: Text;
        SelltoAddress: Text;
        SelltoAddress2: text;
        SelltoCity: text;
        SelltoPostCode: Text;
        ShipToAdd: Record "Ship-to Address";
        CustomerGSTRegNo: Text;
}

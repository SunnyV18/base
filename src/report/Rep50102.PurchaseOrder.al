report 50102 "Purchase_Order"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'PurchaseOrder.rdl';
    Caption = 'Purchase Order New';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Buy-from Vendor No.";
            RequestFilterHeading = 'Purchase Order';
            column(No_; "No.") { }
            column(Shipping_Agent_Code; "Shipping Agent Code") { }
            column(Shipment_Method_Code; "Shipment Method Code") { }
            column(Payment_Terms_Code; "Payment Terms Code") { }
            column(CompanyInfopic; CompanyInfo.Picture) { }
            column(CmpName; CompanyInfo.Name) { }
            column(CmName2; CompanyInfo."Name 2") { }
            column(CmpAddres; CompanyInfo.Address) { }
            column(CmpAddres2; CompanyInfo."Address 2") { }
            column(CmpCity; CompanyInfo.City) { }
            column(CmpPostCode; CompanyInfo."State Code") { }
            column(CmpGSTReg; CompanyInfo."GST Registration No.") { }
            column(CmpRegNo; CompanyInfo."Registration No.") { }
            column(CmpBankName; CompanyInfo."Bank Name") { }
            column(CmpBankAccount; CompanyInfo."Bank Account No.") { }
            column(SWIFTCode; SWIFTCode) { }
            column(IFCCode; IFCCode) { }
            column(BankBrach; BankBrach) { }
            column(CmppanNo; CompanyInfo."P.A.N. No.") { }
            column(CmpStateCode; CompanyInfo."State Code") { }
            column(CmpBankBranch; CompanyInfo."Bank Branch No.") { }
            column(CmpEmail; CompanyInfo."E-Mail") { }
            column(CICode; CICode) { }
            column(statename; statename) { }
            column(No_SIH; "No.") { }
            column(Posting_Date; "Posting Date") { }
            column(Pay_to_Name; "Pay-to Name") { }
            column(Pay_to_Address; "Pay-to Address") { }
            column(Pay_to_City; "Pay-to City") { }
            column(Pay_to_Post_Code; "Pay-to Post Code") { }
            column(Pay_to_Vendor_No_; "Pay-to Vendor No.") { }
            column(Pay_to_County; "Pay-to County") { }
            column(Your_Reference; "Your Reference") { }
            column(Pay_to_Contact; "Pay-to Contact") { }
            column(Order_Date; "Order Date") { }
            column(Ship_to_Name; "Ship-to Name") { }
            column(Ship_to_Address; "Ship-to Address") { }
            column(Ship_to_Address_2; "Ship-to Address 2") { }
            column(Ship_to_City; "Ship-to City") { }
            column(Ship_to_Code; "Ship-to Code") { }
            column(Ship_to_County; "Ship-to County") { }
            column(Ship_to_Contact; "Ship-to Contact") { }
            column(Ship_to_Post_Code; "Ship-to Post Code") { }
            column(ShipCode; SstateCode) { }
            column(NoLbl; NoLbl) { }
            column(DesLbl; DesLbl) { }
            column(HSNLbl; HSNLbl) { }
            column(qtyLbl; qtyLbl) { }
            column(RateLbl; RateLbl) { }
            column(AmtLbl; AmtLbl) { }
            column(DisLbl; DisLbl) { }
            column(TaxValLbl; TaxValLbl) { }
            column(TotLbl; TotLbl) { }
            column(Due_Date; "Due Date") { }
            column(VendorName; VendorName) { }
            column(VendorAddress; VendorAddress) { }
            column(VendorAddress2; VendorAddress2) { }
            column(VendorStateCode; VendorStateCode) { }
            column(VendorGSTRegistrationNo; VendorGSTRegistrationNo) { }
            column(CurrSymbol; CurrSymbol) { }
            column(CountName; CountName) { }
            column(gst; Sgstregistration) { }
            column(VendorCode; VendorCode) { }
            column(VendorStateName; VendorStateName) { }
            column(VendorPostCode; VendorPostCode) { }
            column(CustomerStateName; CustomerStateName) { }
            column(CustomerStateCode; CustomerStateCode) { }
            column(CustomerGSTRegistrationNo; CustomerGSTRegistrationNo) { }
            column(Sname; Sname) { }
            column(Saddress; Saddress) { }
            column(Saddress2; Saddress2) { }
            column(Sgstregistration; Sgstregistration) { }
            column(Scity; Scity) { }
            column(SstateCode; SstateCode) { }
            column(SstateName; SstateName) { }
            column(SpostCode; SpostCode) { }
            column(currency; currency) { }
            // column(Terms___Condition; "Terms & Condition") { }
            column(Vendor_Order_No_; "Vendor Order No.") { }
            column(locAddress; locAddress) { }
            column(locAddress1; locAddress1) { }
            column(locGSTIN; locGSTIN) { }
            column(LocEmail; LocEmail) { }
            column(LocPostCode; LocPostCode) { }
            column(LocStateName; LocStateName) { }
            column(LocCity; LocCity) { }
            column(LocStateCode; LocStateCode) { }
            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemTableView = SORTING("Document Type", "Document No.", "Line No.");
                DataItemLinkReference = "Purchase Header";
                DataItemLink = "Document No." = FIELD("No.");
                column(Description; Description) { }
                column(HSN_SAC_Code; "HSN/SAC Code") { }
                column(Quantity; Quantity) { }
                column(Unit_Cost; "Unit Cost") { }
                column(Unit_of_Measure_Code; "Unit of Measure Code") { }
                column(Amount; Amount) { }
                column(SGSTRate; SGSTRate) { }
                column(TotalIGST; TotalIGST) { }
                column(TotalCGST; TotalCGST) { }
                column(TotalSGST; TotalSGST) { }
                column(IGSTRate; IGSTRate) { }
                column(CGSTRate; CGSTRate) { }
                column(IGSTtxt; IGSTtxt) { }
                column(CGSTtxt; CGSTtxt) { }
                column(SGSTtxt; SGSTtxt) { }
                column(SGSTAmt; SGSTAmt) { }
                column(CGSTAmt; CGSTAmt) { }
                column(IGSTAmt; IGSTAmt) { }
                column(CGST; CGST) { }
                column(SGST; SGST) { }
                column(IGST; IGST) { }
                column(AmountToVendor; AmountToVendor) { }
                column(AmountinWords1; AmountinWords[2]) { }
                column(AmountinWords; AmountinWords[1]) { }
                column(Amtinwrds; Amtinwrds) { }

            }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                if "Purchase Header"."Currency Code" <> '' then begin
                    currency := "Purchase Header"."Currency Code";
                end else begin
                    currency := 'INR';
                end;

                // if "Purchase Header"."Ship-to Code" = '' then begin
                Vendor.Reset();
                Vendor.SetRange("No.", "Purchase Header"."Buy-from Vendor No.");
                if vendor.find('-') then begin
                    VendorName := Vendor.Name;
                    VendorAddress := Vendor.Address;
                    VendorAddress2 := Vendor."Address 2";
                    VendorStateCode := Vendor."State Code";
                    VendorPostCode := Vendor."Post Code";
                    VendorGSTRegistrationNo := Vendor."GST Registration No.";
                    VendorDated := Vendor."Date Filter";
                    IF Recstate.GET(VendorStateCode) then
                        VendorStateName := Recstate.Description;
                    VendorCode := Recstate."State Code (GST Reg. No.)";




                End;
                //Ashw
                RecCurr.Reset();
                RecCurr.SetRange(Code, "Purchase Header"."Currency Code");
                if RecCurr.FindFirst() then begin
                    CurrSymbol := RecCurr.Symbol;
                end;
                //Naveen
                RecCountry.Reset();
                RecCountry.SetRange(Code, "Purchase Header"."VAT Country/Region Code");
                if RecCountry.FindFirst() then begin
                    CountName := RecCountry.Name;
                end;

                if "Purchase Header"."Ship-to Code" = '' then begin
                    Sname := VendorName;
                    Saddress := VendorAddress;
                    Saddress2 := VendorAddress2;
                    Sgstregistration := VendorGSTRegistrationNo;
                    Scity := "Pay-to City";
                    SstateCode := VendorCode;
                    SstateName := VendorStateName;
                    SpostCode := VendorPostCode;

                end else begin
                    Sname := "Ship-to Name";
                    Saddress := "Ship-to Address";
                    Saddress2 := "Ship-to Address 2";
                    Sgstregistration := CustomerGSTRegistrationNo;
                    Scity := "Ship-to City";
                    if Recstate.Get("Purchase Header".State) then begin
                        SstateName := Recstate.Description;
                        SstateCode := Recstate."State Code (GST Reg. No.)";
                    end;

                    //SstateCode := CICode;
                    SstateName := CustomerStateName;
                    SpostCode := "Ship-to Post Code";
                end;

                if Recstate.Get(CompanyInfo."State Code") then begin
                    CIName := Recstate.Description;
                    CICode := Recstate."State Code (GST Reg. No.)";
                    //Message('', CICode);
                end;

                if Recstate.Get(CompanyInfo."State Code") then
                    statename := Recstate.Description;


                Customer.Reset();
                Customer.SetRange("No.", "Purchase Header"."Sell-to Customer No.");
                if Customer.find('-') then begin

                    CustomerGSTRegistrationNo := Customer."GST Registration No.";
                    IF Recstate.GET(CustomerStateCode) then begin
                        CustomerStateName := Recstate.Description;

                    end;
                end;
                Location.Reset();
                Location.SetRange(Code, "Purchase Header"."Location Code");
                if Location.FindFirst() then begin
                    locAddress := Location.Address;
                    locAddress1 := Location."Address 2";
                    LocEmail := Location."E-Mail";
                    locGSTIN := Location."GST Registration No.";
                    LocStateName := Location."State Code";
                    LocPostCode := Location."Post Code";
                    LocCity := Location.City;
                    //Saddress := Location.Address;
                end;
                if RecState.get("Purchase Header"."Location Code") then begin
                    LocStateName := RecState.Description;
                    //LocStateCode := RecState."State Code (GST Reg. No.)";
                end;
                if RecState.get(Location."State Code") then begin
                    LocStateCode := RecState."State Code (GST Reg. No.)";
                end;

                ClearData;
                RecPurchaseLine.Reset();
                RecPurchaseLine.SetRange("Document Type", "Purchase Header"."Document Type");
                RecPurchaseLine.SetRange("Document No.", "Purchase Header"."No.");
                RecPurchaseLine.SetFilter("GST Group Code", '<>%1', '');
                if RecPurchaseLine.FindSet() then
                    repeat
                        TaxRecordID := RecPurchaseLine.RecordId();//NP
                                                                  // PurchaseHeaderRecordID := RecPurchaseLine.RecordId();
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

                        Total += RecPurchaseLine.Amount;
                    until RecPurchaseLine.Next() = 0;
                AmountToVendor := Total + CGST + SGST + IGST;
                // PostedVoucher.InitTextVariable();
                "Purchase Header".CalcFields(Amount);
                //   PostedVoucher.FormatNoText(AmountinWords, Round(AmountToVendor), "Purchase Header"."Currency Code");
                Amtinwrds := AmountinWords[1] + AmountinWords[2];
            end;


            trigger OnPreDataItem()
            var
                myInt: Integer;

            begin
                BankAcc.Reset();
                BankAcc.SetRange("Bank Account No.", CompanyInfo."Bank Account No.");
                if BankAcc.Find('-') then
                    repeat
                        BankBrach := BankAcc."Bank Branch No.";
                        SWIFTCode := BankAcc."SWIFT Code";
                        IFCCode := BankAcc."IFSC Code";
                    until BankAcc.Next = 0;
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
        CompanyInfo.get();
        CompanyInfo.CalcFields(Picture);

    end;

    trigger OnPreReport()
    begin

    end;
    //NP
    procedure CalculateGST(PL: Record "Purchase Line")
    var
        PurchaseLine: Record "Purchase Line";
        TaxRecordID: RecordId;
        TaxTransactionValue: Record "Tax Transaction Value";
        TaxTypeObjHelper: Codeunit "Tax Type Object Helper";
        ComponentAmt: Decimal;
    begin
        /*if PurchaseLine.Get(PL."Document Type", PL."Document No.", PL."Line No.") then
            TaxRecordID := PurchaseLine.RecordId();
        ComponentAmt := 0;
        TaxTransactionValue.Reset();
        TaxTransactionValue.SetFilter("Tax Record ID", '%1', TaxRecordID);
        TaxTransactionValue.SetFilter("Value Type", '%1', TaxTransactionValue."Value Type"::Component);
        TaxTransactionValue.SetRange("Visible on Interface", true);
        TaxTransactionValue.SetFilter("Value ID", '%1|%2|%3', 6, 2, 3);
        if TaxTransactionValue.FindSet() then
            repeat
                ComponentAmt += TaxTypeObjHelper.GetComponentAmountFrmTransValue(TaxTransactionValue);
            until TaxTransactionValue.Next() = 0;
        if ComponentAmt > 0 then
            TotalGST := ComponentAmt;
        */
    end;

    //tk

    var
        myInt: Integer;
        Location: Record Location;
        LocCity: Text;
        locAddress: Text;
        locAddress1: Text;
        LocStateCode: code[50];
        locGSTIN: Code[20];
        LocStateName: Text;
        LocPostCode: code[20];
        LocEmail: Code[50];
        CompanyInfo: Record "Company Information";
        BankAcc: Record "Bank Account";
        BankBrach: Text;
        SWIFTCode: Code[20];
        IFCCode: Code[20];
        NoLbl: Label 'SR No.';
        DesLbl: Label 'Product Description';
        HSNLbl: Label 'HSN Code';
        qtyLbl: Label 'Qty';
        RateLbl: Label 'Rate';
        AmtLbl: Label 'Amount';
        DisLbl: Label 'Discount';
        TaxValLbl: Label 'Taxable Value';
        TotLbl: Label 'Total';
        VendorName: Text[50];
        VendorAddress: Text[250];
        VendorAddress2: Text[250];
        VendorStateCode: Code[20];
        VendorGSTRegistrationNo: Code[30];
        VendorStateName: Code[30];
        VendorDated: Date;
        Vendor: Record Vendor;
        Recstate: Record State;
        statename: text[30];
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        CGSTAmt: Decimal;
        CGSTRate: Decimal;
        IGSTAmt: Decimal;
        IGSTRate: Decimal;
        SGSTAmt: Decimal;
        SGSTRate: Decimal;
        Total: Decimal;
        GrandTotal: Decimal;
        TotalGST: Decimal;
        RecPurchaseLine: Record "Purchase Line";
        CGST: Decimal;
        SGST: Decimal;
        IGST: Decimal;
        TotalCGST: Decimal;
        TotalSGST: Decimal;
        TotalIGST: Decimal;
        AmountinWords: array[5] of Text;
        AmountinWordsINR: array[5] of Text;
        ExchangeRate: Decimal;
        IGSTtxt: text[10];
        CGSTtxt: text[10];
        SGSTtxt: text[10];
        AmountToVendor: Decimal;
        TaxTransactionValue: Record "Tax Transaction Value";
        PurchaseHeaderRecordID: Record "Purchase Header";
        //   PostedVoucher: Report "Posted Voucher";
        TaxRecordID: RecordId;
        Amtinwrds: Text;
        Sname: Text[50];
        Saddress: Text[250];
        Saddress2: Text[250];
        Sgstregistration: Text[30];
        Scity: Text[50];
        SstateCode: Text[30];
        SstateName: Text[30];
        SpostCode: Code[20];
        Customer: Record Customer;
        CustomerGSTRegistrationNo: Code[30];
        CustomerStateCode: Code[20];
        CustomerStateName: Code[30];
        VendorCode: Code[20];
        "Gst Ship-to State Code": Code[20];
        "Gst Bill-to State Code": Code[20];
        ShipCode: Code[20];
        "CompanyInfo State Code": Code[20];
        CIName: Text;
        CICode: Code[20];
        VendorPostCode: Code[20];

        Recordshipttoadd: record "Ship-to Address";
        currency: Code[20];
        RecCurr: Record Currency;
        CurrSymbol: Text;
        RecCountry: Record "Country/Region";
        CountName: Text;







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
        Clear(AmountinWords);
        AmountToVendor := 0;

    End;

}
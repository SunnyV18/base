report 50110 "Delivery Note Updated"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'DeliveryNote2.rdl';

    dataset
    {
        dataitem("Sales Shipment Header"; "Sales Shipment Header")
        {
            RequestFilterFields = "No.";

            column(Compname; Compinfo.Name)
            {

            }
            column(compaddress; compinfo.Address)
            {
            }
            column(compaddress2; compinfo."Address 2")
            {
            }
            column(CompADD; CompADD) { }
            column(CompCity1; CompCity1) { }
            column(CompPostCode; CompPostCode) { }
            column(CompState1; CompState1) { }
            column(CompStateNo2; CompStateNo2) { }

            column(compcity; compinfo.City)
            {
            }
            column(CompCIN; compinfo."Registration No.")
            {
            }
            column(compemail; compinfo."E-Mail")
            {
            }
            column(ComPAn; compinfo."P.A.N. No.")
            {
            }
            column(Bank_NAme; compinfo."Bank Name")
            {
            }
            column(Bank_Branch_No; compinfo."Bank Branch No.")
            {
            }
            column(Bank_Acc_no; compinfo."Bank Account No.")
            {
            }
            column(Bank_IBAN; compinfo.IBAN)
            {
            }
            column(logo; compinfo.Picture)
            {
            }
            column(CompPAN; compinfo."P.A.N. No.")
            {
            }
            column(CompGST; compinfo."GST Registration No.")
            {
            }
            //Consignee
            column(Ship_to_Name; "Ship-to Name")
            {
            }
            column(Ship_to_Address; "Ship-to Address")
            {
            }
            column(Ship_to_City; "Ship-to City")
            {
            }
            column(Ship_to_Country_Region_Code; "Ship-to Country/Region Code")
            {
            }
            column(Ship_to_Contact; "Ship-to Contact")
            {
            }
            column(No_; "No.")
            {
            }
            column(Order_Date; "Order Date")
            {
            }
            column(Reference_Invoice_No_; "Reference Invoice No.")
            {
            }
            column(Order_No_; "Order No.")
            {
            }
            column(Shipment_Method_Code; "Shipment Method Code")
            {
            }
            column(Add; Add) { }
            column(City; City) { }
            column(PostCode; PostCode) { }
            column(PAN; PAN) { }
            column(StateName; StateName) { }
            column(StateCode; StateCode) { }
            column(CompStateName; CompStateName) { }
            column(CompStateNo; CompStateNo) { }


            dataitem("Sales Shipment Line"; "Sales Shipment Line")
            {
                RequestFilterFields = "Order No.";

                DataItemLink = "Document No." = field("No.");
                DataItemLinkReference = "Sales Shipment Header";
                column(Description; Description)
                {
                }
                column(HSN_SAC_Code; "HSN/SAC Code")
                {
                }
                column(Quantity; Quantity)
                {
                }
                column(Unit_Cost; "Unit Price")
                {
                }
                column(Unit_of_Measure; "Unit of Measure")
                { }
                column(Amount; Amount)
                {
                }
                column(grandtotal; grandtotal)
                { }
                column(AmountTotal; AmountTotal) { }
                column(LineAmount; LineAmount) { }
                column(IGST; IGST) { }
                column(IGSTRate; IGSTRate) { }
                column(SGST; SGST) { }
                column(SGSTRate; SGSTRate) { }
                column(CGST; CGST) { }
                column(CGSTRate; CGSTRate) { }
                column(amountinwords; amountinwords) { }
                column(Taxinwords; Taxinwords) { }
                column(CustomersGSTNo; GSTNo) { }
                column(getTerm; getTerm) { }
                column(TotalCGST; TotalCGST) { }
                column(TotalIGST; TotalIGST) { }
                column(TotalSGST; TotalSGST) { }
                column(CGSTtxt; CGSTtxt) { }
                column(SGSTtxt; SGSTtxt) { }
                column(IGSTtxt; IGSTtxt) { }





                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin
                    // Total += "Sales Line"."Line Amount";
                    "Sales Shipment Header Rec".Reset();
                    "Sales Shipment Line Rec".SetRange("Document No.", "Sales Shipment Header"."No.");
                    if "Sales Shipment Line Rec".FindSet() then begin
                        repeat
                            "Amount" += "Sales Shipment Line Rec".Quantity * "Sales Shipment Line Rec"."Unit Price";
                        until "Sales Shipment Line Rec".Next() = 0;

                        //AmountTotal += Amount;
                    end;

                    "Sales Header".Reset();
                    "Sales Header".SetRange("No.", "Sales Shipment Header"."Order No.");
                    "Sales Header".SetRange("Last Shipping No.", "Sales Shipment Header"."No.");
                    if "Sales Header".FindFirst() then begin
                        "Sales Line".Reset();
                        "Sales Line".SetRange("Document No.", "Sales Shipment Header"."Order No.");
                        // if "Sales Line".FindFirst() then begin
                        "Sales Line".SetFilter("GST Group Code", '<>%1', '');
                        ClearData();
                        repeat
                            TaxRecordID := "Sales Line".RecordId();//NP
                                                                   //  PurchaseHeaderRecordID := saleLine.RecordId();
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
                                CGST := abs(TaxTransactionValue.Amount);
                                SGST := abs(TaxTransactionValue.Amount);
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
                                IGST := abs(TaxTransactionValue.Amount);
                                IGSTtxt := 'IGST';
                                TotalIGST += IGST;

                            END;

                        // Total += "Sales Line"."Line Amount";
                        until "Sales Line".Next() = 0;
                        //Total += "Sales Line"."Line Amount";
                        "Sales Line".Reset();
                        "Sales Line".SetRange("Document No.", "Sales Shipment Header"."Order No.");
                        if "Sales Line".FindSet() then begin
                            LineAmount += "Sales Line"."Line Amount";
                        end;

                        grandtotal += Amount + TotalCGST + TotalSGST + TotalIGST;
                        //grandtotal += LineAmount + CGST + SGST + IGST;

                        var23.InitTextVariable();
                        var23.FormatNoText(wordinarray, grandtotal, ' ');
                        amountinwords := wordinarray[1] + wordinarray[2];

                        totaltax += TotalIGST + TotalSGST + TotalCGST;

                        var23.InitTextVariable();
                        var23.FormatNoText(wordinarray2, totaltax, ' ');
                        Taxinwords := wordinarray2[1] + wordinarray2[2];




                        // end;



                    end;


                end;




            }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;

            begin
                Location.Reset();
                Location.SetRange(Code, "Sales Shipment Header"."Location Code");
                if Location.FindFirst() then begin
                    CompADD := Location.Address;
                    CompCity1 := Location.City;
                    CompPostCode := Location."Post Code";
                    StateRec.Reset();
                    StateRec.SetRange(Code, Location."State Code");
                    CompState1 := StateRec.Description;
                    CompStateNo2 := StateRec."State Code (GST Reg. No.)";

                end;



                term.SetRange(Code, "Sales Shipment Header"."Payment Terms Code");
                if term.FindFirst() then begin
                    getTerm := term.Description;
                end;
                Customer.Reset();
                Customer.SetRange(Customer.Name, "Sales Shipment Header"."Bill-to Name");
                if Customer.FindFirst() then Begin
                    Add := Customer.Address;
                    City := Customer.City;
                    PostCode := Customer."Post Code";
                    PAN := Customer."P.A.N. No.";
                    GSTNo := Customer."GST Registration No.";
                    StateRec.Reset();

                    StateRec.SetRange(StateRec.Code, Customer."State Code");
                    StateName := StateRec.Description;
                    StateCode := StateRec."State Code (GST Reg. No.)";

                End;

            End;



        }
    }


    requestpage
    {
        AboutTitle = 'Teaching tip title';
        AboutText = 'Teaching tip content';
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    // field()
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
                action(LayoutName)
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
        compinfo.get();
        compinfo.CalcFields(Picture);
        compinfo.Reset();
        StateRec.Reset();
        StateRec.SetRange(StateRec.Code, compinfo."State Code");
        if StateRec.FindFirst() then begin
            CompStateName := StateRec.Description;
            CompStateNo := StateRec."State Code (GST Reg. No.)";

        end;


    end;


    var
        myInt: Integer;
        Location: Record Location;
        Add: Text[100];
        City: Text[100];
        PostCode: Code[30];
        GSTNo: Code[39];
        StateName: Text[100];
        CompStateName: Text[50];
        CompStateNo: Code[20];
        StateCode: text[20];
        Customer: Record Customer;
        PAN: Code[20];
        "Sales Shipment Header Rec": Record "Sales Shipment Header";
        "Sales Shipment Line Rec": Record "Sales Shipment Line";
        "Sales Header": Record "Sales Header";
        "LineAmount": Decimal;

        "Sales Line": Record "Sales Line";
        compinfo: Record "Company Information";
        totaltax: Decimal;
        StateRec: Record State;
        term: Record "Payment Terms";
        getTerm: Text[100];
        "Amount": Decimal;
        TaxTransactionValue: Record "Tax Transaction Value";
        PurchaseHeaderRecordID: Record "Purchase Header";
        //   PostedVoucher: Report "Posted Voucher";
        TaxRecordID: RecordId;
        IGSTtxt: text[10];
        grandtotal: Decimal;
        CGSTtxt: text[10];
        SGSTtxt: text[10];
        AmountToVendor: Decimal;
        AmountTotal: Decimal;

        CGSTRate: Decimal;
        SGSTRate: Decimal;
        IGSTRate: Decimal;
        Total: Decimal;
        TotalCGST: Decimal;
        TotalSGST: Decimal;
        TotalIGST: Decimal;
        IGST: Decimal;
        SGST: Decimal;
        CGST: Decimal;
        var23: Report "Posted Voucher";


        wordinarray: array[2] of text;
        wordinarray2: array[2] of text;
        BankAccountName: Text[100];
        BankAccountNo: Text[30];
        BankBranchNo: Text[30];
        StateName2: Text[20];


        amountinwords: Text[259];
        Taxinwords: Text[259];
        CompADD: Text[100];
        CompADD1: Text[100];
        CompCity1: Text[50];
        CompPostCode: Code[50];
        CompState1: Text[50];
        CompStateNo2: Code[10];



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
        // Clear(AmountinWords);
        AmountToVendor := 0;

    End;
}




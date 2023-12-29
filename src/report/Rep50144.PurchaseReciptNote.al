report 50144 "PurchaseReciptNote"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'PurchaseReciptNote.rdl';

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            RequestFilterFields = "No.";
            //company Information
            column(comp_name; compinfo.Name)
            {

            }
            column(Comp_Address; compinfo.Address)
            {

            }
            column(compinfo_StateCode; compinfo."State Code")
            {

            }
            column(Compinfo_City; Compinfo.City)
            {

            }
            column(compinfo_GST; compinfo."GST Registration No.")
            {

            }
            column(compinfo_Email; compinfo."E-Mail")
            {

            }
            column(compinfo_pan; compinfo."P.A.N. No.")
            {

            }
            column(compinfo_PostCode; compinfo."Post Code")
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
            column(Ship_to_Post_Code; "Ship-to Post Code")
            {

            }
            column(Ship_to_County; "Ship-to County")
            {

            }
            column(Ship_to_Country_Region_Code; "Ship-to Country/Region Code")
            {

            }
            column(Ship_to_Contact; "Ship-to Contact")
            {

            }
            column(Vendor_Shipment_No_; "Vendor Shipment No.")
            {

            }
            column(No_; "No.")
            {

            }
            column(Buy_from_Vendor_Name; "Buy-from Vendor Name")
            {

            }
            column(Vendor_Address; "Vendor Address")
            {

            }
            column(Buy_from_Address; "Buy-from Address")
            {

            }
            column(Buy_from_City; "Buy-from City")
            {

            }
            column(Buy_from_Contact; "Buy-from Contact")
            {

            }
            column(Buy_from_Country_Region_Code; "Buy-from Country/Region Code")
            {

            }
            column(Buy_from_Post_Code; "Buy-from Post Code")
            {

            }
            column(Buyfrom_state; "Buy-from County")
            {

            }
            column(Buy_from_Vendor_No_; "Buy-from Vendor No.")
            {

            }
            column(Vendor_GST_Reg__No_; "Vendor GST Reg. No.")
            {

            }
            column(Supplierdate; "Order Date")
            {

            }
            column(StName; statename)

            {

            }
            column(StCode; statecode)
            {

            }
            column(AmountinWords; AmountinWords)
            {

            }



            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemLinkReference = "Purchase Header";
                column(Description; Description)
                {

                }
                column(Quantity; Quantity)
                {

                }
                column(Unit_of_Measure; "Unit of Measure")
                {

                }
                column(Unit_Cost; "Unit Cost")
                {

                }
                column(Line_Amount; "Line Amount")
                {

                }
                column(FinalAmount; FinalAmount)
                {

                }
                column(TotalTax; TotalTax)
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
                column(LineAMT; LineAMT)
                {

                }
                column(GrandTotal; GrandTotal)
                {

                }
                column(CGST; CGST)
                {

                }
                column(SGST; SGST)
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
                    RecPIL: Record "Purchase Line";
                    RecPIL1: Record "Purchase Line";
                    RecRef1: RecordRef;
                    TaxTransval1: Record "Tax Transaction Value";
                    SalesHeaderRecordID1: RecordId;
                begin
                    SrNo += 1;
                    IF RecItem.Get("Purchase Line"."No.") then ItemName := RecItem.Description;
                    TotalAmount += "Purchase Line".Quantity * "Purchase Line"."Unit Cost";
                    //------------------ GST  Calculation
                    SGST := 0;
                    CGST := 0;
                    IGST := 0;
                    Rate := 0;
                    Rate1 := 0;
                    RecRef.OPEN(DATABASE::"Purchase Line");
                    RecRef.SETTABLE(RecPIL);
                    RecPIL.Reset();
                    RecPIL.SetRange("Document No.", "Purchase Header"."No.");
                    RecPIL.SetFilter(RecPIL."GST Group Code", '<>%1', '');
                    if RecPIL.FindSet() then
                        SalesHeaderRecordID := RecPIL.RECORDID;
                    //Message('%1', PurchHeaderRecordID);
                    TaxTransval.Reset();
                    TaxTransval.SetRange("Tax Record ID", SalesHeaderRecordID);
                    TaxTransval.SetFilter("Value Type", '=%1', TaxTransval."Value Type"::COMPONENT);
                    TaxTransval.SetFilter(TaxTransval."Tax Type", '=%1', 'GST');
                    TaxTransval.SetFilter(Percent, '<>%1', 0);
                    if TaxTransval.FindSet() then
                        repeat //Message('%1  %2  %3', TaxTransval.ID, TaxTransval.Amount, TaxTransval.Percent);
                            IF "Purchase Line"."GST Jurisdiction Type" = "Purchase Line"."GST Jurisdiction Type"::Intrastate THEN BEGIN
                                Rate := TaxTransval.Percent;
                                CGST := TaxTransval.Amount;
                                Message('%1', TaxTransval.Amount);
                                SGST := TaxTransval.Amount;

                            END
                            ELSE
                                IF ("Purchase Line"."GST Jurisdiction Type" = "Purchase Line"."GST Jurisdiction Type"::Interstate) THEN BEGIN
                                    Rate1 := TaxTransval.Percent;
                                    IGST := TaxTransval.Amount;
                                END;
                        until TaxTransval.Next() = 0;
                    TotalCGST += CGST;
                    TotalSGST += SGST;
                    TotalIGST += IGST;

                    //until RecPIL.Next() = 0;
                    LineAMT += "Line Amount";


                    GrandTotal := LineAMT + TotalCGST + TotalSGST;
                    // FinalAmount += GrandTotal;
                    //tax := TotalCGST + TotalSGST + TotalIGST;

                    // GrandTotal := "Purchase Line".;
                    //TotalTax += tax;  
                    repcheck.InitTextVariable();
                    repcheck.FormatNoText(wordsinarray, GrandTotal, ' ');
                    AmountinWords := wordsinarray[1] + wordsinarray[2];





                end;
            }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                customer: Record Vendor;
                state: Record State;

            begin
                "Comp State".Reset();
                "Comp State".SetRange(Code, compinfo."State Code");
                if "Comp State".FindFirst() then begin
                    StName := "Comp State".Description;
                    StName := "Comp State"."State Code (GST Reg. No.)";

                end;
                customer.Reset();
                customer.SetRange(Name, "Purchase Header"."Buy-from Vendor Name");
                if customer.FindFirst() then begin
                    state.Reset();
                    state.SetRange(code, customer."State Code");
                    if state.FindFirst() then begin
                        statecode := state."State Code (GST Reg. No.)";
                        statename := State."Description";


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
                    // field(Name; SourceExpression)
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
        compinfo.get();
        compinfo.CalcFields(Picture);




    end;


    var
        myInt: Integer;
        compinfo: Record "Company Information";
        "Comp State": Record State;
        Company_State: Text[100];
        CGST: Decimal;
        SGST: Decimal;
        IGST: Decimal;
        Rate: Decimal;
        Rate1: Decimal;
        TotalCGST: Decimal;
        TotalSGST: Decimal;
        TotalIGST: Decimal;
        TotalAmount: Decimal;
        RecItem: Record Item;
        ItemName: Code[50];
        SrNo: Integer;
        TotalTDSAmt: Decimal;
        FinalAmount: Decimal;
        GrandTotal: Decimal;
        TotalTax: Decimal;
        repcheck: Report Check;
        wordsinarray: array[2] of Text;
        AmountinWords: text[200];

        StName: Text[100];
        StCode: Integer;
        tax: Decimal;
        statecode: Code[10];

        statename: Text[100];
        LineAMT: Decimal;



}
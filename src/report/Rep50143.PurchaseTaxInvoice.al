report 50143 "PurchaseTaxInvoice"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'PurchaseTaxInvoice.rdl';

    dataset
    {
        dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
        {
            RequestFilterFields = "No.";
            column(Buy_from_Vendor_Name; "Buy-from Vendor Name")
            {

            }
            column(Order_No_; "Order No.")
            {

            }
            column(Reference_Invoice_No_; "Reference Invoice No.")
            {

            }
            column(Your_Reference; "Your Reference")
            {

            }
            column(Vendor_GST_Reg__No_; "Vendor GST Reg. No.")
            {

            }
            column(Order_Date; "Order Date")
            {

            }
            column(Shipment_Method_Code; "Shipment Method Code")
            {

            }

            column(No_; "No.")
            {

            }
            column(Buy_from_Address; "Buy-from Address")
            {

            }
            column(Buy_from_Address_2; "Buy-from Address 2")
            {

            }
            column(Buy_from_City; "Buy-from City")
            {

            }
            column(Buy_from_Country_Region_Code; "Buy-from Country/Region Code")
            {

            }
            column(Buy_from_Post_Code; "Buy-from Post Code")
            {

            }
            column(Buy_from_Contact; "Buy-from Contact")
            {

            }
            column(GetTerm; GetTerm)
            {

            }
            //Company Informantion 
            column(Compinfo_Name; compinfo.Name)
            {

            }
            column(Compinfo_Address; Compinfo.Address)
            {

            }
            column(Compinfo_PostCode; Compinfo."Post Code")
            {

            }
            column(Compinfo_StateCode; Compinfo."State Code")
            {

            }
            column(Compinfo_Email; Compinfo."E-Mail")
            {

            }
            column(Compinfo_GST; Compinfo."GST Registration No.")
            {

            }
            column(Compinfo_PAN; Compinfo."P.A.N. No.")
            {
            }
            column(Compinfo_logo; Compinfo.Picture)
            {

            }
            column(Compinfo_Contact; Compinfo."Contact Person")
            {

            }
            column(Compinfo_BankNO; Compinfo."Bank Account No.")
            {

            }
            column(Compinfo_BankIfcs; Compinfo."Bank Branch No.")
            {

            }
            column(Compinfo_Bank; Compinfo."Bank Name")
            {

            }

            //Ship TO Information
            column(Ship_to_Address; "Ship-to Address")
            {
            }
            column(Ship_to_Name; "Ship-to Name")
            {
            }
            column(Ship_to_City; "Ship-to City")
            {
            }
            column(Ship_to_Country_Region_Code; "Ship-to Country/Region Code")
            {
            }
            column(Ship_to_County; "Ship-to County")
            {
            }
            column(Ship_to_Post_Code; "Ship-to Post Code")
            {
            }

            //bank details
            column(Bank_Name; BankeName)
            {

            }
            column(Bank_No; BankAcc)
            {

            }
            column(Bank_Br_No; bankifsc)
            {

            }



            dataitem("Purch. Inv. Line"; "Purch. Inv. Line") //dataitem having four proporties
            {
                DataItemLink = "Document No." = field("No.");
                DataItemLinkReference = "Purch. Inv. Header";
                RequestFilterFields = "No.";
                // DataItemTableView=sorting

                column(Quantity; Quantity)
                {
                }
                column(Unit_Cost; "Unit Cost")
                {
                }
                Column(Line_Amount; "Line Amount")
                {
                }
                column(Line_Discount__; "Line Discount %")
                {
                }
                column(Unit_of_Measure; "Unit of Measure")
                {
                }
                column(Description; Description)
                {
                }
                column(HSN_SAC_Code; "HSN/SAC Code")
                {

                }
                column(CGSTAmt; CGSTAmt)
                {
                }
                column(CGSTRate; CGSTRate)
                {
                }
                column(SGSTAmt; SGSTAmt)
                {
                }
                column(SGSTRate; SGSTRate)
                {
                }
                column(IGStAmt; IGStAmt)
                {
                }
                column(IGSTRate; IGSTRate)
                {
                }
                column(Line_Discount_Amount; "Line Discount Amount")
                {
                }
                column(FinalAmount; FinalAmount)
                {
                }
                column(AmountInWords; AmountInWords)
                {
                }
                column(TaxInWords2; TaxInWords2)
                {
                }
                column(Tax2; Tax2)
                {
                }


                //bank Details


                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin
                    Clear(CGSTAmt);
                    Clear(CGSTRate);
                    Clear(SGSTRate);
                    Clear(SGSTAmt);
                    Clear(IGStAmt);
                    Clear(IGSTRate);
                    Clear(GSTComponentCGST);
                    Clear(GSTComponentSGST);
                    Clear(GSTComponentIGST);

                    GSTDetailLeger.Reset();
                    GSTDetailLeger.SetRange(GSTDetailLeger."No.", "Purch. Inv. Line"."No.");
                    GSTDetailLeger.SetRange(GSTDetailLeger."Document No.", "Purch. Inv. Line"."Document No.");
                    GSTDetailLeger.SetRange(GSTDetailLeger."Document Line No.", "Purch. Inv. Line"."Line No.");

                    If GSTDetailLeger.FindSet then
                        repeat
                            if GSTDetailLeger."GST Component Code" = 'CGST' then begin
                                GSTComponentCGST := 'CGST';
                                CGSTAmt := GSTDetailLeger."GST Amount";
                                CGSTRate := GSTDetailLeger."GST %";
                            END Else
                                if GSTDetailLeger."GST Component Code" = 'SGST' Then Begin
                                    GSTComponentSGST := 'SGST';
                                    SGSTRate := GSTDetailLeger."GST %";
                                    SGSTAmt := GSTDetailLeger."GST Amount";
                                End else
                                    if GSTDetailLeger."GST Component Code" = 'IGST' Then begin
                                        GSTComponentIGST := 'IGST';
                                        IGStAmt := GSTDetailLeger."GST Amount";
                                        IGSTRate := GSTDetailLeger."GST %";
                                    end;
                        until GSTDetailLeger.Next = 0;

                    TotalAmount := "Purch. Inv. Line"."Line Amount" + CGSTAmt + SGSTAmt + IGStAmt;
                    FinalAmount += TotalAmount;
                    repcheck.InitTextVariable();
                    repcheck.FormatNoText(Wordsinarray, FinalAmount, ' ');
                    AmountInWords := Wordsinarray[1] + Wordsinarray[2];

                    //Tax In Words
                    Tax := CGSTAmt + SGSTAmt;
                    tax2 += Tax;
                    repcheck2.InitTextVariable();
                    repcheck2.FormatNoText(Wordsinarray2, Tax2, ' ');
                    TaxInWords2 := Wordsinarray2[1] + Wordsinarray2[2];










                end;

            }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                term.SetRange(term.Code, "Purch. Inv. Header"."Payment Terms Code");
                if term.FindFirst then begin
                    GetTerm := term.Description;
                end;

                BankAccount.Reset();
                BankAccount.SetRange("No.", "No.");
                if BankAccount.Find('-') then begin
                    BankeName := BankAccount.Name;
                    BankAcc := BankAccount."Bank Account No.";
                    bankifsc := BankAccount."Bank Branch No.";
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
                // group("Bank Account")
                // {
                //     field(Bank_No; BankAccount."Bank Account No.")
                //     {
                //         ApplicationArea = All;
                //         TableRelation = "Bank Account";

                //     }
                //     // field(bankAccount; Banka."Bank Account No.")
                //     // {
                //     //     ApplicationArea = all;
                //     //     TableRelation = "Bank Account";
                //     // }

                // }

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
        Compinfo.get();
        Compinfo.CalcFields(Picture);


    end;

    // rendering
    // {
    //     layout(LayoutName)
    //     {
    //         Type = RDLC;
    //         LayoutFile = 'mylayout.rdl';
    //     }
    // }

    var
        myInt: Integer;

        Compinfo: Record "Company Information";
        GSTDetailLeger: Record "Detailed GST Ledger Entry";
        CGSTRate: Decimal;
        CGSTAmt: Decimal;
        SGSTRate: Decimal;
        SGSTAmt: Decimal;
        IGSTRate: Decimal;
        IGStAmt: Decimal;
        BankAccount: Record "Bank Account";
        GSTComponentCGST: Code[20];
        GSTComponentSGST: Code[20];
        GSTComponentIGST: Code[20];

        TotalAmount: Decimal;
        FinalAmount: Decimal;
        repcheck: Report Check;
        AmountInWords: Text[200];
        Wordsinarray: array[2] of Text;
        Wordsinarray2: array[2] of Text;
        TaxInWords2: Text[200];
        Tax: Decimal;
        Tax2: Decimal;
        repcheck2: Report Check;


        total: Decimal;
        Purchline: Record "Purch. Inv. Line";
        term: Record "Payment Terms";
        GetTerm: Text[100];

        BankeName: text[100];
        BankAcc: text[100];
        bankifsc: text[100];
        BankAccount1: Record "Bank Account";




}
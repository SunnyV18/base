report 50131 "PurchaseDebitNote"

{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Debitnote.rdl';



    dataset
    {
        dataitem("Purch. Cr. Memo Hdr."; "Purch. Cr. Memo Hdr.")
        {
            RequestFilterFields = "No.";
            column(No_; "No.")
            {

            }
            column(Buy_from_Contact; "Buy-from Contact")
            {

            }
            column(Vendor_Cr__Memo_No_; "Vendor Cr. Memo No.")
            {

            }
            column(Buy_from_Vendor_Name; "Buy-from Vendor Name")
            {

            }
            column(Posting_Date; "Posting Date")
            {

            }
            column(Location_State_Code; "Location State Code")
            {

            }
            column(Document_Date; "Document Date")
            {

            }

            //SHIPPING AND PAYMENT

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
            column(Vendor_GST_Reg__No_; "Vendor GST Reg. No.")
            {

            }
            //  COMPANY  INFORMATION
            column(COMP_NAME; compinfo.Name)
            {

            }
            column(comp_address; compinfo.Address)
            {

            }
            column(comp_city; compinfo.City)
            {

            }
            column(comp_PostCode; compinfo."Post Code")
            {

            }
            column(CompGST; compinfo."GST Registration No.")
            {

            }
            column(comp_PAN; compinfo."P.A.N. No.")
            {

            }
            column(comp_Email; compinfo."E-Mail")
            {
            }
            column(revergecharge; revergecharge)
            {
            }

            //Purchase Line
            dataitem("Purch. Cr. Memo Line"; "Purch. Cr. Memo Line")
            {
                DataItemLinkReference = "Purch. Cr. Memo Hdr.";
                DataItemLink = "Document No." = field("No.");

                column(Description; Description)
                {

                }
                column(HSN_SAC_Code; "HSN/SAC Code")
                {

                }
                column(Quantity; Quantity)
                {

                }
                column(Rate; "Unit Cost")
                {

                }
                column(Line_Amount; "Line Amount")
                {

                }
                column(Inv__Discount_Amount; "Line Discount Amount")
                {

                }
                column(CGSTRate; CGSTRate)
                {

                }
                column(CGSTAmt; CGSTAmt)
                {

                }
                column(SGSTAmt; SGSTAmt)
                {

                }
                column(SGSTRate; SGSTRate)
                {

                }
                column(IGSTRate; IGSTRate)
                {

                }
                column(IGSTAmt; IGSTAmt)
                {

                }
                column(AmountInWords; AmountInWords)
                {
                }
                column(Total_Amount; Total_Amount)
                {
                }
                column(totalTax; totalTax)
                {
                }
                column(FinalAmount; FinalAmount)
                {

                }


                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin
                    CLEAR(CGSTRate);

                    CLEAR(CGSTAmt);

                    CLEAR(GSTComponentCGST);

                    CLEAR(SGSTRate);

                    CLEAR(SGSTAmt);

                    CLEAR(GSTComponentSGST);

                    CLEAR(IGSTRate);

                    CLEAR(IGSTAmt);

                    CLEAR(GSTComponentIGST);

                    GSTDetailLeger.RESET;

                    GSTDetailLeger.SETRANGE(GSTDetailLeger."Document No.", "Purch. Cr. Memo Line"."Document No.");

                    GSTDetailLeger.SETRANGE(GSTDetailLeger."No.", "Purch. Cr. Memo Line"."No.");

                    GSTDetailLeger.SETRANGE(GSTDetailLeger."Document Line No.", "Purch. Cr. Memo Line"."Line No.");

                    IF GSTDetailLeger.FINDSET THEN
                        REPEAT

                            IF GSTDetailLeger."GST Component Code" = 'CGST' THEN BEGIN

                                GSTComponentCGST := 'CGST';

                                CGSTRate := GSTDetailLeger."GST %";

                                CGSTAmt := GSTDetailLeger."GST Amount";

                            END ELSE

                                IF GSTDetailLeger."GST Component Code" = 'SGST' THEN BEGIN

                                    GSTComponentSGST := 'SGST';

                                    SGSTRate := GSTDetailLeger."GST %";

                                    SGSTAmt := GSTDetailLeger."GST Amount";

                                END ELSE

                                    IF GSTDetailLeger."GST Component Code" = 'IGST' THEN BEGIN

                                        GSTComponentIGST := 'IGST';

                                        IGSTRate := GSTDetailLeger."GST %";

                                        IGSTAmt := GSTDetailLeger."GST Amount";

                                    END;

                        UNTIL GSTDetailLeger.NEXT = 0;

                    // Total_Amount := "Line Amount";



                    Total_Amount := "Purch. Cr. Memo Line".Quantity * "Purch. Cr. Memo Line"."Unit Cost" + CGSTAmt + SGSTAmt + IGSTAmt;
                    FinalAmount += Total_Amount;
                    repcheck.InitTextVariable();
                    repcheck.FormatNoText(Wordsinarray, FinalAmount, ' ');
                    AmountInWords := Wordsinarray[1] + Wordsinarray[2];



                    totalTax := CGSTAmt + SGSTAmt + IGSTAmt;





                end;



            }


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
                    field(Reverseorder; revergecharge)
                    {
                        ApplicationArea = All;
                        Caption = 'Reverscharge';


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
    var
        myInt: Integer;
    begin
        compinfo.get();

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
        compinfo: Record "Company Information";

        GSTDetailLeger: Record "Detailed GST Ledger Entry";
        CGSTRate: Decimal;
        CGSTAmt: Decimal;
        GSTComponentCGST: Code[20];
        SGSTRate: Decimal;
        SGSTAmt: Decimal;
        GSTComponentSGST: Code[20];
        IGSTRate: Decimal;
        IGSTAmt: Decimal;
        GSTComponentIGST: Code[20];
        Amount: Decimal;
        Total_Amount: Decimal;
        repcheck: Report Check;
        AmountInWords: Text[200];
        Wordsinarray: array[2] of Text;
        total: Decimal;
        purchline: Record "Purch. Cr. Memo Line";
        totalTax: Decimal;
        FinalAmount: Decimal;

        revergecharge: Option " ",Yes,NO;


}
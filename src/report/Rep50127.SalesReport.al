report 50127 "Sales Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'SalesOrder.rdl';
    //DefaultRenderingLayout = LayoutName;


    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            RequestFilterFields = "No.";
            column(CompName; compinfo.Name)
            {
            }
            column(compaddress; compinfo.Address)
            {
            }
            column(compaddress2; compinfo."Address 2")
            {
            }
            column(compcity; compinfo.City)
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

            //Customer information
            column(Bill_to_Name; "Bill-to Name")
            {
            }
            column(Bill_to_Address; "Bill-to Address")
            {
            }
            column(Bill_to_Contact; "Bill-to Contact")
            {
            }
            column(Order_No_; "Order No.")
            {
            }



            column(GSTRegistrationNo; compinfo."GST Registration No.")
            {
            }

            //Right Side Coloum
            column(PurHoOrderNo; "No.")
            {
            }
            column(date; "Document Date")
            {
            }
            column(Payment_Reference; "Payment Reference")
            {
            }
            column(Destination; "Ship-to City")
            {
            }
            column(Currency_Code; "Currency Code")
            {
            }
            column(CGSTRate; CGSTRate)
            {
            }
            column(CGSTAmt; CGSTAmt)
            {
            }
            column(SGSTRate; SGSTRate)
            {
            }
            column(SGSTAmt; SGSTAmt)
            {
            }
            column(IGSTRate; IGSTRate)
            {
            }
            column(IGSTAmt; IGSTAmt)
            {
            }
            column(Ship_to_Address; "Ship-to Address")
            {
            }
            column(Shipment_Date; "Shipment Date")
            {
            }
            column(Ship_to_City; "Ship-to City")
            {
            }



            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemLinkReference = "Sales Invoice Header";
                column(Description; Description)
                {
                }
                column(HSN_SAC_Code; "HSN/SAC Code") // If hsn not present then we have to see their extemnsion On the Page then After we have to put the ext management on the dependiencies on the page;
                {
                }
                column(Quantity; Quantity)
                {
                }
                column(Unit_Price; "Unit Price")
                {
                }
                column(Unit_of_Measure_Code; "Unit of Measure Code")
                {
                }
                column(Line_Amount; "Line Amount")
                {
                }
                column(wordsamount; amountinwords)
                {
                }
                column(FinalAmount; FinalAmount)
                {
                }
                column(total; total)
                {
                }

                column(getTerm; getTerm)
                {
                }



                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin


                    CLEAR(CGSTRate); //%tax

                    CLEAR(CGSTAmt); //Calc Amount

                    CLEAR(GSTComponentCGST);
                    // Clr---first value will clear

                    CLEAR(SGSTRate);

                    CLEAR(SGSTAmt);

                    CLEAR(GSTComponentSGST);

                    CLEAR(IGSTRate);

                    CLEAR(IGSTAmt);

                    CLEAR(GSTComponentIGST);

                    GSTDetailLeger.RESET;

                    GSTDetailLeger.SETRANGE(GSTDetailLeger."Document No.", "Sales Invoice Line"."Document No.");

                    GSTDetailLeger.SETRANGE(GSTDetailLeger."No.", "Sales Invoice Line"."No.");

                    GSTDetailLeger.SETRANGE(GSTDetailLeger."Document Line No.", "Sales Invoice Line"."Line No.");

                    IF GSTDetailLeger.FINDSET THEN
                        REPEAT

                            IF GSTDetailLeger."GST Component Code" = 'CGST' THEN BEGIN

                                GSTComponentCGST := 'CGST';

                                CGSTRate := GSTDetailLeger."GST %";

                                CGSTAmt += abs(GSTDetailLeger."GST Amount");

                            END ELSE

                                IF GSTDetailLeger."GST Component Code" = 'SGST' THEN BEGIN

                                    GSTComponentSGST := 'SGST';

                                    SGSTRate := abs(GSTDetailLeger."GST %");

                                    SGSTAmt += abs(GSTDetailLeger."GST Amount");

                                END ELSE

                                    IF GSTDetailLeger."GST Component Code" = 'IGST' THEN BEGIN

                                        GSTComponentIGST := 'IGST';

                                        IGSTRate := GSTDetailLeger."GST %";

                                        IGSTAmt += abs(GSTDetailLeger."GST Amount");//abs always return a positive value and remove (-) sign.

                                    END;
                        //grandtotal := "Line Amount" + CGSTAmt + SGSTAmt + IGSTAmt;

                        UNTIL GSTDetailLeger.NEXT = 0;

                    grandtotal += "Line Amount" + CGSTAmt + SGSTAmt + IGSTAmt;
                    //finalAmount := Quantity * "Unit Price" + grandtotal;
                    total := grandtotal;
                    repcheck.InitTextVariable();
                    repcheck.FormatNoText(wordinarray, total, "Sales Invoice Header"."Currency Code");
                    amountinwords := wordinarray[1] + wordinarray[2];



                end;

            }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                term.SetRange(Code, "Sales Invoice Header"."Payment Terms Code");
                if term.FindFirst() then begin
                    getTerm := term.Description;
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
        repcheck: Report Check;
        wordinarray: array[2] of text;
        total: Decimal;
        amountinwords: Text[259];
        purchline: Record "Purchase Line";
        grandtotal: Decimal;
        FinalAmount: Decimal;
        GSTDetailLeger: Record "Detailed GST Ledger Entry";
        SGSTRate: Decimal;
        GSTComponentCGST: Code[20];
        CGSTRate: Decimal;
        CGSTAmt: Decimal;
        SGSTAmt: Decimal;
        GSTComponentSGST: Code[20];
        GSTComponentIGST: Code[20];
        IGSTRate: Decimal;
        IGSTAmt: Decimal;
        tottal1: Decimal;
        term: Record "Payment Terms";
        getTerm: Text[100];







}
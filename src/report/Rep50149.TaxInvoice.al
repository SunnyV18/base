report 50149 "Tax Invoice"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'TaxInvoice.rdl';

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
            column(CompPAN; compinfo."P.A.N. No.")
            {
            }
            column(CompGST; compinfo."GST Registration No.")
            {
            }
            // column(CompHSN; compinfo.)
            // {
            // }
            column(CompStateName; CompStateName)
            {
            }
            column(CompStateNo; CompStateNo)
            {
            }
            column(No_; "No.")
            {
            }
            column(Order_Date; "Order Date")
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
            column(Add; Add)
            {
            }
            column(City; City)
            {
            }
            column(PostCode; PostCode)
            {
            }
            column(StateName; StateName)
            {
            }
            column(StateCode; StateCode)
            {
            }
            column(BankAccountName; BankAccountName)
            {
            }
            column(BankAccountNo; BankAccountNo)
            {
            }
            column(BankBranchNo; BankBranchNo)
            {
            }
            column(StateName2; StateName2)
            {
            }
            Column(PAN; PAN)
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
                    var23.InitTextVariable();
                    var23.FormatNoText(wordinarray, total, "Sales Invoice Header"."Currency Code");
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
                Customer.Reset();
                Customer.SetRange(Customer.Name, "Sales Invoice Header"."Bill-to Name");
                if Customer.FindFirst() then Begin
                    Add := Customer.Address;
                    City := Customer.City;
                    PostCode := Customer."Post Code";
                    PAN := Customer."P.A.N. No.";
                    StateRec.Reset();

                    StateRec.SetRange(StateRec.Code, Customer."State Code");
                    StateName := StateRec.Description;
                    StateCode := StateRec."State Code (GST Reg. No.)";
                End;
                //Method 2
                StateRec.Reset();

                StateRec.SetRange(StateRec.Code, "Sales Invoice Header"."Location State Code");
                if StateRec.FindFirst() then Begin
                    StateName2 := StateRec.Description;

                End



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
        BankAccountName := BankAccount.Name;
        BankAccountNo := BankAccount."Bank Account No.";
        BankBranchNo := BankAccount."Bank Branch No.";
        StateRec.Reset();
        StateRec.SetRange(StateRec.Code, compinfo."State Code");
        if StateRec.FindFirst() then begin
            CompStateName := StateRec.Description;
            CompStateNo := StateRec."State Code (GST Reg. No.)";

        end;
        // Customer.Reset();
        // Customer.SetRange(Customer.Name, "Sales Invoice Header"."Bill-to Name");
        // if Customer.FindFirst() then Begin
        //     Add := Customer.Address;
        //     City := Customer.City;
        //     PostCode := Customer."Post Code";
        //     PAN := Customer."P.A.N. No.";
        //     StateRec.Reset();

        //     StateRec.SetRange(StateRec.Code, Customer."State Code");
        //     StateName := StateRec.Description;
        //     StateCode := StateRec."State Code (GST Reg. No.)";
        // End;



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
        Location: Record Location;
        Add: Text[100];
        City: Text[100];
        PostCode: Code[30];
        StateRec: Record State;
        StateName: Text[100];
        CompStateName: Text[50];
        CompStateNo: Code[20];
        StateCode: text[20];
        Customer: Record Customer;
        PAN: Code[20];
        var23: Report "Posted Voucher";


        wordinarray: array[2] of text;
        BankAccountName: Text[100];
        BankAccountNo: Text[30];
        BankBranchNo: Text[30];
        StateName2: Text[20];

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
        BankAccount: Record "Bank Account";

        IGSTAmt: Decimal;
        tottal1: Decimal;
        term: Record "Payment Terms";
        getTerm: Text[100];







}
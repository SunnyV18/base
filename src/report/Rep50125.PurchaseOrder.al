report 50125 "Purchase Order"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    //DefaultRenderingLayout = LayoutName;
    DefaultLayout = RDLC;
    RDLCLayout = 'Purchase Order.rdl';

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            RequestFilterFields = "No.";

            //Buyer Information
            column(companyname; compinfo.Name)
            {
            }
            column(companyaddress; compinfo.Address)
            {
            }
            column(companyaddress2; compinfo."Address 2")
            {
            }
            column(companycity; compinfo.City)
            {
            }

            //Supplier Information

            column(Buy_from_Vendor_Name; "Buy-from Vendor Name")
            {
            }
            column(Buy_from_Vendor_No_; "Buy-from Vendor No.")
            {
            }
            column(Buy_from_Address; "Buy-from Address")
            {
            }
            column(Buy_from_City; "Buy-from City")
            {
            }
            column(Buy_from_Contact_No_; "Buy-from Contact No.")
            {
            }
            column(excrate; excrate)
            {
            }
            column(Termval; Termval)
            {
            }


            //Purchase Order No

            column(No_; "No.")
            {
            }
            column(Order_Date; "Order Date")
            {
            }
            column(Currency_Code; "Currency Code")
            {
            }

            //Line Table
            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLinkReference = "Purchase Header";
                DataItemLink = "Document No." = field("No.");

                column(Description; Description)
                {
                }
                column(Quantity; Quantity)
                {
                }
                column(HSN_SAC_Code; "HSN/SAC Code")
                {
                }
                column(Unit_of_Measure_Code; "Unit of Measure Code")
                {
                }
                column(Unit_Cost; "Unit Cost")
                {
                }
                column(VAT__; "VAT %")
                {
                }
                column(VAT_Base_Amount; "VAT Base Amount")
                {
                }
                column(Line_Amount; "Line Amount")
                {
                }
                column(Logo; compinfo.Picture)
                {
                }
                column(finalamt; grandtotal)
                {
                }
                column(amountinword; wardsarray[1])
                {
                }
                column(finalAmount; finalAmount)
                {
                }


                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin
                    purchline.Reset();
                    purchline.SetRange("Document No.", "Purchase Header"."No.");
                    // if purchline.FindSet() then begin

                    // end;s
                    grandtotal := Quantity * "Unit Cost" * "VAT %" / 100;
                    finalAmount := Quantity * "Unit Cost" + grandtotal;
                    total += "finalAmount";
                    repcheck.InitTextVariable();
                    repcheck.FormatNoText(wardsarray, total, "Purchase Header"."Currency Code");
                    amountinword := wardsarray[1] + wardsarray[2];




                end;



            }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                CurrExeRate.SetRange("Currency Code", "Purchase Header"."Currency Code");
                if CurrExeRate.FindSet() then begin
                    excrate := CurrExeRate."Exchange Rate Amount";
                end;

                //Payment term
                Term.SetRange(Code, "Purchase Header"."Payment Terms Code");
                if Term.FindFirst() then begin
                    Termval := Term.Description;
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
        repcheck: Report check;
        wardsarray: array[2] of Text;
        amountinword: Text[250];

        purchline: Record "Purchase Line";
        total: Decimal;
        grandtotal: Decimal;
        finalAmount: Decimal;
        AmountofFinalAmount: Decimal;

        Curr: Record Currency;
        PH: Record "Purchase Header";

        excrate: Decimal;

        CurrExeRate: Record "Currency Exchange Rate";

        Term: Record "Payment Terms";
        Termval: Text[100];

}
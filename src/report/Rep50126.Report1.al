report 50126 "Report1"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'report1.rdl';

    //DefaultRenderingLayout = LayoutName;

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            RequestFilterFields = "No.";
            //Company Information
            column(compname; compinfo.Name)
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
            //vendor Address
            column(Buy_from_Vendor_Name; "Buy-from Vendor Name")
            {
            }
            column(Buy_from_Address; "Buy-from Address")
            {
            }
            column(Vendor_GST_Reg__No_; "Vendor GST Reg. No.")
            {
            }
            column(Buy_from_City; "Buy-from City")
            {
            }
            column(Buy_from_Vendor_No_; "Buy-from Vendor No.")
            {
            }
            column(Buy_from_Country_Region_Code; "Buy-from Country/Region Code")
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

            //Terms Of Payment
            column(getTerm; getTerm)
            {
            }
            column(wordsAmount; wordinarray[1])
            {
            }


            //Line Table Purchase Line We have to ctreate




            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLinkReference = "Purchase Header";
                DataItemLink = "Document No." = field("No.");

                column(Description; Description)
                {
                }
                column(HSN_SAC_Code; "HSN/SAC Code") // If hsn not present then we have to see their extemnsion On the Page then After we have to put the ext management on the dependiencies on the page;
                {
                }
                column(Quantity; Quantity)
                {
                }
                column(Unit_Cost; "Unit Cost")
                {
                }
                column(Unit_of_Measure_Code; "Unit of Measure Code")
                {
                }
                column(Line_Amount; "Line Amount")
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
                    if purchline.FindSet() then begin
                        repeat

                        until purchline.Next() = 0;

                    end;
                    // grandtotal := Quantity * "Unit Cost" * "VAT %" / 100;
                    // finalAmount := Quantity * "Unit Cost" + grandtotal;

                    grandtotal := Quantity * "Unit Cost" * "VAT %" / 100;
                    finalAmount := Quantity * "Unit Cost" + grandtotal;
                    total += finalAmount;

                    repchek.InitTextVariable();
                    repchek.FormatNoText(wordinarray, total, "Purchase Header"."Currency Code");
                    amountinwords := wordinarray[1] + wordinarray[2];




                end;




            }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                term.SetRange(Code, "Purchase Header"."Payment Terms Code");
                if term.FindFirst() then begin
                    getTerm := term.Description; //now create getterm fiels
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

        term: Record "Payment Terms";
        getTerm: Text[100];
        purchline: Record "Purchase Line";
        repchek: Report Check;
        total: Decimal;
        wordinarray: array[2] of Text;

        grandtotal: Decimal;
        finalAmount: Decimal;

        amountinwords: Text[190];


}

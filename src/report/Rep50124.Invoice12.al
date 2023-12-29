report 50124 "Invoice12"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    //DefaultRenderingLayout = LayoutName;
    DefaultLayout = RDLC;


    RDLCLayout = 'Invoice1.rdl';


    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            RequestFilterFields = "No.";
            column(Buy_from_Address; "Buy-from Address")
            {

            }
            column(Buy_from_City; "Buy-from City")
            {

            }
            column(Buy_from_Contact; "Buy-from Contact")
            {

            }
            column(No_; "No.")
            {

            }
            column(Buy_from_Vendor_Name; "Buy-from Vendor Name")
            {
            }
            column(Location_Code; "Location Code")
            {

            }
            column(Invoice_Discount_Amount; "Invoice Discount Amount")
            {
            }
            column(Vendor_Order_No_; "Vendor Order No.")
            {

            }
            column(compname; compinfo.Name) { }
            column(compaddrs; compinfo.Address) { }

            column(Order_Date; "Order Date") { }
            column(Vendor_Address; "Vendor Address") { }
            column(Compaddrs2; compinfo."Address 2") { }
            column(pincode; compinfo."Post Code") { }





            column(Buy_from_Contact_No_; "Buy-from Contact No.") { }

            column(Invoice_Discount_Value; "Invoice Discount Value")
            {

            }
            column(Amount; Amount)
            {

            }

            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLinkReference = "Purchase Header";
                DataItemLink = "Document No." = field("No.");
                column(Description; Description)
                {

                }
                column(Line_Amount; "Line Amount")
                {

                }

                column(Amount_Including_VAT; "Amount Including VAT")
                {

                }
                column(amountinword; amountinword) { }
                column(amtincvat; totalvat) { }


            }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                purchLine.Reset();
                purchLine.SetRange("Document No.", "Purchase Header"."No.");// for specific field
                if purchLine.FindSet() then begin
                    repeat
                        total += purchLine."Line Amount";
                    until purchLine.Next() = 0;
                end;
                repcheck.InitTextVariable();
                repcheck.FormatNoText(wardsarray, total, "Purchase Header"."Currency Code");
                amountinword := wardsarray[1] + wardsarray[2];
                //grandtotal= total + vat amt;

                totalvat := "Purchase Line"."Line Amount" * "Purchase Line"."VAT %" / 100;
            end;


        }
    }

    requestpage
    {
        SaveValues = true;
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    // field(no; "Purchase Header"."No.")
                    // {
                    //     ApplicationArea = all;
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

    end;

    var
        myInt: Integer;
        compinfo: Record "Company Information";
        repcheck: Report Check;
        wardsarray: array[2] of Text;
        amountinword: Text[100];
        purchLine: Record "Purchase Line";
        total: Decimal;
        totalvat: Decimal;
}
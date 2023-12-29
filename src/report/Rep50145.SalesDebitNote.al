report 50145 "SalesDebitNote"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'SalesDebitNote.rdl';


    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            RequestFilterFields = "No.";
            column(compinfo_name; compinfo.Name)
            {

            }
            column(compinfo_PAN; compinfo."P.A.N. No.")
            {

            }
            column(compinfo_Address; compinfo.Address)
            {

            }
            column(compinfo_StateCode; compinfo."State Code")
            {

            }
            column(compinfo_city; compinfo.City)
            {

            }
            column(compinfo_Email; compinfo."E-Mail")
            {

            }
            column(compinfo_PostCode; compinfo."Post Code")
            {

            }
            column(compinfo_GST; compinfo."GST Registration No.")
            {

            }
            //Buyer Information
            column(Bill_to_Name; "Bill-to Name")
            {

            }
            column(Bill_to_Address; "Bill-to Address")
            {

            }
            column(No_; "No.")
            {

            }
            column(Bill_to_City; "Bill-to City")
            {

            }
            column(Bill_to_Country_Region_Code; "Bill-to Country/Region Code")
            {

            }
            column(Bill_to_County; "Bill-to County")
            {

            }
            column(Bill_to_Contact_No_; "Bill-to Contact No.")
            {

            }
            column(Customer_GST_Reg__No_; "Customer GST Reg. No.")
            {

            }
            column(Reference_Invoice_No_; "Reference Invoice No.")
            {

            }
            column(State; State)
            {

            }
            column(Order_Date; "Order Date")
            {

            }
            column(StateCode; StateCode)
            {

            }
            column(Satename; Satename)
            {

            }

            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemLinkReference = "Sales Invoice Header";
                column(Description; Description)
                {
                }
                column(Quantity; Quantity)
                {
                }
                column(Line_Amount; "Line Amount")
                {
                }
                column(Unit_Cost; "Unit Cost")
                {
                }
                column(AmountInWords; AmountInWords)
                {

                }
                column(Final_Amount_Amount; Final_Amount)
                {

                }
                column(IGSTAmt; IGSTAmt)
                {

                }
                column(IGSTRate; IGSTRate)
                {

                }
                column(Total_Amount1; Total_Amount)
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
                    GSTDetailLeger.Reset();
                    GSTDetailLeger.SetRange("Document No.", "Sales Invoice Line"."Document No.");
                    GSTDetailLeger.SetRange("No.", "Sales Invoice Line"."No.");
                    GSTDetailLeger.SetRange("Document Line No.", "Sales Invoice Line"."Line No.");
                    If GSTDetailLeger.FindSet() then
                        repeat
                            if GSTDetailLeger."GST Component Code" = 'CGST' then begin
                                GSTComponentCGST := 'CGST';
                                CGSTAmt := abs(GSTDetailLeger."GST Amount");
                                CGSTRate := GSTDetailLeger."GST %";
                            end else
                                if GSTDetailLeger."GST Component Code" = 'SGST' then begin
                                    GSTComponentSGST := 'SGST';
                                    SGSTAmt := abs(GSTDetailLeger."GST Amount");
                                    SGSTRate := GSTDetailLeger."GST %";
                                end else
                                    if GSTDetailLeger."GST Component Code" = 'IGST' then begin
                                        GSTComponentIGST := 'IGST';
                                        IGSTAmt := Abs(GSTDetailLeger."GST Amount");
                                        IGSTRate := Abs(GSTDetailLeger."GST %");
                                    end;

                        until GSTDetailLeger.next = 0;
                    Total_Amount := "Sales Invoice Line"."Line Amount" + CGSTAmt + SGSTAmt + IGSTAmt;
                    Final_Amount += Total_Amount;

                    repcheck.InitTextVariable();
                    repcheck.FormatNoText(wordsinarray, Final_Amount, ' ');
                    AmountInWords := wordsinarray[1] + wordsinarray[2];



                end;
            }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                Customer: Record Customer;
                State: Record State;


            begin
                Customer.Reset();
                Customer.SetRange(Customer.Name, "Sales Invoice Header"."Sell-to Customer Name");
                if Customer.FindFirst() then begin
                    State.Reset();
                    State.SetRange(Code, Customer."State Code");
                    if State.FindFirst() then begin
                        Satename := State.Description;
                        StateCode := State."State Code (GST Reg. No.)";

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

    end;



    var
        myInt: Integer;
        Satename: Text[100];
        StateCode: text[50];


        compinfo: Record "Company Information";
        GSTDetailLeger: Record "Detailed GST Ledger Entry";
        CGSTAmt: Decimal;
        CGSTRate: Decimal;
        GSTComponentCGST: Code[20];
        SGSTAmt: Decimal;
        SGSTRate: Decimal;
        GSTComponentSGST: Code[20];
        IGSTAmt: Decimal;
        IGSTRate: Decimal;
        GSTComponentIGST: Code[20];
        Amount: Decimal;
        Total_Amount: Decimal;
        repcheck: report Check;
        AmountInWords: Text[200];
        wordsinarray: array[2] of text;
        Final_Amount: Decimal;
}
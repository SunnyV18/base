report 50108 "VendorLedgerEntries"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'VendorLedger.rdl';


    dataset
    {
        dataitem(Vendor; Vendor)
        {
            column(Comp_Name; compinfo.Name)
            {

            }

            dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
            {
                RequestFilterFields = "Posting Date";

                DataItemLinkReference = Vendor;
                DataItemLink = "Vendor No." = field("No.");
                column(Posting_Date; "Posting Date")
                {

                }
                column(Vendor_Name; "Vendor Name")
                {

                }
                column(Vendor_No_; "Vendor No.")
                {

                }

                column(Document_No_; "Document No.")
                {

                }
                column(Bal__Account_No_; "Bal. Account No.")
                {

                }
                column(Bal__Account_Type; "Bal. Account Type")
                {

                }
                column(Original_Amount; "Original Amount")
                {

                }
                column(Amount; Amount)
                {

                }
                column(Remaining_Amount; Abs(Cal_Amount)) { }
                column(Debit_Amount; "Debit Amount") { }
                column(Credit_Amount; "Credit Amount") { }
                column(Closed_by_Amount__LCY_; "Closed by Amount (LCY)") { }
                column(Closed_by_Amount; Abs("Closed by Amount")) { }
                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin
                    Cal_Amount := Abs("Credit Amount") - Abs("Debit Amount");

                end;



            }

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
        Compinfo.get();


    end;

    // rendering
    // {
    //     layout(LayoutName)
    //     {
    //         Type = Excel;
    //         LayoutFile = 'mySpreadsheet.xlsx';
    //     }
    // }

    var
        myInt: Integer;
        Cal_Amount: Decimal;
        Compinfo: Record "Company Information";
}
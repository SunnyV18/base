report 50129 "Sales Shipment"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Sales_Shipment.rdl';
    // DefaultRenderingLayout = LayoutName;

    dataset
    {

        dataitem("Sales Shipment Header"; "Sales Shipment Header")
        {
            RequestFilterFields = "No.";

            column(compname; compinfo.Name)
            {

            }
            column(compadd; compinfo.Address)
            {

            }
            column(compno; compinfo.City)
            {

            }
            column(compcountry; compinfo.County)

            {

            }
            column(postcode; compinfo."Post Code")
            {

            }
            //Customer Information
            column(Bill_to_Name; "Bill-to Name")
            {

            }
            column(Bill_to_Address; "Bill-to Address")
            {

            }
            column(Bill_to_Address_2; "Bill-to Address 2")
            {

            }
            column(Bill_to_City; "Bill-to City")
            {

            }
            column(Bill_to_Contact; "Bill-to Contact")
            {

            }
            column(Bill_to_Post_Code; "Bill-to Post Code")
            {

            }
            column(Location_Code; "Location Code")
            {

            }
            column(Posting_Date; "Posting Date")
            {

            }
            column(docNo_; "No.")
            {

            }
            column(Shipment_Date; "Shipment Date")
            {

            }
            column(CompinfoEmail; compinfo."E-Mail")
            {

            }
            column(CompGSTNo; compinfo."GST Registration No.")
            {

            }
            column(Company_Bank_Branch_Code; compinfo."Bank Branch No.")
            {

            }
            column(CompbankNo; Compinfo."Bank Account No.")
            {

            }
            column(compbankName; compinfo."Bank Name")
            {

            }
            column(complogo; compinfo.Picture)
            {

            }
            column(compContact; compinfo."Contact Person")
            {

            }
            column(Document_Date; "Document Date")
            {

            }
            column(Gst; compinfo."GST Registration No.")
            {

            }
            column(purchaseorderno; "Order No.")
            {

            }


            dataitem("Sales Shipment Lines"; "Sales Shipment Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemLinkReference = "Sales Shipment Header";

                column(No_; "No.")
                {

                }
                column(Description; Description)
                {

                }
                column(Quantity; Quantity)
                {

                }
                column(Unit_of_Measure_Code; "Unit of Measure Code")
                {

                }

            }
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
                    field(Bank_account; bank."Bank Account No.")
                    {
                        Lookup = true;
                        ApplicationArea = All;



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
        compinfo.Get();
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
        bank: Record "Bank Account";

}
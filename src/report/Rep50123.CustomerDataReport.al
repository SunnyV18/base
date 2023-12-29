report 50123 "CustomerDataReport"
{
    ApplicationArea = All;
    Caption = 'Report Customer';
    UsageCategory = ReportsAndAnalysis;


    DefaultLayout = RDLC;
    RDLCLayout = 'Report Customer2.rdl';

    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.";

            column(Name; Name)
            {
            }
            column(Address; Address)
            {
            }
            column(Contact; Contact)
            {
            }
            column(Amount; Amount)
            {
            }
            column(Payments; Payments)
            {
            }
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {

                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
}

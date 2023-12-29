report 50100 "Report Customer"
{
    ApplicationArea = All;
    Caption = 'Report Customer';
    UsageCategory = ReportsAndAnalysis;



    DefaultLayout = RDLC;
    RDLCLayout = 'Report Customer.rdl';

    dataset
    {
        dataitem("Customer Data"; "Customer Data")
        {
            RequestFilterFields = "Customer Id";

            column(Customer_Id; "Customer Id")
            {
            }
            column(Customer_Name; "Customer Name")
            {
            }
            column(Customer_ContactNo; "Customer ContactNo")
            {
            }
            column(Customer_Address; "Customer Address")
            {
            }
            column(DATE___TIME; "DATE & TIME")
            {
            }
            column(GST_No; "GST No")
            {
            }
            column(Amount; Amount)
            {
            }
            column(Product_Name; "Product Name")
            {
            }
            // dataitem(DataItemName; SourceTableName)
            // {DataItemLinkReference="Customer Data";
            // DataItemLink=docno= field(no)
            //     column(ColumnName; SourceFieldName)
            //     {

            //     }
            // }
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

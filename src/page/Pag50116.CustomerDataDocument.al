page 50116 "CustomerDataDocument"
{
    PageType = Document;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Customer Data";


    layout
    {
        area(Content)
        {
            group("Customer Information")
            {
                field("Customer Id"; Rec."Customer Id")
                {
                    ApplicationArea = All;

                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;

                }
                field("Customer Address"; Rec."Customer Address")
                {
                    ApplicationArea = All;

                }
                field("Customer ContactNo"; Rec."Customer ContactNo")
                {
                    ApplicationArea = All;

                }
            }
            group("PAYMENT DETAILS")
            {
                field("Payment Type"; Rec."Payment Type")
                {
                    ApplicationArea = All;

                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;

                }
                field("GST No"; Rec."GST No")
                {
                    ApplicationArea = All;

                }
                field("Transcation Id"; Rec."Transcation Id")
                {
                    ApplicationArea = All;

                }
                field("DATE & TIME"; Rec."DATE & TIME")
                {
                    ApplicationArea = All;

                }

            }
            // part(Sales Line;"CustomerData")
            // {
            //     SubPageLink=
            // }

            group("Product Details")
            {



                field("Product Name"; Rec."Product Name")
                {
                    ApplicationArea = All;

                }
                field("Product Type"; Rec."Product Type")
                {
                    ApplicationArea = All;

                }
                field("Sales Person ID"; Rec."Sales Person ID")
                {
                    ApplicationArea = All;

                }
                field("Sales Person Name"; Rec."Sales Person Name")
                {
                    ApplicationArea = All;

                }
                part(SalesLine; "Sales Line Data")

                {
                    SubPageLink = "Customer Id" = FIELD("Customer Id");

                }
            }
            group("Shop Details")
            {
                field("Shop ID"; Rec."Shop ID")
                {
                    ApplicationArea = All;

                }
                field("Shop Name "; Rec."Shop Name ")
                {
                    ApplicationArea = All;

                }
                field("Shop Phone Number"; Rec."Shop Phone Number")
                {
                    ApplicationArea = All;

                }
                field("Shop Address"; Rec."Shop Address")
                {
                    ApplicationArea = All;

                }

            }
            group(Loacation)
            {
                field("Shop Location"; Rec."Shop Location")
                {
                    ApplicationArea = All;

                }
            }

        }
    }

    actions
    {
        area(Processing)
        {
            action("Page Details")
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //Message('Action Done!');

                end;
            }
        }
    }

    var
        myInt: Integer;
}
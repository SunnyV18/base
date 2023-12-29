page 50115 "CustomerDataLine"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Customer Data";
    CardPageId = "CustomerDataDocument";
    // AutoSplitKey=true;


    layout
    {
        area(Content)
        {
            repeater("Information")
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
                    Message('Action Done!');

                end;
            }
        }
    }

    var
        myInt: Integer;
}
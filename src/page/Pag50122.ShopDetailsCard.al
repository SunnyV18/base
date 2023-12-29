page 50122 "ShopDetailsCard"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "ShopDetails";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Shop Name "; Rec."Shop Name ")
                {
                    ApplicationArea = All;

                }
                field("Shop ID"; Rec."Shop ID")
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
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}

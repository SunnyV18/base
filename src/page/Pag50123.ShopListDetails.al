page 50123 "Shop List Details"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "ShopDetails";
    CardPageId = "ShopDetailsCard";

    layout
    {
        area(Content)
        {
            repeater(General)
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

page 50111 MyPage2
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = MyTable;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(City; Rec.City)
                {
                    ApplicationArea = All;

                }
                field("Dep Name"; Rec."Dep Name")
                {
                    ApplicationArea = All;

                }
                field(DOJ; Rec.DOJ)
                {
                    ApplicationArea = All;

                }
                field("Emp code"; Rec."Emp code")
                {
                    ApplicationArea = All;

                }
                field("Emp Name"; Rec."Emp Name")
                {
                    ApplicationArea = All;

                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;

                }
                field(Salary; Rec.Salary)
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
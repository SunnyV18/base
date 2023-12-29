page 50112 MyPage
{
    PageType = List;
    Caption = 'Emp_Data'; //want to see name in frontend 
    ApplicationArea = All; //for display data frontend
    UsageCategory = Lists;// To show as a list in Front end
    SourceTable = MyTable; //Link to Table
    CardPageId = MyPage2; // Link to card page
    Editable = false;// List will not edit and insert data with card
    layout
    {
        area(Content)// three types 1.Content 2.fact box 3.Role Centre
        {
            repeater("Data") // to add data as a list
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
            action(Action1)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Message('Data Is saved ');

                end;
            }
        }
    }

    var
        myInt: Integer;
}
page 50119 CodeUnitpage
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;

    SourceTable = MyTable;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field(ForNum1; Rec.ForNum1)
                {
                    ApplicationArea = All;

                }
                field(ForNum2; Rec.ForNum2)
                {
                    ApplicationArea = All;

                }
                field(ForNum3; Rec.ForNum3)
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
            action(Codeunit1)
            {
                ApplicationArea = All;
                Promoted = true;


                trigger OnAction()
                begin
                    // Mycode.run();
                    // num1 := MyTable.ForNum2 + MyTable.ForNum3 + MyTable.ForNum1;
                    // Message('%1', num1);
                    //Message('ForNum1: %1, ForNum2: %2, ForNum3: %3', MyTable.ForNum1, MyTable.ForNum2, MyTable.ForNum3);

                    num1 := Rec.ForNum2 + rec.ForNum3 + rec.ForNum1;// So Rec work as to retriv the data from the table and pass the value to the page for addition 
                    // Debugging statement to check the result
                    Message('Result: %1', num1);


                end;
            }
        }

    }

    var
        //Mycode: Codeunit MyCodeunit;
        MyTable: Record MyTable;
        num1: Integer;
}
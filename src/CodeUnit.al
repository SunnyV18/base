// codeunit 50118 MyCodeunit
// {
//     trigger OnRun()
//     var
//         MyTable: Record MyTable;
//     begin

//         num1 := MyTable.ForNum2 + MyTable.ForNum3 + MyTable.ForNum1;
// #pragma warning disable AL0126
//         add(MyTable.ForNum2, MyTable.ForNum3, MyTable.ForNum1);
// #pragma warning restore AL0126
//         // Message('%1', num1);

//         // num1 := 12;
//         // num2 := 13;
//         // add(num1, num2);

//     end;

//     procedure add(MyTable: Record MyTable)
//     var
//         tot: Integer;
//     begin
//         num1 := MyTable.ForNum2 + MyTable.ForNum3 + MyTable.ForNum1;
//         Message('Sum of the numbers of %1 and %2  %3=%4', MyTable.ForNum2, MyTable.ForNum3, MyTable.ForNum1, num1);


//     end;


//     var
//         num1: Integer;
//     //         num2: Integer;
// }
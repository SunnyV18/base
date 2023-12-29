tableextension 50143 "GenJournalLineExt2" extends "Gen. Journal Line"
{
    fields
    {
        field(50100; Name; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        // Add changes to table fields here
    }

    var
        myInt: Integer;
}
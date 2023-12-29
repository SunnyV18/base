tableextension 50141 "Cust. Ledger Entry Ext" extends "Cust. Ledger Entry"
{
    fields
    {
        field(50100; Name; Text[50])
        {
            DataClassification = ToBeClassified;
        }

    }

    var
        myInt: Integer;
}
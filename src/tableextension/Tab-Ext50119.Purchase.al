tableextension 50119 "Purchase" extends "Purchase Header"
{
    fields
    {
        field(521; "vendor Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(522; "Vendor Address"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        // Add changes to table fields here
    }

    var
        myInt: Integer;
}
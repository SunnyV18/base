pageextension 50142 MyExtension extends "Customer Ledger Entries"
{
    layout
    {
        addbefore(Description)
        {
            field(Name; Rec.Name)
            {
                ApplicationArea = All;
            }
        }
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}
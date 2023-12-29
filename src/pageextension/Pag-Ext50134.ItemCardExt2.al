pageextension 50134 "Item Card Ext2" extends "Item Card"
{
    layout
    {
        addafter(Description)
        {
            field(Name; rec.Name)
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}
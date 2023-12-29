pageextension 50117 SocialMedia extends "Customer Card"
{
    layout
    {
        addbefore(Address)
        {
            field(facebook; Rec.facebook)
            {
                ApplicationArea = all;
            }
            field(Instagram; Rec.Instagram)
            {
                ApplicationArea = all;
            }
            field(Twitter; Rec.Twitter)
            {
                ApplicationArea = all;
            }
            field(LinkedIn; Rec.LinkedIn)
            {
                ApplicationArea = all;
            }
        }
        addafter(General)
        {
            field("Office Address"; Rec."Office Address")
            {
                ApplicationArea = all;
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
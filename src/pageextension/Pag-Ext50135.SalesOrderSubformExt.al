pageextension 50135 "Sales Order Subform Ext" extends "Sales Order Subform"
{
    layout
    {
        addafter("No.")
        {
            field(Name; Rec.Name)
            {
                ApplicationArea = All;
                // trigger OnLookup()
                // var
                //     myInt: Integer;
                // begin

                // end;
            }
            field(TotalAmt2; Rec.TotalTotal)
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
pageextension 50138 "Sales Order Ext1" extends "Sales order"
{
    layout
    {
        addafter(Status)
        {
            field(TotalAmount; rec.TotalAmount)
            {
                ApplicationArea = All;
                Caption = 'TotalAmount';
                Editable = false;

            }
            field(CGST; CGST)
            {
                ApplicationArea = all;
                Editable = false;

            }
            field(SGST; SGST)
            {
                ApplicationArea = all;
                Editable = false;

            }
            field(NetTotal; rec.GrandTotal)
            {
                ApplicationArea = all;
                Editable = false;




            }
            field(TotalAmt; TotalAmt)
            {
                ApplicationArea = all;
                Editable = false;


            }



        }




    }

    actions //Butoon For Delivery Note
    {
        addlast(processing)
        {
            action("Delivery Note")
            {
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                // RunObject = report 50106;
                trigger OnAction()
                var
                    shimpmentheader: Record "sales Header";

                begin
                    shimpmentheader.Reset();
                    shimpmentheader.SetRange(shimpmentheader."Last Shipping No.", Rec."Last Shipping No.");
                    Report.RunModal(50110, true, true, shimpmentheader);


                end;
            }

        }
    }


    var
        TaxTransactionValue: Record "Tax Transaction Value";
        myInt: Integer;
        RecPurchaseLine: Record "Sales Line";
        RecSalesHeader: Record "Sales Header";

        CGSTRate: Decimal;
        TaxRecordID: RecordId;
        SGSTRate: Decimal;
        CGST: Decimal;
        SGST: Decimal;
        IGST: Decimal;

        TotalCGST: Decimal;
        TotalSGST: Decimal;
        TotalIGST: Decimal;

        IGSTRate: Decimal;
        Total: Decimal;
        TotalAmt: Decimal;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;

    begin


        RecPurchaseLine.Reset();
        // RecPurchaseLine.SetRange("Document Type", "RecSalesHeader"."Document Type");
        RecPurchaseLine.SetRange("Document No.", rec."No.");
        RecPurchaseLine.SetRange("Sell-to Customer No.", rec."Sell-to Customer No.");
        RecPurchaseLine.SetRange("Document Type", rec."Document Type");
        RecPurchaseLine.SetFilter("GST Group Code", '<>%1', '');
        if RecPurchaseLine.FindFirst() then begin
            Total += RecPurchaseLine.Quantity * RecPurchaseLine."Unit Price";
        end;
        //  ClearData();
        if RecPurchaseLine.FindSet() then
            repeat
                TaxRecordID := RecPurchaseLine.RecordId();//NP
                // PurchaseHeaderRecordID := RecPurchaseLine.RecordId();
                //Message('%1', PurchHeaderRecordID);
                TaxTransactionValue.Reset();
                TaxTransactionValue.SetRange("Tax Record ID", TaxRecordID);//Np
                TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);

                TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
                TaxTransactionValue.SetRange("Visible on Interface", true);
                TaxTransactionValue.SetFilter("Value ID", '%1|%2', 6, 2);
                if TaxTransactionValue.FindSet() then begin
                    //repeat
                    CGSTRate := TaxTransactionValue.Percent;
                    SGSTRate := TaxTransactionValue.Percent;
                    CGST += TaxTransactionValue.Amount;
                    SGST += TaxTransactionValue.Amount;
                    // SGSTtxt := 'SGST';
                    // CGSTtxt := 'CGST';
                    TotalCGST += CGST;
                    TotalSGST += SGST;
                end else begin
                    TaxTransactionValue.Reset();
                    TaxTransactionValue.SetRange("Tax Record ID", TaxRecordID);
                    TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
                    TaxTransactionValue.SetFilter("Tax Type", '=%1', 'GST');
                    TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
                    TaxTransactionValue.SetRange("Visible on Interface", true);
                    TaxTransactionValue.SetFilter("Value ID", '%1', 3);
                    if TaxTransactionValue.FindSet() then
                        IGSTRate := TaxTransactionValue.Percent;
                    IGST += TaxTransactionValue.Amount;
                    //IGSTtxt := 'IGST';
                    TotalIGST += IGST;

                END;



            until RecPurchaseLine.Next() = 0;
        TotalAmt := Total + CGST + SGST + IGST;

        GrandTotal1 := TotalAmt;

    end;


    local procedure ClearData()
    Begin
        IGSTRate := 0;
        SGSTRate := 0;
        CGSTRate := 0;
        // SGSTtxt := '';
        // CGSTtxt := '';
        TotalCGST := 0;
        TotalSGST := 0;
        TotalIGST := 0;
        // CGSTtxt := '';
        // IGSTtxt := '';
        IGST := 0;
        CGST := 0;
        SGST := 0;
        clear(TotalAmt);



        //Clear(AmountinWords);


    End;

    var
        GrandTotal1: Decimal;
}


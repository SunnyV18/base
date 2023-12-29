codeunit 50106 "PurchLineCodeUnit"
{
    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", OnAfterValidateNoPurchaseLine, '', false, false)]
    local procedure "Purchase Line_OnAfterValidateNoPurchaseLine"(var PurchaseLine: Record "Purchase Line"; var xPurchaseLine: Record "Purchase Line"; var TempPurchaseLine: Record "Purchase Line" temporary; PurchaseHeader: Record "Purchase Header");
    var
        Qty: Code[10];
    begin
        if PurchaseLine."Document Type" = PurchaseLine."Document Type"::Order then begin
            PurchaseLine.Quantity := 1;
        end
        else
            PurchaseLine.Quantity := 0;

    end;

    var
        myInt: Integer;
}
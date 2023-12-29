tableextension 50106 ItemTracking1 extends "Entry Summary"
{
    fields
    {
        field(10103; Commments; Text[200])
        {
            DataClassification = ToBeClassified;
            // FieldClass = FlowField;
            // CalcFormula = lookup("Reservation Entry".Commments where("Quantity (Base)" = field("Total Quantity")));
            // trigger OnValidate()
            // var
            //     myInt: Integer;
            // begin
            //     CalcFields("Lot No.");

            // end;


        }
        // Add changes to table fields here
    }


    var
        myInt: Integer;
}
tableextension 50102 ItemTracking2 extends "Tracking Specification"

{
    fields
    {
        field(10104; Comments; text[200])
        {
            DataClassification = ToBeClassified;
            // FieldClass = FlowField;
            // CalcFormula = lookup("Entry Summary".Commments where("Lot No." = field("Lot No.")));
            // trigger OnValidate()
            // var
            //     myInt: Integer;
            // begin
            //     CalcFields("Lot No.");

            // end;
        }
        // Add changes to table fields here
    }

    var
        myInt: Integer;
}

pageextension 50107 "ItemTracking3" extends "Item Tracking Summary"
{
    layout
    {
        addafter("Lot No.")
        {
            field(Commments; Rec.Commments)
            {
                ApplicationArea = All;
            }
        }
        // Add changes to page layout here
    }


    var
        myInt: Integer;
}
pageextension 50105 ItemTrackin4 extends "Item Tracking Lines"
{
    layout
    {
        addafter("Lot No.")
        {
            field(Comments; Rec.Comments)
            {
                ApplicationArea = all;
            }
        }
        // Add changes to page layout here
    }


    var
        myInt: Integer;
}

tableextension 50103 ItemTracking7 extends "Reservation Entry"
{
    fields
    {
        field(10103; Commments; Text[200])
        {
            DataClassification = ToBeClassified;


        }
        // Add changes to table fields here
    }


    var
        myInt: Integer;
}
pageextension 50106 ItemTrackin6 extends "Avail. - Item Tracking Lines"
{
    layout
    {
        addafter("Lot No.")
        {
            field(Commments; Rec.Commments)
            {
                ApplicationArea = all;
            }
        }
        // Add changes to page layout here
    }


    var
        myInt: Integer;
}
tableextension 50101 ItemTracking5 extends "Item Journal Line"
{
    fields
    {
        field(10103; Commments; Text[200])
        {
            DataClassification = ToBeClassified;


        }
        // Add changes to table fields here
    }


    var
        myInt: Integer;
}
tableextension 50104 ItemTracking6 extends "Item Ledger Entry"
{
    fields
    {
        field(10106; Commments; Text[200])
        {
            DataClassification = ToBeClassified;


        }
        // Add changes to table fields here
    }


    var
        myInt: Integer;
}
pageextension 50104 ItemTracki98 extends "Item Ledger Entries"
{
    layout
    {
        addafter("Lot No.")
        {
            field(Commments; Rec.Commments)
            {
                ApplicationArea = all;
            }
        }
        // Add changes to page layout here
    }


    var
        myInt: Integer;
}


codeunit 50104 ItemTrackingCodeUnit
{


    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", OnRegisterChangeOnChangeTypeInsertOnBeforeInsertReservEntry, '', false, false)]
    local procedure "Item Tracking Lines_OnRegisterChangeOnChangeTypeInsertOnBeforeInsertReservEntry"(var TrackingSpecification: Record "Tracking Specification"; var OldTrackingSpecification: Record "Tracking Specification"; var NewTrackingSpecification: Record "Tracking Specification"; FormRunMode: Option);
    begin
        ModifyRun := false;
        VarCustomField1 := NewTrackingSpecification."Comments";

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Reserv. Entry", OnAfterSetDates, '', false, false)]
    local procedure "Create Reserv. Entry_OnAfterSetDates"(var ReservationEntry: Record "Reservation Entry");
    begin
        ReservationEntry.Commments := VarCustomField1;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Reserv. Entry", OnCreateReservEntryExtraFields, '', false, false)]
    local procedure "Create Reserv. Entry_OnCreateReservEntryExtraFields"(var InsertReservEntry: Record "Reservation Entry"; OldTrackingSpecification: Record "Tracking Specification"; NewTrackingSpecification: Record "Tracking Specification");
    begin
        InsertReservEntry.Commments := NewTrackingSpecification.Comments;

    end;

    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", OnAfterEntriesAreIdentical, '', false, false)]
    local procedure "Item Tracking Lines_OnAfterEntriesAreIdentical"(ReservEntry1: Record "Reservation Entry"; ReservEntry2: Record "Reservation Entry"; var IdenticalArray: array[2] of Boolean);
    begin
        IdenticalArray[2] := (ReservEntry1.Commments = ReservEntry2.Commments)
    end;

    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", OnAfterCopyTrackingSpec, '', false, false)]
    local procedure "Item Tracking Lines_OnAfterCopyTrackingSpec"(var SourceTrackingSpec: Record "Tracking Specification"; var DestTrkgSpec: Record "Tracking Specification");
    begin
        If ModifyRun = false then begin
            SourceTrackingSpec.Comments := DestTrkgSpec.Comments;
        end else begin
            DestTrkgSpec.Comments := SourceTrackingSpec.Comments;
        end;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", OnAfterMoveFields, '', false, false)]
    local procedure "Item Tracking Lines_OnAfterMoveFields"(var TrkgSpec: Record "Tracking Specification"; var ReservEntry: Record "Reservation Entry");
    begin
        ReservEntry.Commments := TrkgSpec.Comments;
    end;









    var
        myInt: Integer;
        VarCustomField1: Code[20];
        ModifyRun: Boolean;
}
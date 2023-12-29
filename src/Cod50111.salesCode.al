// codeunit 50111 salesCode
// {
//     EventSubscriberInstance = StaticAutomatic;
//     //item name
//     [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnCopyFromItemOnAfterCheck',
//      '', true, true)]
//     local procedure OnCopyFromItemOnAfterCheck(Item: Record Item; var SalesLine: Record "Sales Line")
//     begin
//         SalesLine.Name := Item.Name;
//     end;
//     //posted sales invoice
//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterGetSalesLines', '', true, true)]
//     local procedure OnAfterGetSalesLines(var NewSalesLine: Record "Sales Line"; var SalesHeader: Record "Sales Header"; var TempSalesLineGlobal: Record "Sales Line")
//     begin
//         NewSalesLine.Name := TempSalesLineGlobal.Name;
//     end;

//     [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterCopyGenJnlLineFromCustLedgEntry', '', true, true)]
//     local procedure OnAfterCopyGenJnlLineFromCustLedgEntry(CustLedgerEntry: Record "Cust. Ledger Entry"; var GenJournalLine: Record "Gen. Journal Line")
//     begin 
//        / CustLedgerEntry.Name1 := GenJournalLine.Name1;

//     end;

//     [EventSubscriber(ObjectType::Table, Database::"Sales Invoice Line", 'OnAfterInitFromSalesLine', '', true, true)]
//     local procedure OnAfterInitFromSalesLine(SalesInvHeader: Record "Sales Invoice Header"; SalesLine: Record "Sales Line"; var SalesInvLine: Record "Sales Invoice Line")
//     begin
//         SalesInvLine.Name := SalesLine.Name;
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitCustLedgEntry', '', true, true)]
//     local procedure OnAfterInitCustLedgEntry(GenJournalLine: Record "Gen. Journal Line"; var CustLedgerEntry: Record "Cust. Ledger Entry")
//     begin
//         CustLedgerEntry.Name := GenJournalLine.Name1;
//     end;
//     //salesheader to gen.jnl line
//     [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterCopyGenJnlLineFromSalesHeader', '', true, true)]
//     local procedure OnAfterCopyGenJnlLineFromSalesHeader(SalesHeader: Record "Sales Header"; var GenJournalLine: Record "Gen. Journal Line")
//     begin
//         GenJournalLine.Name1 := SalesHeader.Name1
//     end;
//     //Header to cust.ledger entry
//     [EventSubscriber(ObjectType::Table, Database::"Cust. Ledger Entry", 'OnAfterCopyCustLedgerEntryFromGenJnlLine', '', true, true)]
//     local procedure OnAfterCopyCustLedgerEntryFromGenJnlLine(GenJournalLine: Record "Gen. Journal Line"; var CustLedgerEntry: Record "Cust. Ledger Entry")
//     begin
//         CustLedgerEntry.Name1 := GenJournalLine.Name1
//     end;
//     //lines to 
//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterPostSalesLine', '', true, true)]
//     local procedure OnAfterPostSalesLine(var SalesLine: Record "Sales Line"; var SalesHeader: Record "Sales Header")
//     begin
//         SalesHeader.Name1 := SalesLine.Name;
//     end;

//     //glEntry
//     [EventSubscriber(ObjectType::Table, Database::"G/L Entry", 'OnAfterCopyGLEntryFromGenJnlLine', '', true, true)]
//     local procedure OnAfterCopyGLEntryFromGenJnlLine(var GenJournalLine: Record "Gen. Journal Line"; var GLEntry: Record "G/L Entry")
//     begin
//         GLEntry.Name := GenJournalLine.Name1;
//     end;
//     //detaild.cust.ledge.entry
//     // [EventSubscriber(ObjectType::Table, Database::"Detailed Cust. Ledg. Entry", '', '', true, true)]
//     // local procedure MyProcedure()
//     // begin

//     // end;
// }

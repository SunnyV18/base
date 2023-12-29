// report 50110 "GST-Sales Invoice Domestic Chg"
// {
//     DefaultLayout = RDLC;
//     ApplicationArea = All;
//     UsageCategory = ReportsAndAnalysis;
//     RDLCLayout = './GST-Sales Invoice Domestic Chg.rdl';

//     dataset
//     {
//         dataitem("Sales Invoice Header"; "Sales Invoice Header")
//         {
//             RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
//             column(LocStateDesc; LocStateDesc)
//             {
//             }
//             column(LocAddr; LocAddr)
//             {
//             }
//             column(LocCity; LocCity)
//             {
//             }
//             column(LocGSTRegNo; LocGSTRegNo)
//             {
//             }
//             column(LocName; LocName)
//             {
//             }
//             column(LocStateCode; LocStateCode)
//             {
//             }
//             column(companyInfo_Name; companyInfo.Name)
//             {
//             }
//             column(companyInfo_Address; companyInfo.Address)
//             {
//             }
//             column(companyInfo_Address2; companyInfo."Address 2")
//             {
//             }
//             column(companyInfo_City; companyInfo.City + '-' + companyInfo."Post Code")
//             {
//             }
//             column(companyInfo_State; companyInfo."State Code")
//             {
//             }
//             column(CompanyPicture; companyInfo.Picture)
//             {
//             }
//             column(County; companyInfo.County)
//             {
//             }
//             column(CompanyHomePage; companyInfo."Home Page")
//             {
//             }
//             column(CompanyEmail; companyInfo."E-Mail")
//             {
//             }
//             column(CompanyPhone; companyInfo."Phone No.")
//             {
//             }
//             column(IFSC_CompanyInfo; companyInfo."SWIFT Code")
//             {
//             }
//             column(CompanyFax; companyInfo."Fax No.")
//             {
//             }
//             column(ComGStReg; companyInfo."GST Registration No.")
//             {
//             }
//             column(Com_PAN_No; companyInfo."P.A.N. No.")
//             {
//             }
//             column(Com_Bank_Name; companyInfo."Bank Name")
//             {
//             }
//             column(Com_Bank_Acc_No; companyInfo."Bank Account No.")
//             {
//             }
//             column(BankName_; companyInfo."Bank Name")
//             {
//             }
//             column(VendorItemCode; RecItem."Vendor Item No.")
//             {
//             }
//             column(CompStateCode; CompStateCode)
//             {
//             }
//             column(cust_Name; cust.Name)
//             {
//             }
//             column(cust_Address; cust.Address)
//             {
//             }
//             column(State_Code; cust."State Code")
//             {
//             }
//             column(cust_GST_Registration_No; cust."GST Registration No.")
//             {
//             }
//             column(cust_PAN_No; cust."P.A.N. No.")
//             {
//             }
//             column(SalesShipment_No; SalesShipmentHdr."No.")
//             {
//             }
//             column(SalesPerCode; SalesShipmentHdr."Salesperson Code")
//             {
//             }
//             column(PromoCode_SalesInvoiceHeader; "Sales Invoice Header"."Promo Code")
//             {
//             }
//             column(DispatchDocNo_SalesInvoiceHeader; "Sales Invoice Header"."Dispatch Doc. No.")
//             {
//             }
//             column(DispatchThrough_SalesInvoiceHeader; "Sales Invoice Header"."Dispatch Through")
//             {
//             }
//             column(From_Name; From_Name)
//             {
//             }
//             column(From_Address; From_Address)
//             {
//             }
//             column(FromAddress2; FromAddress2)
//             {
//             }
//             column(From_StateCode; From_StateCode)
//             {
//             }
//             column(From_City; From_City)
//             {
//             }
//             column(From_State; From_State)
//             {
//             }
//             column(From_GSTIN; From_GSTIN)
//             {
//             }
//             column(To_Name; To_Name)
//             {
//             }
//             column(To_Address; To_Address)
//             {
//             }
//             column(ToAddress2; ToAddress2)
//             {
//             }
//             column(To_StateCode; To_StateCode)
//             {
//             }
//             column(To_City; To_City)
//             {
//             }
//             column(To_State; To_State)
//             {
//             }
//             column(To_GSTIN; To_GSTIN)
//             {
//             }
//             column(State; State)
//             {
//             }
//             column(PostingDate_SalesInvoiceHeader; "Sales Invoice Header"."Posting Date")
//             {
//             }
//             column(No_SalesInvoiceHeader; "Sales Invoice Header"."No.")
//             {
//             }
//             column(DeliveryNote_SalesInvoiceHeader; "Sales Invoice Header"."Delivery Note")
//             {
//             }
//             column(AmounttoCustomer_SalesInvoiceHeader; "Sales Invoice Header"."Amount Including VAT")//"Amount to Customer" CCIT
//             {
//             }
//             column(PaymentTermsCode_SalesInvoiceHeader; PayTerm)
//             {
//             }
//             column(AmountInWord; AmountInWord[1])
//             {
//             }
//             column(RemAmt; RemAmt)
//             {
//             }
//             column(companystate; companystate)
//             {
//             }
//             column(To_GSTStateCode; To_GSTStateCode)
//             {
//             }
//             column(From_GSTStateCode; From_GSTStateCode)
//             {
//             }
//             column(PaymentMode; PaymentMode)
//             {
//             }
//             dataitem(CopyLoop; Integer)
//             {
//                 DataItemTableView = SORTING(Number);
//                 dataitem(PageLoop; Integer)
//                 {
//                     DataItemTableView = SORTING(Number)
//                                         WHERE(Number = CONST(1));
//                     column(Title; Title)
//                     {
//                     }
//                     column(BilltoCustNo_SalesInvHdr; "Sales Invoice Header"."Bill-to Customer No.")
//                     {
//                     }
//                     column(Ship_to_Name; "Sales Invoice Header"."Ship-to Name")
//                     {
//                     }
//                     column(Ship_to_Address; "Sales Invoice Header"."Ship-to Address")
//                     {
//                     }
//                     column(DueDate_SalesInvoiceHeader; "Sales Invoice Header"."Due Date")
//                     {
//                     }
//                     column(OrderNo_SalesInvoiceHeader; "Sales Invoice Header"."Order No.")
//                     {
//                     }
//                     column(OrderDate_SalesInvoiceHeader; "Sales Invoice Header"."Order Date")
//                     {
//                     }
//                     column(OutputNo; OutputNo)
//                     {
//                     }
//                     column(PayTerm; PayTerm)
//                     {
//                     }
//                     dataitem("Sales Invoice Line"; "Sales Invoice Line")
//                     {
//                         DataItemLink = "Document No." = FIELD("No.");
//                         DataItemLinkReference = "Sales Invoice Header";
//                         DataItemTableView = SORTING("Document No.", "Line No.");
//                         column(SrNo; "Sr.No")
//                         {
//                         }
//                         column(SerialNo_SalesInvoiceLine; "Sales Invoice Line"."Serial No.")
//                         {
//                         }
//                         column(IMEINo_SalesInvoiceLine; "Sales Invoice Line"."IMEI No.")
//                         {
//                         }
//                         column(Description; "Sales Invoice Line".Description)
//                         {
//                         }
//                         column(Type_SalesInvoiceLine; "Sales Invoice Line".Type)
//                         {
//                         }
//                         column(HSN_SAC_Code; "Sales Invoice Line"."HSN/SAC Code")
//                         {
//                         }
//                         column(Quantity; "Sales Invoice Line".Quantity)
//                         {
//                         }
//                         column(UnitofMeasure; "Sales Invoice Line"."Unit of Measure Code")
//                         {
//                         }
//                         column(Unit_Price; "Sales Invoice Line"."Unit Price")
//                         {
//                         }
//                         column(Amount; "Sales Invoice Line".Amount)
//                         {
//                         }
//                         column(Line_Discount; "Sales Invoice Line"."Line Discount Amount")
//                         {
//                         }
//                         column(GST_Base_Amount; '')//"Sales Invoice Line"."GST Base Amount"
//                         {
//                         }
//                         column(GSTAmt; ABS(GSTAmt))
//                         {
//                         }
//                         column(GSTRate; GSTRate)
//                         {
//                         }
//                         column(IGSTAmt; ABS(IGSTAmt))
//                         {
//                         }
//                         column(CGSTAmt; ABS(CGSTAmt))
//                         {
//                         }
//                         column(SGSTAmt; ABS(SGSTAmt))
//                         {
//                         }
//                         column(CGSTRate; CGSTRate)
//                         {
//                         }
//                         column(IGSTRate; IGSTRate)
//                         {
//                         }
//                         column(SGSTRate; SGSTRate)
//                         {
//                         }
//                         column(GSTComponent; GSTComponent)
//                         {
//                         }
//                         column(TotalGSTAmount_SalesInvoiceLine; '')//"Sales Invoice Line"."Total GST Amount"
//                         {
//                         }
//                         column(TotalInvoiceAmt; TotalInvoiceAmt)
//                         {
//                         }
//                         column(GlbFrtCharge; GlbFrtCharge)
//                         {
//                         }
//                         column(GlbInsCharge; GlbInsCharge)
//                         {
//                         }
//                         column(GlbPackCharge; GlbPackCharge)
//                         {
//                         }
//                         column(CESSAmount_SalesInvoiceLine; '')// "Sales Invoice Line"."CESS Amount"
//                         {
//                         }
//                         column(ItemNo; "Sales Invoice Line"."No.")
//                         {
//                         }
//                         column(GSTComponentCGST; GSTComponentCGST)
//                         {
//                         }
//                         column(GSTComponentSGST; GSTComponentSGST)
//                         {
//                         }
//                         column(GSTComponentIGST; GSTComponentIGST)
//                         {
//                         }

//                         trigger OnAfterGetRecord()
//                         begin


//                             // StructureLineDetails.RESET;//CCIT+++
//                             // StructureLineDetails.SETRANGE(Type, StructureLineDetails.Type::Sale);
//                             // StructureLineDetails.SETRANGE("Document Type", StructureLineDetails."Document Type"::Invoice);
//                             // StructureLineDetails.SETRANGE("Invoice No.", "Document No.");
//                             // StructureLineDetails.SETRANGE("Item No.", "No.");
//                             // StructureLineDetails.SETRANGE("Line No.", "Line No.");
//                             // IF StructureLineDetails.FIND('-') THEN
//                             //     REPEAT
//                             //         IF NOT StructureLineDetails."Payable to Third Party" THEN BEGIN

//                             //             IF StructureLineDetails."Tax/Charge Type" = StructureLineDetails."Tax/Charge Type"::Charges THEN BEGIN

//                             //                 ChargesAmount := ChargesAmount + ABS(StructureLineDetails.Amount);

//                             //                 IF (StructureLineDetails."Tax/Charge Group" = 'FREIGHT') OR
//                             //                    (StructureLineDetails."Tax/Charge Code" = 'FREIGHT') THEN
//                             //                     GlbFrtCharge := GlbFrtCharge + ABS(StructureLineDetails.Amount)


//                             //                 ELSE
//                             //                     IF (StructureLineDetails."Tax/Charge Group" = 'INSURANCE') OR
//                             //                   (StructureLineDetails."Tax/Charge Code" = 'INSURANCE') THEN
//                             //                         // BEGIN
//                             //                         GlbInsCharge := GlbInsCharge + ABS(StructureLineDetails.Amount)
//                             //                     //  MESSAGE(FORMAT(GlbInsCharge));
//                             //                     //  END
//                             //                     ELSE
//                             //                         IF (StructureLineDetails."Tax/Charge Group" = 'PACKING') OR
//                             //                       (StructureLineDetails."Tax/Charge Code" = 'PACKING') THEN
//                             //                             // BEGIN
//                             //                             GlbPackCharge := GlbPackCharge + ABS(StructureLineDetails.Amount)
//                             //                         // MESSAGE(FORMAT(GlbPackCharge));
//                             //                         //  END
//                             //                         ELSE
//                             //                             GlbOtherCharge := GlbOtherCharge + ABS(StructureLineDetails.Amount);
//                             //             END;
//                             //         END;
//                             //     UNTIL StructureLineDetails.NEXT = 0;CCIT-----
//                             //WIN275




//                             //win352++
//                             "Sr.No" += 1;

//                             /*
//                             GSTDetailLeger.RESET;
//                             GSTComponent:='';GSTRate:=0;GSTAmt:=0;
//                             GSTDetailLeger.SETRANGE(GSTDetailLeger."Document No.","Sales Invoice Line"."Document No.");
//                             GSTDetailLeger.SETRANGE(GSTDetailLeger."No.","Sales Invoice Line"."No.");
//                             IF GSTDetailLeger.FINDSET THEN REPEAT
//                                   IF GSTDetailLeger."GST Component Code"='CGST' THEN BEGIN
//                                     GSTComponent:='CGST';
//                                     GSTRate:=GSTDetailLeger."GST %";
//                                     GSTAmt:=GSTDetailLeger."GST Amount";
//                                     END ELSE

//                                  IF GSTDetailLeger."GST Component Code"='SGST' THEN BEGIN
//                                     GSTComponent:='SGST';
//                                     GSTRate:=GSTDetailLeger."GST %";
//                                     GSTAmt:=GSTDetailLeger."GST Amount";
//                                     END  ELSE

//                                   IF GSTDetailLeger."GST Component Code"='IGST' THEN BEGIN
//                                     GSTComponent:='IGST';
//                                     GSTRate:=GSTDetailLeger."GST %";
//                                     GSTAmt:=GSTDetailLeger."GST Amount";
//                                     END;
//                             UNTIL GSTDetailLeger.NEXT=0;
//                             */



//                             GSTDetailLeger.RESET;
//                             GSTDetailLeger.SETRANGE(GSTDetailLeger."Document No.", "Sales Invoice Line"."Document No.");
//                             GSTDetailLeger.SETRANGE(GSTDetailLeger."No.", "Sales Invoice Line"."No.");
//                             IF GSTDetailLeger.FINDSET THEN
//                                 REPEAT
//                                     IF GSTDetailLeger."GST Component Code" = 'CGST' THEN BEGIN
//                                         CLEAR(CGSTRate);
//                                         CLEAR(CGSTAmt);
//                                         CLEAR(GSTComponentCGST);
//                                         GSTComponentCGST := 'CGST';
//                                         CGSTRate := GSTDetailLeger."GST %";
//                                         CGSTAmt := GSTDetailLeger."GST Amount";
//                                     END ELSE
//                                         IF GSTDetailLeger."GST Component Code" = 'SGST' THEN BEGIN
//                                             CLEAR(SGSTRate);
//                                             CLEAR(SGSTAmt);
//                                             CLEAR(GSTComponentSGST);
//                                             GSTComponentSGST := 'SGST';
//                                             SGSTRate := GSTDetailLeger."GST %";
//                                             SGSTAmt := GSTDetailLeger."GST Amount";
//                                         END ELSE
//                                             IF GSTDetailLeger."GST Component Code" = 'IGST' THEN BEGIN
//                                                 CLEAR(IGSTRate);
//                                                 CLEAR(IGSTAmt);
//                                                 CLEAR(GSTComponentIGST);
//                                                 GSTComponentIGST := 'IGST';
//                                                 IGSTRate := GSTDetailLeger."GST %";
//                                                 IGSTAmt := GSTDetailLeger."GST Amount";
//                                             END;
//                                 UNTIL GSTDetailLeger.NEXT = 0;



//                             /*FinalTotal:=FinalTotal+"Sales Invoice Line".Amount+GlbFrtCharge+GlbInsCharge+GlbPackCharge+IGSTAmt+CGSTAmt+SGSTAmt;
//                             ReportCheck.InitTextVariable;
//                             ReportCheck.FormatNoText(AmountInWord,FinalTotal,' ');
//                             */

//                         end;
//                     }
//                 }

//                 trigger OnAfterGetRecord()
//                 begin
//                     IF Number > 1 THEN BEGIN
//                         CopyText := Text16502;
//                         OutputNo += 1;
//                     END;
//                     CurrReport.PAGENO := 1;


//                     //Win 275
//                     IF OutputNo = 1 THEN BEGIN
//                         Title := Text1;
//                         "Sr.No" := 0;
//                         TotAmt := 0;
//                     END;

//                     IF OutputNo = 2 THEN BEGIN
//                         Title := Text2;
//                         "Sr.No" := 0;
//                         TotAmt := 0;
//                     END;

//                     IF OutputNo = 3 THEN BEGIN
//                         Title := Text3;
//                         "Sr.No" := 0;
//                         TotAmt := 0;
//                     END;

//                     /*
//                     IF OutputNo=4 THEN  BEGIN
//                      Title:=Text4;
//                      "Sr.No":=0;
//                      TotAmt:=0;
//                     END;
//                     */

//                 end;

//                 trigger OnPostDataItem()
//                 begin
//                     /*IF NOT CurrReport.PREVIEW THEN
//                       SalesInvCountPrinted.RUN("Sales Invoice Header");
//                       */

//                 end;

//                 trigger OnPreDataItem()
//                 begin
//                     NoOfLoops := ABS(NoOfCopies) + cust."Invoice Copies";
//                     IF NoOfLoops <= 0 THEN
//                         NoOfLoops := 1;
//                     CopyText := '';
//                     SETRANGE(Number, 1, NoOfLoops);
//                     OutputNo := 1;
//                 end;
//             }

//             trigger OnAfterGetRecord()
//             begin


//                 Fromcust.RESET;
//                 Fromcust.SETRANGE(Fromcust."No.", "Sales Invoice Header"."Sell-to Customer No.");
//                 IF Fromcust.FINDFIRST THEN BEGIN
//                     From_Name := Fromcust.Name;
//                     From_Address := Fromcust.Address;
//                     FromAddress2 := Fromcust."Address 2";
//                     From_City := Fromcust.City + ' ' + Fromcust."Post Code";
//                     From_StateCode := Fromcust."State Code";
//                     From_GSTIN := Fromcust."GST Registration No.";

//                 END;

//                 StateRec.RESET;
//                 StateRec.SETRANGE(StateRec.Code, From_StateCode);
//                 IF StateRec.FINDFIRST THEN BEGIN
//                     From_State := StateRec.Description;
//                     From_GSTStateCode := StateRec.Code + ' (' + StateRec."State Code (GST Reg. No.)" + ')';
//                 END;


//                 ToCust.RESET;
//                 ToCust.SETRANGE(ToCust."No.", "Sales Invoice Header"."Bill-to Customer No.");
//                 IF ToCust.FINDFIRST THEN BEGIN
//                     To_Name := ToCust.Name;
//                     To_Address := ToCust.Address;
//                     ToAddress2 := ToCust."Address 2";
//                     To_City := ToCust.City + '  ' + ToCust."Post Code";
//                     To_StateCode := ToCust."State Code";
//                     To_GSTIN := ToCust."GST Registration No.";
//                 END;

//                 StateRec.RESET;
//                 StateRec.SETRANGE(StateRec.Code, To_StateCode);
//                 IF StateRec.FINDFIRST THEN BEGIN
//                     To_State := StateRec.Description;
//                     To_GSTStateCode := StateRec.Code + ' (' + StateRec."State Code (GST Reg. No.)" + ')';
//                 END;

//                 RecItem.RESET;
//                 RecItem.SETRANGE(RecItem."No.", "Sales Invoice Line"."No.");
//                 IF RecItem.FINDFIRST THEN
//                     VendorItemCode := RecItem."Vendor Item No.";
//                 //WIn345 Start
//                 SalesShipmentHdr.RESET;
//                 SalesShipmentHdr.SETRANGE(SalesShipmentHdr."Order No.", "Sales Invoice Header"."Order No.");
//                 IF SalesShipmentHdr.FINDFIRST THEN;
//                 //WIN345 End

//                 RecLoc.RESET;
//                 RecLoc.SETRANGE(RecLoc.Code, "Sales Invoice Header"."Location Code");
//                 IF RecLoc.FINDFIRST THEN BEGIN
//                     LocName := RecLoc.Name;
//                     LocAddr := RecLoc.Address + ' ' + RecLoc."Address 2";
//                     LocCity := RecLoc.City + ' ' + RecLoc."Post Code";
//                     LocState := RecLoc."State Code";
//                     LocGSTRegNo := RecLoc."GST Registration No.";
//                 END;

//                 StateRec.RESET;
//                 StateRec.SETRANGE(StateRec.Code, LocState);
//                 IF StateRec.FINDFIRST THEN BEGIN
//                     LocStateDesc := StateRec.Description;
//                     LocStateCode := StateRec."State Code (GST Reg. No.)";
//                 END;

//                 StateRec.RESET;
//                 StateRec.SETRANGE(StateRec.Code, companyInfo."State Code");
//                 IF StateRec.FINDFIRST THEN BEGIN
//                     companystate := StateRec.Description;
//                     CompStateCode := StateRec.Code + ' (' + StateRec."State Code (GST Reg. No.)" + ')';
//                 END;

//                 ReportCheck.InitTextVariable;
//                 ReportCheck.FormatNoText(AmountInWord, "Sales Invoice Header"."Amount Including VAT", ' ');//"Amount to Customer" CCIT
//                 //ReportCheck.FormatNoText(AmountInWord,FinalTotal,' ');

//                 RecPayTerm.RESET;
//                 RecPayTerm.SETRANGE(RecPayTerm.Code, "Sales Invoice Header"."Payment Terms Code");
//                 IF RecPayTerm.FINDFIRST THEN
//                     PayTerm := RecPayTerm.Description;


//                 RemAmt := 0;
//                 RecCLE.RESET;
//                 RecCLE.SETRANGE(RecCLE."Customer No.", "Sales Invoice Header"."Sell-to Customer No.");
//                 RecCLE.SETRANGE(RecCLE."Document No.", "Sales Invoice Header"."No.");
//                 IF RecCLE.FINDFIRST THEN BEGIN
//                     RecCLE.CALCFIELDS("Remaining Amount");
//                     RemAmt += RecCLE."Remaining Amount";
//                 END;



//                 IF ("Sales Invoice Header".DebitCardNo1 <> '') THEN
//                     DbC1 := 'DbNo: ' + "Sales Invoice Header".PayByDebitCdNo1 + ' Amt: ' + FORMAT("Sales Invoice Header".PayByDebitAmt2);

//                 IF ("Sales Invoice Header".CreditCardNo2 <> '') THEN
//                     CrC1 := 'CrNo: ' + "Sales Invoice Header".PayByCreditNo1 + ' Amt: ' + FORMAT("Sales Invoice Header".PayByCreditAmt1);


//                 IF ("Sales Invoice Header".CreditCardNo2 <> '') THEN
//                     CrC2 := 'CrNo: ' + "Sales Invoice Header".PayByCreditNo2 + ' Amt: ' + FORMAT("Sales Invoice Header".PayByCreditAmt2);

//                 IF ("Sales Invoice Header".CreditCardNo3 <> '') THEN
//                     CrC3 := 'CrNo: ' + "Sales Invoice Header".PayByCreditNo3 + ' Amt: ' + FORMAT("Sales Invoice Header".PayByCreditAmt3);

//                 IF ("Sales Invoice Header".CreditCardNo4 <> '') THEN
//                     CrC4 := 'CrNo: ' + "Sales Invoice Header".PayByCreditNo4 + ' Amt: ' + FORMAT("Sales Invoice Header".PayByCreditAmt4);

//                 PaymentMode += FORMAT(DbC1) + FORMAT(CrC1) + FORMAT(CrC2) + FORMAT(CrC3) + FORMAT(CrC4);
//             end;

//             trigger OnPreDataItem()
//             begin
//                 TotAmt := 0;
//             end;
//         }
//     }

//     requestpage
//     {

//         layout
//         {
//             area(content)
//             {
//                 group(Options)
//                 {
//                     Caption = 'Options';
//                     field(NoOfCopies; NoOfCopies)
//                     {
//                         Caption = 'No. of Copies';
//                         ApplicationArea = All;
//                     }
//                 }
//             }
//         }

//         actions
//         {
//         }
//     }

//     labels
//     {
//     }

//     trigger OnPreReport()
//     begin
//         companyInfo.GET();
//         companyInfo.CALCFIELDS(Picture);
//         "Sr.No" := 0;

//         //StateRec.RESET;

//         StateRec.RESET;
//         StateRec.SETRANGE(StateRec.Code, companyInfo."State Code");
//         IF StateRec.FINDFIRST THEN BEGIN
//             State := StateRec.Description;
//         END;
//     end;

//     var
//         GSTDetailLeger: Record "Detailed GST Ledger Entry";
//         CGSTRate: Decimal;
//         CGSTAmt: Decimal;
//         SGSTAmt: Decimal;
//         SGSTRate: Decimal;
//         IGSTRate: Decimal;
//         IGSTAmt: Decimal;
//         "Sr.No": Integer;
//         companyInfo: Record "Company Information";
//         cust: Record Customer;
//         StateRec: Record State;
//         From_Name: Text[50];
//         From_Address: Text;
//         From_StateCode: Code[20];
//         From_State: Text;
//         From_City: Text;
//         From_GSTIN: Code[20];
//         From_GSTStateCode: Code[10];
//         To_Name: Text[50];
//         To_Address: Text;
//         To_StateCode: Code[20];
//         To_State: Text;
//         To_City: Text;
//         To_GSTStateCode: Code[10];
//         To_GSTIN: Code[20];
//         Fromcust: Record Customer;
//         ToCust: Record Customer;
//         TotalInvoiceAmt: Decimal;
//         ReportCheck: Report Check;
//         AmountInWord: array[2] of Text[200];
//         recSalesInvoiceLine: Record "Sales Invoice Line";
//         recSalesInvoiceHeader: Record "Sales Invoice Header";
//         TotalInvoiceAmt1: Decimal;
//         ChargesAmount: Decimal;
//         GlbInsCharge: Decimal;
//         GlbOtherCharge: Decimal;
//         GlbFrtCharge: Decimal;
//         // StructureLineDetails: Record "Posted Str Order Line Details";CCIT
//         // ServTaxEntry_L: Record "Service Tax Entry";//CCIT
//         GlbPackCharge: Decimal;
//         RecLoc: Record Location;
//         LocName: Text;
//         LocAddr: Text;
//         LocState: Text;
//         LocCity: Text;
//         LocGSTRegNo: Text;
//         LocStateDesc: Text;
//         NoOfCopies: Integer;
//         NoOfLoops: Integer;
//         CopyText: Text[30];
//         OutputNo: Integer;
//         Text16502: Label 'COPY';
//         Text1: Label 'Original for Recipient';
//         Text2: Label 'Duplicate';
//         Text3: Label 'Triplicate';
//         Text4: Label 'Quadruplicate';
//         Title: Text[50];
//         TotAmt: Decimal;
//         SalesShipmentHdr: Record "Sales Shipment Header";
//         RecItem: Record Item;
//         VendorItemCode: Code[20];
//         Freight: Decimal;
//         Insurance: Decimal;
//         Packing: Decimal;
//         FinalTotal: Decimal;
//         GSTComponent: Text;
//         GSTRate: Decimal;
//         GSTAmt: Decimal;
//         RecPayTerm: Record "Payment Terms";
//         PayTerm: Text;
//         GSTComponentCGST: Text;
//         GSTComponentSGST: Text;
//         GSTComponentIGST: Text;
//         FromAddress2: Text;
//         ToAddress2: Text;
//         State: Text;
//         RecCLE: Record "Cust. Ledger Entry";
//         LocStateCode: Code[10];
//         RemAmt: Decimal;
//         companystate: Text;
//         CompStateCode: Code[10];
//         DbC1: Code[50];
//         DbC2: Code[50];
//         DbC3: Code[50];
//         DbC4: Code[50];
//         CrC1: Code[50];
//         CrC2: Code[50];
//         CrC3: Code[50];
//         CrC4: Code[50];
//         PaymentMode: Text;
// }


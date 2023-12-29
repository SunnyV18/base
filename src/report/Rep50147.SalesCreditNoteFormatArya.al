report 50147 "Sales Credit Note Format Arya"

{

    UsageCategory = ReportsAndAnalysis;

    ApplicationArea = All;

    DefaultLayout = RDLC;

    RDLCLayout = 'SalesCreditNoteFormatArya.rdl';

    dataset

    {

        dataitem("Sales Invoice Header"; "Sales Invoice Header")

        {

            DataItemTableView = sorting("No.");

            RequestFilterFields = "No.";

            column(No_; "No.") { }

            column(BilltoName_DataItemName; "Bill-to Name")

            {

            }

            column(BilltoAddress_DataItemName; "Bill-to Address")

            {

            }

            column(BilltoAddress2_DataItemName; "Bill-to Address 2")

            {

            }

            column(BilltoCity_DataItemName; "Bill-to City")

            {

            }

            column(BilltoPostCode_DataItemName; "Bill-to Post Code")

            {

            }

            column(No_DataItemName; "No.")

            {

            }

            column(PostingDate_DataItemName; "Posting Date")

            {

            }

            column(LocationCode_DataItemName; "Location Code")

            {

            }

            column(PaymentTermsCode_DataItemName; "Payment Terms Code")

            {

            }

            column(compName; compinfo.Name) { }

            column(compAddrs1; compinfo.Address) { }

            column(compAddrs2; compinfo."Address 2") { }

            column(compCity; compinfo.City) { }

            column(compSatate; compinfo."State Code") { }

            column(compPAN; compinfo."P.A.N. No.") { }

            column(compGSTNO; compinfo."GST Registration No.") { }



            dataitem("Sales Invoice Line"; "Sales Invoice Line")

            {

                DataItemLinkReference = "Sales Invoice Header";

                DataItemLink = "Document No." = field("No.");

                column(Description_SalesLine; Description)

                {

                }

                column(Quantity_SalesLine; Quantity)

                {

                }

                column(UnitPrice_SalesLine; "Unit Price")

                {

                }

                column(Amount_SalesLine; Amount)

                {

                }

                column(UnitofMeasureCode_SalesLine; "Unit of Measure Code")

                {

                }

                column(HSN_SAC_Code; "HSN/SAC Code") { }

                column(total; total) { }

                column(taxTotal; taxTotal) { }

                column(amountInWordsFinal; amountInWordsFinal) { }

                column(amountInWordsTax; amountInWordsTax) { }

                column(stateDesc; stateDesc) { }

                column(compStatedesc; compStatedesc) { }

                column(CGSTAmount; CGSTAmount) { }

                column(CGSTRate; CGSTRate) { }

                column(SGSTAmount; SGSTAmount) { }

                column(SGSTRate; SGSTRate) { }

                column(IGSTRate; IGSTRate) { }

                column(IGSTAmount; IGSTAmount) { }

                column(billToStatesCode; billToStatesCode) { }

                column(compStateCode; compStateCode) { }

                column(CGSTTotal; CGSTTotal) { }

                column(IGSTTotal; IGSTTotal) { }

                column(TotalAmt; TotalAmt) { }

                column(finalAmt; finalAmt) { }

                column(SGSTTotal; SGSTTotal) { }



                // Posted Sales Line Trigger

                trigger OnAfterGetRecord()

                var

                    myInt: Integer;

                begin

                    //GST calculations

                    Clear(CGSTAmount);

                    Clear(CGSTRate);

                    Clear(SGSTAmount);

                    Clear(SGSTRate);

                    Clear(IGSTAmount);

                    Clear(IGSTRate);

                    Clear(GSTComponentCGST);

                    Clear(GSTComponentIGST);

                    Clear(GSTComponentSGST);

                    Clear(CGSTTotal);

                    Clear(SGSTTotal);

                    Clear(IGSTTotal);



                    "Detailed GST Ledger Entry".Reset();

                    "Detailed GST Ledger Entry".SetRange("No.", "Sales Invoice Line"."No.");

                    "Detailed GST Ledger Entry".SetRange("Document No.", "Sales Invoice Line"."Document No.");

                    "Detailed GST Ledger Entry".SetRange("Document Line No.", "Sales Invoice Line"."Line No.");

                    if "Detailed GST Ledger Entry".FindSet() then
                        repeat

                            if "Detailed GST Ledger Entry"."GST Component Code" = 'CGST' then begin

                                GSTComponentCGST := "Detailed GST Ledger Entry"."GST Component Code";

                                CGSTAmount := abs("Detailed GST Ledger Entry"."GST Amount");

                                CGSTRate := "Detailed GST Ledger Entry"."GST %";

                                //CGSTTotal += CGSTAmount;

                            end

                            else

                                if "Detailed GST Ledger Entry"."GST Component Code" = 'SGST' then begin

                                    GSTComponentSGST := "Detailed GST Ledger Entry"."GST Component Code";

                                    SGSTAmount := abs("Detailed GST Ledger Entry"."GST Amount");

                                    SGSTRate := "Detailed GST Ledger Entry"."GST %";

                                    //SGSTTotal += SGSTAmount;

                                end

                                else

                                    if "Detailed GST Ledger Entry"."GST Component Code" = 'IGST' then begin

                                        GSTComponentIGST := "Detailed GST Ledger Entry"."GST Component Code";

                                        IGSTAmount := abs("Detailed GST Ledger Entry"."GST Amount");

                                        IGSTRate := "Detailed GST Ledger Entry"."GST %";

                                        //IGSTTotal += IGSTAmount;

                                    end;

                        until "Detailed GST Ledger Entry".Next() = 0;

                    TotalAmt := "Line Amount" + CGSTAmount + SGSTAmount + IGSTAmount;

                    finalAmt += TotalAmt;
                    repCheck.InitTextVariable();
                    repCheck.FormatNoText(noText2, finalAmt, ' ');
                    amountInWordsTax := noText[1] + noText[2];





                end;



            }



            //Posted Sales Header trigger

            trigger OnAfterGetRecord()

            var

                myInt: Integer;

            begin









                //------------------ GST  Calculation  //

                // SGST:=0;

                // CGST:=0;

                // IGST:=0;

                // Rate:=0;

                // Rate1:=0;

                // RecRef.OPEN(DATABASE::"Sales Invoice Line");

                // RecRef.SETTABLE(RecPIL);

                // RecPIL.Reset();

                // RecPIL.SetRange("Document No.", "Sales Invoice Header"."No.");

                // RecPIL.SetFilter(RecPIL."GST Group Code", '<>%1', '');

                // if RecPIL.FindSet()then repeat SalesHeaderRecordID:=RecPIL.RECORDID;

                //         //Message('%1', PurchHeaderRecordID);

                //         TaxTransval.Reset();

                //         TaxTransval.SetRange("Tax Record ID", SalesHeaderRecordID);

                //         TaxTransval.SetFilter("Value Type", '=%1', TaxTransval."Value Type"::COMPONENT);

                //         TaxTransval.SetFilter(TaxTransval."Tax Type", '=%1', 'GST');

                //         TaxTransval.SetFilter(Percent, '<>%1', 0);

                //         if TaxTransval.FindSet()then repeat //Message('%1  %2  %3', TaxTransval.ID, TaxTransval.Amount, TaxTransval.Percent);

                //                 IF "Sales Invoice Line"."GST Jurisdiction Type" = "Sales Invoice Line"."GST Jurisdiction Type"::Intrastate THEN BEGIN

                //                     Rate:=TaxTransval.Percent;

                //                     CGST:=TaxTransval.Amount;

                //                     SGST:=TaxTransval.Amount;

                //                 END

                //                 ELSE IF("Sales Invoice Line"."GST Jurisdiction Type" = "Sales Invoice Line"."GST Jurisdiction Type"::Interstate)THEN BEGIN

                //                         Rate1:=TaxTransval.Percent;

                //                         IGST:=TaxTransval.Amount;

                //                     END;

                //             until TaxTransval.Next() = 0;

                //         TotalCGST+=CGST;

                //         TotalSGST+=SGST;

                //         TotalIGST+=IGST;

                //     until RecPIL.Next() = 0;

                // TaxableValue:=0;

                // CentralTaxRate:=0;

                // CentralTaxAmount:=0;

                // StateTaxRate:=0;

                // StateTaxAmount:=0;

                // TotalTaxAmount:=0;

                // HSNSAC:='';

                // HSNCGST:=0;

                // HSNSGST:=0;

                // HSNIGST:=0;

                // HSNRate1:=0;

                // HSNRate2:=0;

                // DGST.Reset();

                // DGST.SetRange("Document No.", "Document No.");

                // DGST.SetRange("Document Line No.", "Line No.");

                // if DGST.Find('-')then repeat HSNSAC:=dgst."HSN/SAC Code";

                //         if(DGST."GST Component Code" = 'CGST') Or (DGST."GST Component Code" = 'SGST')then begin

                //             TaxableValue:=Abs(dgst."GST Base Amount");

                //             HSNRate1:=DGST."GST %";

                //             HSNCGST:=Abs(DGST."GST Amount");

                //             HSNSGST:=Abs(DGST."GST Amount");

                //             CentralTaxRate:=DGST."GST %";

                //             CentralTaxAmount:=Abs(DGST."GST Amount");

                //             StateTaxRate:=DGST."GST %";

                //             StateTaxAmount:=Abs(DGST."GST Amount");

                //             TotalTaxAmount:=TotalTaxAmount + Abs(DGST."GST Amount");

                //             TotalGSTAmount:=TotalGSTAmount + Abs(DGST."GST Amount");

                //         end

                //         else if DGST."GST Component Code" = 'IGST' then begin

                //                 HSNRate2:=DGST."GST %";

                //                 HSNIGST:=Abs(DGST."GST Amount");

                //                 TaxableValue:=ABS(dgst."GST Base Amount");

                //                 CentralTaxRate:=DGST."GST %";

                //                 CentralTaxAmount:=Abs(DGST."GST Amount");

                //                 TotalTaxAmount:=TotalTaxAmount + Abs(DGST."GST Amount");

                //                 TotalGSTAmount:=TotalGSTAmount + Abs(DGST."GST Amount");

                //             end;

                //     until DGST.next = 0;





                // total amount and amount in words

                // salesInvLine.Reset();

                // salesInvLine.SetRange("Document No.", "Sales Invoice Header"."No.");

                // if salesInvLine.FindSet() then begin

                //     repeat

                //         total += salesInvLine.Amount;

                //     until salesInvLine.Next() = 0;

                // end;



                // //tax amount in word

                // taxTotal := CGSTTotal + SGSTTotal + IGSTTotal;



                // repCheck.InitTextVariable();

                // repCheck.FormatNoText(noText, round(taxTotal), '');

                // amountInWordsTax := noText[1] + noText[2];



                // //final amount in words

                // grandTotal := taxTotal + total;



                // repCheck.InitTextVariable();

                // repCheck.FormatNoText(noText2, Round(grandTotal), '');

                // amountInWordsFinal := noText2[1] + noText2[2];



                //bill to state code to state name,code

                // stateRec.Reset();

                // stateRec.SetRange(code, "Sales Invoice Header"."Location State Code");

                // if salesInvHeader.FindFirst() then begin

                //     stateDesc := stateRec.Description;

                //     billToStatesCode := stateRec."State Code (GST Reg. No.)";

                // end;



                //Comp state code to state name

                stateRec.Reset();

                stateRec.SetRange(code, compinfo."State Code");

                if compinfo.FindFirst() then begin

                    compStatedesc := stateRec.Description;

                    compStateCode := stateRec."State Code (GST Reg. No.)";

                end;



                Customer.Reset();

                Customer.SetRange(Customer.Name, "Sales Invoice Header"."Sell-to Customer Name");

                if Customer.FindFirst() then begin

                    stateRec.Reset();

                    stateRec.SetRange(Code, Customer."State Code");

                    if stateRec.FindFirst() then begin

                        stateDesc := stateRec.Description;

                        billToStatesCode := stateRec."State Code (GST Reg. No.)";

                    end;



                end;



            end;





        }

    }



    requestpage

    {

        layout

        {

            area(Content)

            {

                group(GroupName)

                {

                    // field(No_; "Sales Header")

                    // {

                    //     ApplicationArea = All;



                    // }

                }

            }

        }



        actions

        {

            area(processing)

            {

                action(ActionName)

                {

                    ApplicationArea = All;



                }

            }

        }

    }







    trigger OnInitReport()

    var

        myInt: Integer;

    begin

        compinfo.get();

    end;



    var

        myInt: Integer;

        compinfo: Record "Company Information";

        salesInvLine: Record "Sales Invoice Line";

        salesInvHeader: Record "Sales Invoice Header";

        amountInWordsFinal: Text[100];

        amountInWordsTax: Text[100];

        noText: array[2] of Text;

        noText2: array[2] of Text;

        stateRec: Record State;

        stateDesc: Text[50];

        total: Decimal;

        CGSTRate: Decimal;

        CGSTAmount: Decimal;

        SGSTRate: Decimal;

        SGSTAmount: Decimal;

        IGSTRate: Decimal;

        IGSTAmount: Decimal;

        GSTComponentCGST: Code[20];

        GSTComponentSGST: Code[20];

        GSTComponentIGST: Code[20];

        CGSTTotal: Decimal;

        SGSTTotal: Decimal;

        IGSTTotal: Decimal;

        Customer: Record Customer;

        "Detailed GST Ledger Entry": Record "Detailed GST Ledger Entry";

        taxTotal: Decimal;

        repCheck: Report Check;

        compStatedesc: Text[50];

        grandTotal: Decimal;

        "Tax Transaction Value": Record "Tax Transaction Value";

        billToStatesCode: Code[10];

        compStateCode: Code[10];

        finalAmt: Decimal;

        TotalAmt: Decimal;



}


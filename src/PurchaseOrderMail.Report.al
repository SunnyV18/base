// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// Report 50112 "PurchaseOrder Mail"
// {
//     ProcessingOnly = true;
//     UseRequestPage = true;
//     Permissions = tabledata 409 = irmd;

//     dataset
//     {
//         dataitem("Purchase Header"; "Purchase Header")
//         {
//             DataItemTableView = sorting("No.");
//             column(ReportForNavId_1000000000; 1000000000)
//             {
//             }
//             dataitem("Purchase Line"; 39)
//             {
//                 DataItemLink = "Document No." = field("No.");
//                 DataItemTableView = sorting("Document No.", "Line No.");
//                 column(ReportForNavId_1000000001; 1000000001)
//                 {
//                 }

//                 trigger OnAfterGetRecord()
//                 var
//                     vendor: Record 23;
//                 begin
//                     SMTPSetup.Get;
//                     SalesSetup.Get();
//                     //"Purch. Inv. Line".SETRANGE("Document No.","Purch. Inv. Header"."No.");
//                     //purchLine1.SETRANGE("Buy-from Vendor No.","Purchase Header"."Buy-from Vendor No.");
//                     "Purchase Line".SetRange("Purchase Line"."Document Type", "Purchase Line"."document type"::Order);
//                     if "Purchase Line".FindSet then
//                         repeat
//                             if "Purchase Line"."Expected Receipt Date" <> 0D then begin
//                                 if ("Expected Receipt Date" - Today) = 2 then begin
//                                     vendor.Get("Purchase Line"."Buy-from Vendor No.");
//                                     if vendor."E-Mail" = '' then
//                                         exit;
//                                     MailSubject := 'Purchase Order Expected Recieipt Date  Notification';
//                                     BodyText := '<b>' + '</b>' + 'Dear Sir/Madam,' + '<br>';
//                                     SMTP.CreateMessage('E-Mail Admin', SMTPSetup."User ID", vendor."E-Mail", MailSubject, BodyText, true);
//                                     // IF SalesSetup."Email ID CC" <> '' THEN
//                                     // AddCC(SalesSetup."Email ID CC");
//                                     //SMTP.AddCC('it@kwalityspices.com');
//                                     SMTP.AddCC('purchase@kwalityspices.com');
//                                     SMTP.AddCC('purchase.asst@kwalityspices.com');
//                                     SMTP.AppendBody('<br>');
//                                     SMTP.AppendBody('<br>');
//                                     SMTP.AppendBody('<table border="1">');
//                                     SMTP.AppendBody('<tr>');
//                                     SMTP.AppendBody('<th>PO.No</th>');
//                                     SMTP.AppendBody('<th>Date</th>');
//                                     SMTP.AppendBody('<th>Item No.</th>');
//                                     SMTP.AppendBody('<th>Item Name</th>');
//                                     SMTP.AppendBody('<th>Quantity</th>');
//                                     SMTP.AppendBody('<th>UOM</th>');
//                                     SMTP.AppendBody('<th>Expected Date</th>');
//                                     SMTP.AppendBody('</tr>');

//                                     SMTP.AppendBody('<tr><td><Center>' + "Purchase Header"."No." + '</Center></td>');
//                                     SMTP.AppendBody('<td><Center>' + Format(WorkDate) + '</Center></td>');
//                                     SMTP.AppendBody('<td><Center>' + "Purchase Line"."No." + '</Center></td>');
//                                     SMTP.AppendBody('<td><Center>' + Format("Purchase Line".Description) + '</Center></td>');
//                                     SMTP.AppendBody('<td><Center>' + Format("Purchase Line".Quantity) + '</Center></td>');
//                                     SMTP.AppendBody('<td><Center>' + "Purchase Line"."Unit of Measure Code" + '</Center></td>');
//                                     SMTP.AppendBody('<td>' + Format(Date2dmy("Purchase Line"."Expected Receipt Date", 1)) + '-' + Format(Date2dmy("Purchase Line"."Expected Receipt Date", 2)) + '-' + Format(Date2dmy("Purchase Line"."Expected Receipt Date", 3)) + '</td>');
//                                     PrintTotal := true;

//                                     if PrintTotal then begin
//                                         SMTP.AppendBody('</table>');
//                                         SMTP.AppendBody('<br>' + 'Kindly refer to the above PO No. where you are supposed to dispatch the Materials as per the Schedule given in the PO.' + '</br>');
//                                         SMTP.AppendBody('<br>');
//                                         SMTP.AppendBody('<br>' + 'Please do provide us the Confirmation of Dispatch as per PO inputs and share the below Documents for us to have a track of the upcoming consignment at your end :' + '</br>');
//                                         SMTP.AppendBody('<br>' + '1) Invoice No. and details.' + '<br>');
//                                         SMTP.AppendBody('<br>' + '2) Packing List and details.' + '<br>');
//                                         SMTP.AppendBody('<br>' + '3) COA and details.' + '<br>');
//                                         SMTP.AppendBody('<br>' + '4) LR Details.' + '</br>');
//                                         SMTP.AppendBody('<br>' + '5) Transporter name and details.' + '</br>');
//                                         SMTP.AppendBody('<br>' + '6) Driver name and Details.' + '</br>');
//                                         SMTP.AppendBody('<br>' + '7) Freight is Prepaid/ TO BE PAID.' + '</br>');
//                                         SMTP.AppendBody('<br>' + '8) Expected Date of Arrival.' + '</br>');
//                                         SMTP.AppendBody('<br>' + '9) Remarks.' + '</br>');
//                                         SMTP.AppendBody('<br>' + 'Kindly do share all the above inputs and ensure the dispatch is done as per requested Delivery Schedule at our end.' + '</br>');
//                                         SMTP.AppendBody('<br><br><br>');
//                                         SMTP.AppendBody('<b>Thanks And Regards,</b><br><br>');
//                                         SMTP.AppendBody('<b>Pagariya Food Products (P) Ltd. </b><br>');
//                                         SMTP.Send;
//                                     end;
//                                 end;
//                                 //UNTIL NEXT = 0;//
//                             end;
//                         until "Purchase Line".Next = 0;
//                 end;
//             }
//         }
//     }

//     requestpage
//     {

//         layout
//         {
//         }

//         actions
//         {
//         }
//     }

//     labels
//     {
//     }

//     var
//         SalesSetup: Record 311;
//         Vendor: Record 23;
//         SMTPMailSetup: Record 09;
//         Mail: dotnet SmtpMessage;
//         MailBody: Text;
//         SMTP: Codeunit Smtp;
//         SMTPSetup: Record smtp;
//         MailSubject: Text;
//         BodyText: Text;
//         PrintTotal: Boolean;
//         Text001: label 'The email address "%1" is invalid.';
//         Text002: label 'Attachment %1 does not exist or can not be accessed from the program.';
//         Text003: label 'The SMTP mail system returned the following error: "%1".';
//         SendResult: Text;
//         purchLine1: Record 39;
// }


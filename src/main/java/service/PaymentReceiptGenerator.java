package service;

import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.PDPageContentStream;
import org.apache.pdfbox.pdmodel.font.PDType1Font;

import java.io.ByteArrayOutputStream;
import java.io.IOException;

import model.Payment;

public class PaymentReceiptGenerator {

    public static void generatePaymentReceiptPdf(Payment payment, ByteArrayOutputStream byteArrayOutputStream) {
        // Create a new document
        try (PDDocument document = new PDDocument()) {
            PDPage page = new PDPage();
            document.addPage(page);

            try (PDPageContentStream contentStream = new PDPageContentStream(document, page)) {

                // Begin writing to the content stream
                contentStream.beginText();
                contentStream.setFont(PDType1Font.HELVETICA_BOLD, 16);
                contentStream.newLineAtOffset(100, 750);
                contentStream.showText("Payment Receipt");
                contentStream.endText();

                // Set font for the body content
                contentStream.setFont(PDType1Font.HELVETICA, 12);
                contentStream.beginText();
                contentStream.newLineAtOffset(100, 700);
                contentStream.showText("Payment ID: " + payment.getPaymentId());
                contentStream.newLineAtOffset(0, -20);
                contentStream.showText("Full Name: " + payment.getFullname());
                contentStream.newLineAtOffset(0, -20);
                contentStream.showText("Email: " + payment.getEmail());
                contentStream.newLineAtOffset(0, -20);
                contentStream.showText("Amount Due: $" + payment.getAmountDue());
                contentStream.newLineAtOffset(0, -20);
                contentStream.showText("Amount Paid: $" + payment.getAmountPaid());
                contentStream.newLineAtOffset(0, -20);
                contentStream.showText("Due Date: " + payment.getDueDate());
                contentStream.newLineAtOffset(0, -20);
                contentStream.showText("Payment Date: " + payment.getPaymentDate());
                contentStream.newLineAtOffset(0, -20);
                contentStream.showText("Thank you for your payment!");
                contentStream.endText();

            } catch (IOException e) {
            }

            // Save the document to the ByteArrayOutputStream (in memory)
            document.save(byteArrayOutputStream);
        } catch (IOException e) {
        }
    }
}

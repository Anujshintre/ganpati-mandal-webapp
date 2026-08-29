package com.mandal.util;

/**
 * STUB - Real WhatsApp delivery requires a WhatsApp Business API account
 * (Meta Cloud API or a provider like Twilio/Gupshup) with approved
 * message templates, since WhatsApp does not allow sending files from a
 * plain personal number via code.
 *
 * This class isolates that integration point so it's a single place to
 * plug in the real API call later without touching servlet logic.
 *
 * Example (Meta Cloud API) shape you would implement here:
 *   POST https://graph.facebook.com/v19.0/{phone-number-id}/messages
 *   Authorization: Bearer {permanent-access-token}
 *   body: { messaging_product: "whatsapp", to: whatsappNumber,
 *           type: "document", document: { link: publicPdfUrl, filename: ... } }
 */
public class WhatsAppSender {

    public static boolean sendReceipt(String whatsappNumber, String pdfPathOnServer, String mandalName) {
        // TODO: integrate real WhatsApp Business API call here.
        System.out.println("[WhatsAppSender-STUB] Would send " + pdfPathOnServer
                + " to " + whatsappNumber + " on behalf of " + mandalName
                + " -- plug in real WhatsApp Business API credentials to make this live.");
        return true; // pretend success so the rest of the flow can be tested end-to-end
    }
}

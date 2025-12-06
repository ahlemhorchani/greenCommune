package util;

public class NotificationSender {

    public static void sendNotification(String email, String subject, String message) {
        // Ici tu peux connecter à un service de messagerie (SMTP), mais pour l'instant on simule.
        System.out.println("=== Notification envoyée ===");
        System.out.println("À : " + email);
        System.out.println("Sujet : " + subject);
        System.out.println("Message : " + message);
        System.out.println("============================");
    }

}

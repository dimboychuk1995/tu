/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package ua.ifr.oe.tc.list;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;

public class MailSender {

    public static void sendEmail(String to, String from, String subject, String text, String smtpHost) {
        try {
            Properties properties = new Properties();
            properties.put("mail.smtp.host", smtpHost);
            Session emailSession = Session.getDefaultInstance(properties);

            MimeMessage emailMessage = new MimeMessage(emailSession);
            emailMessage.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
            //emailMessage.addRecipient(Message.RecipientType.CC, new InternetAddress(cc));
            emailMessage.setFrom(new InternetAddress(from));
            emailMessage.setSubject(subject, "UTF-8");
            emailMessage.setText(text, "UTF-8");

            emailSession.setDebug(true);

            Transport.send(emailMessage);
        } catch (AddressException e) {
            e.printStackTrace();
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }

    public static void sendHTMLEmail(String to, String from, String subject, String content, String host) {

        // Get system properties
        Properties properties = System.getProperties();

        // Setup mail server
        properties.setProperty("mail.smtp.host", host);

        // Get the default Session object.
        Session session = Session.getDefaultInstance(properties);

        try {
            // Create a default MimeMessage object.
            MimeMessage message = new MimeMessage(session);

            // Set From: header field of the header.
            message.setFrom(new InternetAddress(from));

            // Set To: header field of the header.
            message.addRecipient(Message.RecipientType.TO,
                    new InternetAddress(to));

            // Set Subject: header field
            message.setSubject(subject,"windows-1251");

            // Send the actual HTML message, as big as you like
            message.setContent(content, "text/html; charset=windows-1251");

            // Send message
            Transport.send(message);
            System.out.println("Sent message successfully....");
        } catch (MessagingException mex) {
            mex.printStackTrace();
        }
    }
}

package com.fresh.FreshApp.utils;

import java.io.InputStream;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class EmailUtils {

    public static void sendEmail(String to, String subject, String content) throws Exception {
        Properties prop = new Properties();
        InputStream is = EmailUtils.class.getClassLoader().getResourceAsStream("email.properties");
        prop.load(is);
        String emailEnabled = prop.getProperty("enabled");
        if (emailEnabled != null && emailEnabled.equalsIgnoreCase("true")) {
            prop.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");

            Session session = Session.getInstance(prop,
                    new javax.mail.Authenticator() {
                        protected PasswordAuthentication getPasswordAuthentication() {
                            return new PasswordAuthentication(prop.getProperty("username"),
                                    prop.getProperty("password"));
                        }
                    });
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(prop.getProperty("from")));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject(subject);
            // message.setText("");
            message.setContent(content, "text/html");
            Transport.send(message);
        }
    }

}

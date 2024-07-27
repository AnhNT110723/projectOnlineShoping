/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;
import java.util.Random;
/**
 *
 * @author Anh hung
 */
public class SendMail {

        public static void send(String to, String sub, String msg, final String user, final String pass) {
            //Cài đặt cấu hình cho SMTP server của Gmail:
            Properties props = new Properties();
            props.put("mail.smtp.host", "smtp.gmail.com");
            props.put("mail.smtp.port", "587");
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");

            //Tạo phiên gửi email:
            Session session = Session.getInstance(props, new javax.mail.Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(user, pass);
                }
            });
            //Tạo và gửi email:
            try {
                MimeMessage message = new MimeMessage(session);
                message.setFrom(new InternetAddress(user));
                message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
                message.setSubject(sub);
                message.setContent(msg, "text/html");
                Transport.send(message);
                System.out.println("Email sent successfully");
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        public static void main(String[] args) {
            String email = "tanhh244466666@gmail.com";
            String password = "cdsppymuqbmstijr";
            String subject = "Hi";
            Random code = new Random();
            int OTP = code.nextInt(999999);
            String message = "<!DOCTYPE html>\n"
                    + "<html lang=\"en\">\n"
                    + "<h1>This is your code:</h1>"
                    + "</br>"
                    + "<h2>" + OTP + "</h2>"
                    + "</html>\n";
            SendMail.send("Huyen@qo.com", subject, message, email, password);
        }

    }

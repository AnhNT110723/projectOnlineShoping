using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Net;
using System.Text;
using System.Threading.Tasks;
using System.Windows;

namespace QuanLiNhaHang.Utils
{
    public class SendToEmail
    {
        public static string randomOTP()
        {
            string s = "qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM1234567890";
            StringBuilder sb = new StringBuilder();
            Random random = new Random();
            char[] chars = s.ToCharArray();
            for (int i = 0; i < 8; i++)
            {
                sb.Append(chars[random.Next(0, chars.Length)]);
            }
            return sb.ToString();
        }
        public static void SendEmail(string toEmail, string content, string Subject)
        {
            try
            {
                MailMessage mail = new MailMessage();

                mail.From = new MailAddress("tanhh244466666@gmail.com", "Nguyen Tuan Anh");

                mail.To.Add(toEmail);

                mail.Subject = Subject;

                mail.Body = content;

                mail.IsBodyHtml = false;

                //cấu hình cho email
                SmtpClient smtpClient = new SmtpClient("smtp.gmail.com");
                smtpClient.Port = 587;
                smtpClient.UseDefaultCredentials = false;
                smtpClient.Credentials = new NetworkCredential("tanhh244466666@gmail.com", "cdsppymuqbmstijr");
                smtpClient.EnableSsl = true;


                smtpClient.Send(mail);
            }
            catch (SmtpException smtpEx)
            {
                MessageBox.Show($"SMTP Error: {smtpEx.Message}");
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Error sending email: {ex.Message}");
            }
        }
    }
}

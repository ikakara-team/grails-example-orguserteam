package ikakara.exampleout.platform

import static org.springframework.util.StringUtils.hasText

import org.springframework.context.ApplicationContext
import org.springframework.context.ApplicationContextAware

import grails.util.Holders

import ikakara.awsinstance.EmailException
import ikakara.awsinstance.command.EmailCommand

public class EmailService implements ApplicationContextAware {

  static transactional = false

  def awsEmailService

  ApplicationContext applicationContext

  static String HTML_TEMPLATE = '''
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns="http://www.w3.org/1999/xhtml">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <meta name="viewport" content="width=device-width" />
</head>
<body>
  <p>Hello ${name}!</p>
  <br/>
  <p>You have been invited to join ${joinTitle} by ${invitedBy}.  Click the link, ${joinUrl}, sign-up and/or sign-in and join!</p>
  <br/>
  <p>The ExampleOUT Team.</p>
<p><img src="" width="166" height="44" /></p>
</body>
</html>
  '''

  static String TEXT_TEMPLATE = '''
Hello ${name}!

You have been invited to join ${joinTitle} by ${invitedBy}.  Click the link, ${joinUrl}, sign-up and/or sign-in and join!

The ExampleOUT Team.
  '''

  public void sendInvitation(EmailCommand email, String name, String joinTitle, String joinUrl, String invitedBy) {
    String subject = "ExampleOUT Invitation!";
    def binding = [subject: subject, name:name, joinTitle:joinTitle, joinUrl:joinUrl, invitedBy: invitedBy]

    email.withSubject(subject).withText(TEXT_TEMPLATE, binding).withHtml(HTML_TEMPLATE, binding)
    try {
      log.warn("Sending invite message to ${email.to}")
      awsEmailService.send(email)
    } catch(EmailException e) {
      log.error("Exception while sending invite message: " + e.message);
    }
  }

}

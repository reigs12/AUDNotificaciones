package com.bolsadeideas.springboot.app.utils;

import java.io.UnsupportedEncodingException;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class Correo {
	Properties props = new Properties();
	public void configuracion() {
		Session session;
		MimeMessage message;
		Transport t;
		try {
			// Nombre del host de correo, es smtp.gmail.com
			
			//props.setProperty("mail.smtp.host", "smtp.gmail.com");
//			props.put("mail.smtp.ssl.trust", "*");
			
			// TLS si está disponible
			props.setProperty("mail.smtp.starttls.enable", "true");

			// Puerto de gmail para envio de correos
			props.setProperty("mail.smtp.port","587");

			// Nombre del usuario
			props.setProperty("mail.smtp.user", "reigs12@gmail.com");

			// Si requiere o no usuario y password para conectarse.
			props.setProperty("mail.smtp.auth", "true");
			
			props.put("mail.smtp.starttls.required", "true");
			props.put("mail.smtp.ssl.protocols", "TLSv1.2");
			
			session = Session.getDefaultInstance(props);
			session.setDebug(true);
			session.getProperties().put("mail.smtp.ssl.trust", "smtp.gmail.com");
			session.getProperties().put("mail.smtp.starttls.enable", "true");
			
			
			message = new MimeMessage(session);
			// Quien envia el correo
			message.setFrom(new InternetAddress("reigs12@gmail.com"));
			// A quien va dirigido
			message.addRecipient(Message.RecipientType.TO, new InternetAddress("reinaldoguarin.guarin@cgi.com"));
			message.setSubject("Hola");
			message.setText("Mensajito con Java Mail" + "de los buenos." + "poque si");
			t = session.getTransport("smtp");
			System.out.println("paso2");
			t.connect("reigs12@gmail.com","tatis1452rgs%");
			System.out.println("paso3");
			t.sendMessage(message,message.getAllRecipients());
			System.out.println("paso4");
		} catch (AddressException e) {
			System.out.println(e.getMessage());
		} catch (MessagingException e) {
			System.out.println(e.getMessage());
			e.printStackTrace();
			
			
		}/* catch (UnsupportedEncodingException e) {
			System.out.println(e.getMessage());
		}*/
		/*catch (Exception e) {
			  System.out.println(e.getMessage());
		}*/
	}
}
/*	
//	Session session = Session.getDefaultInstance(props, null);

	
//	public Correo() {
	//	super();
	//}
	
	try {
		// Nombre del host de correo, es smtp.gmail.com
		props.setProperty("mail.smtp.host", "smtp.gmail.com");

		// TLS si está disponible
		props.setProperty("mail.smtp.starttls.enable", "true");

		// Puerto de gmail para envio de correos
		props.setProperty("mail.smtp.port","587");

		// Nombre del usuario
		props.setProperty("mail.smtp.user", "reigs@gmail.com");

		// Si requiere o no usuario y password para conectarse.
		props.setProperty("mail.smtp.auth", "true");
	/*  Message msg = new MimeMessage(session);
	  msg.setFrom(new InternetAddress("admin@example.com", "Example.com Admin"));
	  msg.addRecipient(Message.RecipientType.TO,
	                   new InternetAddress("user@example.com", "Mr. User"));
	  msg.setSubject("Your Example.com account has been activated");
	  msg.setText("This is a test");
	  Transport.send(msg);
	} catch (AddressException e) {
	  // ...
	} catch (MessagingException e) {
	  // ...
	*///} catch (UnsupportedEncodingException e) {
	  // ...
	//}

//}


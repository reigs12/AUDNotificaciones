package com.bolsadeideas.springboot.app.utils;
import java.util.*;
import javax.mail.*;
import javax.mail.internet.*;
import javax.mail.Session;
import javax.mail.Transport;

public class Email {
	  /*public static void main(String[] args) {
	    //ANTES DE EJECUTARLO CAMBIA ESTOS VALORES 
	    //Y CAMBIA EL REMITENTE Y LA CLAVE DE APLICACIÓN EN LA FUNCIÓN enviarConGMail
	    
		 Email email = new Email();
	    //A quién le quieres escribir.
	    String destinatario =  "reigs@hotmail.com";
	    String asunto = "Correo de prueba enviado desde Java";
	    String cuerpo = "Esta es una prueba de correo...";
	    //Envio de correo
	    email.enviarConGMail(destinatario, asunto, cuerpo);
	    System.out.println("¡Correo enviado!");
	  }*/

	  public void enviarConGMail(String destinatario, String asunto, String cuerpo) {
	    //La dirección de correo de envío
	    String remitente = "reigs12@gmail.com";
	    //La clave de aplicación obtenida según se explica aquí:
	    //https://www.campusmvp.es/recursos/post/como-enviar-correo-electronico-con-java-a-traves-de-gmail.aspx
	    String claveemail = "grxbfwhudafkszyx";

	    Properties props = System.getProperties();
	    props.put("mail.smtp.host", "smtp.gmail.com");  //El servidor SMTP de Google
	    props.put("mail.smtp.user", remitente);
	    props.put("mail.smtp.clave", claveemail);    //La clave de la cuenta
	    props.put("mail.smtp.auth", "true");    //Usar autenticación mediante usuario y clave
	    props.put("mail.smtp.starttls.enable", "true"); //Para conectar de manera segura al servidor SMTP
	    props.put("mail.smtp.port", "587"); //El puerto SMTP seguro de Google

	    Session session = Session.getDefaultInstance(props);
	    MimeMessage message = new MimeMessage(session);

	    try {
	        message.setFrom(new InternetAddress(remitente));
	        message.addRecipient(Message.RecipientType.TO, new InternetAddress(destinatario));   //Se podrían añadir varios de la misma manera
	        message.setSubject(asunto);
	        message.setText(cuerpo);
	        Transport transport = session.getTransport("smtp");
	        transport.connect("smtp.gmail.com", remitente, claveemail);
	        transport.sendMessage(message, message.getAllRecipients());
	        transport.close();
	      System.out.println("Mensaje envado");
	    }
	    catch (MessagingException me) {
	        me.printStackTrace();   //Si se produce un error
	    }
	  }
	}
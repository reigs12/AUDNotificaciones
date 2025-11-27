package com.bolsadeideas.springboot.app.models.service;
import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Date;
import java.util.concurrent.CompletableFuture;

import org.json.JSONObject;
import org.springframework.core.io.ClassPathResource;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import com.google.firebase.messaging.FirebaseMessaging;
import com.google.firebase.messaging.Message;
import com.google.firebase.messaging.Notification;


@Service
public class PrecioServiceImp implements IPrecioService {

	@Async
	public CompletableFuture<String> monitorearPrecio()  {
		double valorAud=0.0;
		Date hora;
		try {
			 InputStream serviceAccount = new ClassPathResource("audnotificaciones.json").getInputStream();	
		     FirebaseOptions options = FirebaseOptions.builder()
		              .setCredentials(GoogleCredentials.fromStream(serviceAccount))
		              .build();
		      FirebaseApp.initializeApp(options);		     
		     
		      System.out.println("TrustStore usado: " + System.getProperty("javax.net.ssl.trustStore"));
		     // for(int x=0; x<60; x++) {	    	
	            String deviceToken = "eosCvtvlSlq0HHmDdRT2Pw:APA91bEAF11MSImkIvtOUJt4NJEzhtKDVvBR49RBb9fLLACja-feJ5TuO3oV0lf0OzfiEJnJPlP_h9Z-mCXaV3BW-6pLaZqe-M5sf9U9kMoAgEdslMmUedI";
	            System.out.println("Respuesta de la API:");
	            valorAud=getPrecioAUD();
	            hora = new Date();
	            //System.out.println(x + ".  "+hora +"--valor actual:" + valorAud);
	            System.out.println(".  "+hora +"--valor actual:" + valorAud);
	           // if(valorAud>0.66 || valorAud<0.6528) {
			        Message message = Message.builder()
			              .setToken(deviceToken)
			              .setNotification(
			                      Notification.builder()
			                              .setTitle("Alerta de precio AUD")
			                              .setBody("AUD esta valiendo " + valorAud)
			                              .build()
			              )
			              .build();
		      
			      String response = FirebaseMessaging.getInstance().send(message);
			      System.out.println("Push enviado: " + response);
			      System.out.println("Push enviado: " );
	        //    }
	           // Thread.sleep(60000L);
		      //}
		}
		catch (Exception e) {
		    	  
		}
		return CompletableFuture.completedFuture("termina el monitoreo");
	}
	public double getPrecioAUD() {
		try {
			String url = "https://api.twelvedata.com/quote?symbol=AUD/USD&apikey=43504d20b93e4ae9b452a00716ece3f5";
	        URL apiUrl = new URL(url);
	        HttpURLConnection connection = (HttpURLConnection) apiUrl.openConnection();
	        connection.setRequestMethod("GET");
	        connection.setConnectTimeout(10000);
	        connection.setReadTimeout(10000);
	        int status = connection.getResponseCode();
			BufferedReader reader = new BufferedReader(
	                new InputStreamReader(
	                        status > 299 ? connection.getErrorStream() : connection.getInputStream()
	                )
	        );
			String line;
            StringBuilder response = new StringBuilder();

            while ((line = reader.readLine()) != null) {
                response.append(line);
            }
            reader.close();
            JSONObject json = new JSONObject(response.toString());
            String symbol = json.optString("symbol");
            String name = json.optString("name");
            double price = json.optDouble("price");
            double open = json.optDouble("open");
            double high = json.optDouble("high");
            double low = json.optDouble("low");
            double close = json.optDouble("close");
            //System.out.println("valor actual:" + close);
            //return response.toString();
            return close;
		}
		 catch (Exception e) {
	            e.printStackTrace();
	            return 0.0;
	    }	
	}
	
 }

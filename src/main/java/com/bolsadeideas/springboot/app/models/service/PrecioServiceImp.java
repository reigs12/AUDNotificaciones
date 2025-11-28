package com.bolsadeideas.springboot.app.models.service;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Date;
import java.util.List;
import java.util.concurrent.CompletableFuture;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bolsadeideas.springboot.app.models.dao.IHistoricoPrecioDao;
import com.bolsadeideas.springboot.app.models.dao.INotificacionDao;
import com.bolsadeideas.springboot.app.models.dto.MonitoreoPrecioDto;
import com.bolsadeideas.springboot.app.models.entity.HistoricoPrecio;
import com.bolsadeideas.springboot.app.models.entity.Notificacion;
import com.google.firebase.messaging.FirebaseMessaging;
import com.google.firebase.messaging.FirebaseMessagingException;
import com.google.firebase.messaging.Message;
import com.google.firebase.messaging.Notification;


@Service
public class PrecioServiceImp implements IPrecioService {	
	
	@Autowired
	private IHistoricoPrecioDao historicoPrecioDao;
	
	@Autowired
	private INotificacionDao notificacionDao;
	
	public MonitoreoPrecioDto monitorearPrecio() {
		MonitoreoPrecioDto monitoreoprecio=null;
		Date hora=new Date();
		try {    	
	            //String deviceToken = "eosCvtvlSlq0HHmDdRT2Pw:APA91bEAF11MSImkIvtOUJt4NJEzhtKDVvBR49RBb9fLLACja-feJ5TuO3oV0lf0OzfiEJnJPlP_h9Z-mCXaV3BW-6pLaZqe-M5sf9U9kMoAgEdslMmUedI";
	            System.out.println("Respuesta de la API:");
	            monitoreoprecio=getPrecioAUD();
	            hora = new Date();
	            System.out.println(".  "+hora +"--valor actual:" + monitoreoprecio.getPrecioActual() + "---diferencia:"+monitoreoprecio.getDiferencia());
	            //Revision de las notificaciones
	            List<Notificacion> notificaciones=notificacionDao.findByEstado("C");
	            for(Notificacion notificacion : notificaciones) {
	            	if(notificacion.getTipo().equals("D")) { //Notificaciones de tipo diferenciasl
			            if(Math.abs(monitoreoprecio.getDiferencia())>notificacion.getPrecio()) {
			            	activarNotificacion(notificacion, monitoreoprecio.getPrecioActual());
			            }
	            	}
	            	else if(notificacion.getTipo().equals("P")) { // Notificacion por precio
	            		if((notificacion.getDireccion().equals("B") && monitoreoprecio.getPrecioActual()<notificacion.getPrecio()) || (notificacion.getDireccion().equals("A") && monitoreoprecio.getPrecioActual()>notificacion.getPrecio())) {
	            			activarNotificacion(notificacion, monitoreoprecio.getPrecioActual());
	            		}
	            	}
	            }
		}
		catch (Exception e) {
			System.out.println(e);		    	  
		}
		return monitoreoprecio;
	}
	public String activarNotificacion(Notificacion notificacion, double precio) throws FirebaseMessagingException {
		String deviceToken = "eosCvtvlSlq0HHmDdRT2Pw:APA91bEAF11MSImkIvtOUJt4NJEzhtKDVvBR49RBb9fLLACja-feJ5TuO3oV0lf0OzfiEJnJPlP_h9Z-mCXaV3BW-6pLaZqe-M5sf9U9kMoAgEdslMmUedI";
		//notificacion.setEstado("A");
    	//notificacionDao.save(notificacion);
        Message message = Message.builder()
              .setToken(deviceToken)
              .setNotification(
                      Notification.builder()
                              .setTitle(notificacion.getTitulo())
                              .setBody(notificacion.getMensaje() + "precio actual " + precio)
                              .build()
              )
              .build();		      
      String response = FirebaseMessaging.getInstance().send(message);
      System.out.println("mensaje enviado:  " + response);
      return "";
	}
	public MonitoreoPrecioDto getPrecioAUD() {
		HistoricoPrecio ultimoConsultado;
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
            ultimoConsultado=historicoPrecioDao.findUltimoPrecio();
            HistoricoPrecio historicoPrecio = new HistoricoPrecio(json.optString("symbol"), new Date(), json.optDouble("close"));
            historicoPrecioDao.save(historicoPrecio);
            MonitoreoPrecioDto monitoreoprecio=new MonitoreoPrecioDto(historicoPrecio.getMoneda(), ultimoConsultado.getPrecio(),historicoPrecio.getPrecio(), ultimoConsultado.getPrecio()-historicoPrecio.getPrecio());
            
            return monitoreoprecio;
		}
		 catch (Exception e) {
	            e.printStackTrace();
	            return null;
	    }	
	}
	
 }

package com.bolsadeideas.springboot.app.models.service;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Date;
import java.util.concurrent.CompletableFuture;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bolsadeideas.springboot.app.models.dao.IHistoricoPrecioDao;
import com.bolsadeideas.springboot.app.models.dto.MonitoreoPrecioDto;
import com.bolsadeideas.springboot.app.models.entity.HistoricoPrecio;
import com.google.firebase.messaging.FirebaseMessaging;
import com.google.firebase.messaging.Message;
import com.google.firebase.messaging.Notification;


@Service
public class PrecioServiceImp implements IPrecioService {
	
	
	/*private final FirebaseApp firebaseApp;
	
	@Autowired
    public PrecioServiceImp(FirebaseApp firebaseApp) {
        this.firebaseApp = firebaseApp;
    }*/
	
	@Autowired
	private IHistoricoPrecioDao historicoPrecioDao;

	//@Async
	//public CompletableFuture<String> monitorearPrecio()  {
	public MonitoreoPrecioDto monitorearPrecio() {
		MonitoreoPrecioDto monitoreoprecio=null;
		//double valorAud=0.0;
		Date hora=new Date();
		try {    	
	            String deviceToken = "eosCvtvlSlq0HHmDdRT2Pw:APA91bEAF11MSImkIvtOUJt4NJEzhtKDVvBR49RBb9fLLACja-feJ5TuO3oV0lf0OzfiEJnJPlP_h9Z-mCXaV3BW-6pLaZqe-M5sf9U9kMoAgEdslMmUedI";
	            System.out.println("Respuesta de la API:");
	            monitoreoprecio=getPrecioAUD();
	            hora = new Date();
	            System.out.println(".  "+hora +"--valor actual:" + monitoreoprecio.getPrecioActual() + "---diferencia:"+monitoreoprecio.getDiferencia());
	            if(monitoreoprecio.getDiferencia()>0.0001 || monitoreoprecio.getDiferencia()<-0.0001) {
			        Message message = Message.builder()
			              .setToken(deviceToken)
			              .setNotification(
			                      Notification.builder()
			                              .setTitle("Alerta de precio AUD")
			                              .setBody("AUD esta valiendo " + monitoreoprecio.getPrecioActual())
			                              .build()
			              )
			              .build();
		      
			      String response = FirebaseMessaging.getInstance().send(message);
			      //System.out.println("Push enviado: " + response);
			      //System.out.println("Push enviado: " );
			     // return monitoreoprecio;
	            }
		}
		catch (Exception e) {
			System.out.println(e);		    	  
		}
		//return CompletableFuture.completedFuture("termina el monitoreo");
		return monitoreoprecio;
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
            //System.out.println("precio actual:" + historicoPrecio.getPrecio() + "  --Precio anterior:" + ultimoConsultado.getPrecio());
            MonitoreoPrecioDto monitoreoprecio=new MonitoreoPrecioDto(historicoPrecio.getMoneda(), ultimoConsultado.getPrecio(),historicoPrecio.getPrecio(), ultimoConsultado.getPrecio()-historicoPrecio.getPrecio());
            //double close = json.optDouble("close");
            
            return monitoreoprecio;
		}
		 catch (Exception e) {
	            e.printStackTrace();
	            return null;
	    }	
	}
	
 }

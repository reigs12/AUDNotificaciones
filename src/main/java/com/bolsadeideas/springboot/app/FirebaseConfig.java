package com.bolsadeideas.springboot.app;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;

@Configuration
public class FirebaseConfig {
	
	@Bean
	public FirebaseApp firebaseApp() throws IOException {
		InputStream serviceAccount = null;
		File renderFile = new File("/etc/secrets/audnotificaciones.json");
		if (renderFile.exists()) {
            System.out.println("Usando credenciales Firebase desde Render Secret File.");
            serviceAccount = new FileInputStream(renderFile);
        }
		if (serviceAccount == null) {
            System.out.println("Usando credenciales Firebase desde resources (entorno local).");
            serviceAccount = getClass().getClassLoader().getResourceAsStream("audnotificaciones.json");

            if (serviceAccount == null) {
                throw new FileNotFoundException("No se encontró audnotificaciones.json ni en Render ni en resources.");
            }
        }

	    FirebaseOptions options = FirebaseOptions.builder()
	            .setCredentials(GoogleCredentials.fromStream(serviceAccount))
	            .build();

	    if (FirebaseApp.getApps().isEmpty()) {
            return FirebaseApp.initializeApp(options);
        } else {
            return FirebaseApp.getInstance();
        }
	}

}

package com.bolsadeideas.springboot.app;

import java.io.InputStream;
import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Date;

import org.json.JSONObject;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.core.io.ClassPathResource;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import com.google.firebase.messaging.Message;
import com.google.firebase.messaging.Notification;
import com.google.firebase.messaging.FirebaseMessaging;


@SpringBootApplication
@EnableAsync
public class SpringBootDataJpaApplication implements CommandLineRunner  {
	
	
	public static void main(String[] args) {
       //System.setProperty("javax.net.ssl.trustStorePassword", "changeit");
       //System.setProperty("javax.net.ssl.trustStore", "C:/Users/reinaldoguarin.guari/mytruststore.jks");
       SpringApplication.run(SpringBootDataJpaApplication.class, args);
		
	}
	@Override
	public void run(String... args) throws Exception {		
		
	}
	
	@Bean
	public BCryptPasswordEncoder passwordEncoder() {
	    return new BCryptPasswordEncoder();
	}
	
	@Bean
	public WebMvcConfigurer corsConfigurer() {
		return new WebMvcConfigurer() {
			@Override
			public void addCorsMappings(CorsRegistry registry) {
				registry.addMapping("/v0").allowedOrigins("/**").allowedMethods("*").allowedHeaders("/**");
			}
		};
	}

}

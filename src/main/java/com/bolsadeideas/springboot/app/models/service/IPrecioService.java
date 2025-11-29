package com.bolsadeideas.springboot.app.models.service;

import java.util.Map;
import java.util.concurrent.CompletableFuture;

import com.bolsadeideas.springboot.app.models.dto.MonitoreoPrecioDto;
import com.bolsadeideas.springboot.app.models.entity.Notificacion;
import com.google.firebase.messaging.FirebaseMessagingException;

public interface IPrecioService {
	//public CompletableFuture<String> monitorearPrecio();
	public MonitoreoPrecioDto monitorearPrecio();
	public String enviarNotificacion() throws FirebaseMessagingException;
	public Notificacion actualizarNotificacion(Long id,Map<String, Object> cambios);

}
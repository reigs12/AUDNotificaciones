package com.bolsadeideas.springboot.app.models.service;

import java.util.concurrent.CompletableFuture;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.support.SessionStatus;

public interface IPrecioService {
	//public CompletableFuture<String> monitorearPrecio();
	public String monitorearPrecio();

}
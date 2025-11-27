package com.bolsadeideas.springboot.app.models.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import com.fasterxml.jackson.annotation.JsonFormat;

@Entity
@Table(name = "historicoprecio")
public class HistoricoPrecio implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id_historico_precio")
	private Long idHistoricoPrecio;
	
	private String moneda;
		
	@NotNull
	@Temporal(TemporalType.TIMESTAMP)
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "dd/MM/yyyy hh:mm", timezone = "GMT")
	@Column(name = "hora")
	private Date hora;
	
	@NotNull
	private double precio;
	
	public HistoricoPrecio() {
		super();
	}

	public HistoricoPrecio(String moneda, @NotNull Date hora,
			@NotNull double precio) {
		super();
		this.moneda = moneda;
		this.hora = hora;
		this.precio = precio;
	}

	public Long getIdHistoricoPrecio() {
		return idHistoricoPrecio;
	}

	public void setIdHistoricoPrecio(Long idHistoricoPrecio) {
		this.idHistoricoPrecio = idHistoricoPrecio;
	}

	public String getMoneda() {
		return moneda;
	}

	public void setMoneda(String moneda) {
		this.moneda = moneda;
	}

	public Date getHora() {
		return hora;
	}

	public void setHora(Date hora) {
		this.hora = hora;
	}

	public double getPrecio() {
		return precio;
	}

	public void setPrecio(double precio) {
		this.precio = precio;
	}	
}

package com.bolsadeideas.springboot.app.models.dto;


import org.springframework.stereotype.Component;


@Component
public class MonitoreoPrecioDto {
	private String moneda;
	private double precioAnterior;
	private double precioActual;
	private double diferencia;
	
	public MonitoreoPrecioDto(String moneda, double precioAnterior, double precioActual, double diferencia) {
		super();
		this.moneda = moneda;
		this.precioAnterior = precioAnterior;
		this.precioActual = precioActual;
		this.diferencia = diferencia;
	}

	public MonitoreoPrecioDto() {
		super();
	}



	public String getMoneda() {
		return moneda;
	}

	public void setMoneda(String moneda) {
		this.moneda = moneda;
	}

	public double getPrecioAnterior() {
		return precioAnterior;
	}

	public void setPrecioAnterior(double precioAnterior) {
		this.precioAnterior = precioAnterior;
	}

	public double getPrecioActual() {
		return precioActual;
	}

	public void setPrecioActual(double precioActual) {
		this.precioActual = precioActual;
	}

	public double getDiferencia() {
		return diferencia;
	}

	public void setDiferencia(double diferencia) {
		this.diferencia = diferencia;
	}	
}

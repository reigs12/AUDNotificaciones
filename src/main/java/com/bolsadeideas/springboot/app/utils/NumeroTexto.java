package com.bolsadeideas.springboot.app.utils;

import java.util.HashMap;
import java.util.Map;

public class NumeroTexto {
	private Map<Integer, String> numeros = new HashMap<Integer, String>();
	private Map<Integer, String> decenas = new HashMap<Integer, String>();
	public NumeroTexto()
	{
		numeros.put(0, "cero");
		numeros.put(1, "uno");
		numeros.put(2, "dos");
		numeros.put(3, "tres");
		numeros.put(4, "cuatro");
		numeros.put(5, "cinco");
		numeros.put(6, "seis");
		numeros.put(7, "siete");
		numeros.put(8, "ocho");
		numeros.put(9, "nueve");
		numeros.put(10, "diez");
		numeros.put(11, "once");
		numeros.put(12, "doce");
		numeros.put(13, "trece");
		numeros.put(14, "catorce");
		numeros.put(15, "quince");
		numeros.put(16, "dieciseis");
		numeros.put(17, "diecisiete");
		numeros.put(18, "dieciocho");
		numeros.put(19, "diecinueve");
		numeros.put(100, "cien");
		//decenas
		decenas.put(2, "veinte");
		decenas.put(3, "treinta");
		decenas.put(4, "cuarenta");
		decenas.put(5, "cincuenta");
		decenas.put(6, "sesenta");
		decenas.put(7, "setenta");
		decenas.put(8, "ochenta");
		decenas.put(9, "noventa");
	}
	public String getTextNumero(Integer numero)
	{
		String texto=null;
		if(numero<20 || numero==100) {
			texto= numeros.get(numero);
		} else {
			int decena;
			int unidad;
			decena=numero/10;
			unidad=numero%10;
			texto=decenas.get(decena);
			if(texto==null)
				return " ";
			if(unidad!=0)
				texto=texto + " y " + numeros.get(unidad);
		}
		return texto == null ? " " : texto;
	}
}

package com.bolsadeideas.springboot.app.utils;

import java.io.ByteArrayInputStream;
import org.springframework.core.io.ClassPathResource;
import java.io.ByteArrayOutputStream;
//Librerías JAVA
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

//Librerías POI
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.poi.xwpf.usermodel.XWPFTable;
import org.apache.poi.xwpf.usermodel.XWPFTableCell;
import org.apache.poi.xwpf.usermodel.XWPFTableRow;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.STMerge;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Component;

import fr.opensagres.poi.xwpf.converter.core.XWPFConverterException;
import fr.opensagres.poi.xwpf.converter.pdf.PdfOptions;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import com.google.firebase.messaging.FirebaseMessaging;
import com.google.firebase.messaging.FirebaseMessagingException;
import com.google.firebase.messaging.Message;
import com.google.firebase.messaging.Notification;


@Component
public class CovertToPdf {

  public static void main(String[] args) throws IOException, FirebaseMessagingException {
	  InputStream serviceAccount = new ClassPathResource("audnotificaciones.json").getInputStream();

      FirebaseOptions options = FirebaseOptions.builder()
              .setCredentials(GoogleCredentials.fromStream(serviceAccount))
              .build();

      FirebaseApp.initializeApp(options);

      String deviceToken = "eosCvtvlSlq0HHmDdRT2Pw:APA91bEAF11MSImkIvtOUJt4NJEzhtKDVvBR49RBb9fLLACja-feJ5TuO3oV0lf0OzfiEJnJPlP_h9Z-mCXaV3BW-6pLaZqe-M5sf9U9kMoAgEdslMmUedI";

      /*Message message = Message.builder()
              .setToken(deviceToken)
              .setNotification(
                      Notification.builder()
                              .setTitle("Hola desde Reinaldo")
                              .setBody("Te amo mi amor de nuevo")
                              .build()
              )
              .build();*/

      //String response = FirebaseMessaging.getInstance().send(message);
      //System.out.println("Push enviado: " + response);
      System.out.println("Push enviado: " );
  }

  public static XWPFDocument leerDocx(File archivoWord) {

      XWPFDocument documentoWord = null;

      try {
    	  
          InputStream texto = new FileInputStream(archivoWord);
          documentoWord = new XWPFDocument(texto);
          documentoWord.createStyles();

      } catch (IOException e) {
          System.out.println("Error leyendo el fichero de Word");
          e.printStackTrace();
      }
      return documentoWord;

  }

  public static boolean convertirPDF(File archivoPDF, XWPFDocument documentWord) {

      boolean exito;

      try {
          OutputStream out = new FileOutputStream(archivoPDF);
          PdfOptions options = PdfOptions.create();
          exito = true;

      } catch (XWPFConverterException e) {
          exito = false;
          System.out.println("Error en la conversión");
          e.printStackTrace();
      } catch (IOException e) {
          exito = false;
          System.out.println("Error creando el fichero PDF");
          e.printStackTrace();
      }

      return exito;

  }
  
 /* public static void mergeCellsHorizonal(XWPFTable table, int row, int fromCol, int toCol) {
	  if (toCol <= fromCol) return;
	  XWPFTableCell cell = table.getRow(row).getCell(fromCol);
	  CTTcPr tcPr = getTcPr(cell);
	  XWPFTableRow rowTable = table.getRow(row);
	  for (int colIndex = fromCol + 1; colIndex <= toCol; colIndex++) {
	    rowTable.getCtRow().removeTc(fromCol + 1);
	    rowTable.removeCell(fromCol + 1);
	  }
	  CTTcPr tcPr= cell.getCTTc().addNewTcPr();
	  
	  addNewTcPr().addNewGridSpan();
	  tcPr.getGridSpan().setVal(BigInteger.valueOf((long) (toCol - fromCol + 1)));
	}*/
  
  public void mergeCellsHorizontal(XWPFTable table, int row, int startCol,int endCol) {
	  for (int cellIndex = startCol; cellIndex <= endCol; cellIndex++) {
	    XWPFTableCell cell = table.getRow(row).getCell(cellIndex);
	    if (cellIndex == startCol) {
	      cell.getCTTc().addNewTcPr().addNewHMerge().setVal(STMerge.RESTART);
	    } else {
	      cell.getCTTc().addNewTcPr().addNewHMerge().setVal(STMerge.CONTINUE);
	    }
	  }
	}
  public void mergeCellsVertically(XWPFTable table, int col, int fromRow, int toRow) {
	   for (int rowIndex = fromRow; rowIndex <= toRow; rowIndex++) {
	      XWPFTableCell cell = table.getRow(rowIndex).getCell(col);
	      if (rowIndex == fromRow) {
	        cell.getCTTc().addNewTcPr().addNewVMerge().setVal(STMerge.RESTART);
	      } else {
	        cell.getCTTc().addNewTcPr().addNewVMerge().setVal(STMerge.CONTINUE);
	      }
	   }
  }

}

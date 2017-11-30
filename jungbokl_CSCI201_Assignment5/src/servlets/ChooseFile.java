package servlets;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import objects.DataContainer;
import parsing.Parser;
import parsing.StoreData;
import parsing.StringConstants;

/**
 * Servlet implementation class ChooseFile
 */
@WebServlet("/ChooseFile")
@MultipartConfig
public class ChooseFile extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 Part filePart = request.getPart(StringConstants.FILE);
		 if(filePart != null) {
			 InputStreamReader fileContent = new InputStreamReader(filePart.getInputStream());
			 BufferedReader br = new BufferedReader(fileContent);
			 DataContainer data = new Parser(br).getData();
			 //send data to mysql
			 String mysql = null;
		 
			 String username = request.getParameter("username");
			 //System.out.println("Username: " +username);
			 String ipaddress = request.getParameter("ipaddress");
			 String password = request.getParameter("password");
			 String ssl = request.getParameter("ssl");
		 
			 //System.out.println("ssl: " + ssl);
			 if(ssl == null) {
				 ssl = "false";
			 }
			 else {
				 ssl = "true";
			 }
		 
			 mysql = "jdbc:mysql://" + ipaddress + "/jungbokl_201_site?user=" + username + "&password=" + password + "&useSSL=" + ssl; 
		 
			 //System.out.println(mysql);
			 //"jdbc:mysql://localhost/jungbokl_a5?user=root&password=root&useSSL=false"
			 StoreData sd = new StoreData(data, mysql);
			 sd.insertData();
		 
			 br.close();
			 fileContent.close();
			 data.organize();
			 request.getSession().setAttribute(StringConstants.DATA, data);
		 }
		 request.getSession().setMaxInactiveInterval(60);
		 
		 String designChoice = request.getParameter("stylecss");
		 //css information
		 String design = "";
		 if(designChoice.equals("1")) {
			 design = "option1.css";
		 }
		 else {
			 design = "option2.css";
		 }
		 
		 HttpSession designSess = request.getSession();
		 designSess.setAttribute("designChoice", design);		 
		 //
		 
		 response.sendRedirect("jsp/"+StringConstants.HOME_JSP);
	}

}

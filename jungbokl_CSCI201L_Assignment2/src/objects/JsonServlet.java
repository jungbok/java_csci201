package objects;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.google.gson.Gson;

import parsing.Startparsing;

@WebServlet("/JsonServlet")
@MultipartConfig
public class JsonServlet extends HttpServlet {
		private static final long serialVersionUID = 1L;
			
		protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
			
			//create a session for jsp
			HttpSession session = request.getSession();
			
			//gets the file from index.jsp
			Part filePart = request.getPart("file");
			InputStream fileContent = filePart.getInputStream();
			Gson gson = new Gson();
			BufferedReader reader = new BufferedReader(new InputStreamReader(fileContent));
			Startparsing sp = gson.fromJson(reader, Startparsing.class);
			session.setAttribute("Startparsing", sp);
			RequestDispatcher dispatch = getServletContext().getRequestDispatcher("/website.jsp");
			session.setMaxInactiveInterval(60);
			dispatch.forward(request, response);
		}
}



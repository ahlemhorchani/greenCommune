package servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/logo")
public class LogoutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	    @Override
	    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	        // Invalider la session
	        HttpSession session = request.getSession(false); // Ne pas créer une nouvelle session
	        if (session != null) {
	            session.invalidate(); // Invalider la session
	        }
	        // Rediriger vers la page de connexion
	        response.sendRedirect("login.jsp?message=Vous êtes déconnecté avec succès.");
	    }
	}
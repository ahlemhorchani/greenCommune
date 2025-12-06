package servlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ParticipationDAO;
import model.User;

/**
 * Servlet implementation class ParticipationServlet
 */
@WebServlet("/participation")
public class ParticipationServlet extends HttpServlet {
	 private static final long serialVersionUID = 1L;

	    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	        // Récupérer l'ID de l'utilisateur depuis la session
	        int userId = ((User) request.getSession().getAttribute("user")).getId();

	        // Récupérer l'ID de l'événement depuis le formulaire
	        int eventId = Integer.parseInt(request.getParameter("event_id"));
	        ParticipationDAO participationDAO = null;

	        try {
	            participationDAO = new ParticipationDAO();  // Créer une instance de ParticipationDAO
	        } catch (SQLException e) {
	            e.printStackTrace();
	            // Gérer l'exception ici en redirigeant l'utilisateur vers une page d'erreur
	            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erreur de connexion à la base de données.");
	            return; // Arrêter l'exécution ici si la connexion échoue
	        }

	        participationDAO.addParticipation(userId, eventId);

	        // Rediriger l'utilisateur vers le tableau de bord
	        response.sendRedirect("user_dashboard.jsp");
	    }
	}
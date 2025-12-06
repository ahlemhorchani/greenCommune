package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.ParticipationDAO;
import model.Participation;
import model.User;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
/**
 * Servlet implementation class RegisterEventServlet
 */
@WebServlet("/register")
public class RegisterEventServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private ParticipationDAO participationDAO;

    @Override
    public void init() throws ServletException {
        try {
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/greencommune", "root", "");
            participationDAO = new ParticipationDAO(conn);
        } catch (SQLException e) {
            throw new ServletException("Failed to connect to database", e);
        }
    }

    @Override
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int eventId = Integer.parseInt(request.getParameter("eventId"));

        // ✅ Récupération de l'utilisateur connecté depuis la session
        HttpSession session = request.getSession(false);
        User currentUser = (User) session.getAttribute("currentUser");

        if (currentUser == null) {
            // Utilisateur non connecté
            response.sendRedirect("login.jsp?error=Veuillez vous connecter d'abord.");
            return;
        }

        // ✅ Récupération de l'ID de l'utilisateur connecté
        int userId = currentUser.getId();

        Participation participation = new Participation(userId, eventId);

        try {
            participationDAO.registerParticipation(participation);
            response.sendRedirect("events?action=available&success=1");

        } catch (SQLException e) {
            throw new ServletException("Erreur lors de l'inscription à l'événement", e);
        }
    }

}




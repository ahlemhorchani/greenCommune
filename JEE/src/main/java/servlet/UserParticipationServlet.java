package servlet;

import dao.ParticipationDAO;
import model.Participation;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/userparticipations")
public class UserParticipationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Récupérer l'utilisateur depuis la session avec le bon nom d'attribut
        User user = (User ) request.getSession().getAttribute("currentUser");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = user.getId();

        try {
            ParticipationDAO dao = new ParticipationDAO();
            List<Participation> participations = dao.getUserParticipations(userId);
            request.setAttribute("participations", participations);
            request.getRequestDispatcher("user_participations.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erreur lors de la récupération des participations.");
        }
    }
}
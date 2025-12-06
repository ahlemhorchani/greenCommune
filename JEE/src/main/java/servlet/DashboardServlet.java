package servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import model.Participation;
import dao.EventDAO;
import dao.ParticipationDAO;
import model.Event;
import model.User;

@WebServlet("/user_dashboard")
public class DashboardServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DashboardServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        int userId = user.getId();

        try {
            EventDAO eventDAO = new EventDAO(); // Utilisation de l'objet EventDAO
            ParticipationDAO participationDAO = new ParticipationDAO();

            // Obtenir la liste des événements
            List<Event> events = EventDAO.getAllEvents(); // Appel statique de la méthode

            // Obtenir la liste des participations de l'utilisateur
            List<Participation> participations = participationDAO.getUserParticipations(userId);

            // Créer une liste d'IDs des événements auxquels l'utilisateur a participé
            List<Integer> participatedEvents = new ArrayList<>();
            for (Participation participation : participations) {
                participatedEvents.add(participation.getEventId());
            }

            // Passer les données à la JSP
            request.setAttribute("events", events);
            request.setAttribute("participatedEvents", participatedEvents);

            // Redirection vers la page du tableau de bord
            request.getRequestDispatcher("user_dashboard.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erreur lors de la récupération des événements.");
        }
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}

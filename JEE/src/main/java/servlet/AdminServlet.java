package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import dao.EventDAO;
import dao.UserDAO;
import model.Event;
import model.User;

@WebServlet("/admin_dashboard")
public class AdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private EventDAO eventDAO;

    @Override
    public void init() throws ServletException {
        try {
            // Adapter ici ton URL BDD
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/green_commune", "root", "");
            eventDAO = new EventDAO(conn);
        } catch (SQLException e) {
            throw new ServletException("DB connection failed!", e);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Récupérer la liste des utilisateurs depuis la base de données
            UserDAO userDAO = new UserDAO();
            List<User> users = userDAO.getAllUsers();

            if (users == null || users.isEmpty()) {
                System.out.println("Aucun utilisateur trouvé dans la base de données.");
                request.setAttribute("userError", "Aucun utilisateur trouvé.");
            } else {
                request.setAttribute("users", users);
            }

            // Utiliser l'instance eventDAO déjà créée dans init()
            List<Event> events = eventDAO.getAllEvents();

            if (events == null || events.isEmpty()) {
                System.out.println("Aucun événement trouvé dans la base de données.");
                request.setAttribute("eventError", "Aucun événement trouvé.");
            } else {
                request.setAttribute("events", events);
            }

            request.getRequestDispatcher("admin_dashboard.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erreur lors de la récupération des données.");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO: Gestion des actions POST pour les événements (ajout, modification, suppression)
        doGet(request, response);
    }
}
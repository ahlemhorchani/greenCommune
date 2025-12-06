package servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import dao.EventDAO;
import dao.ImpactDAO;
import model.Event;
import model.Impact;
import model.User;

@WebServlet("/impact")
public class ImpactServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private ImpactDAO impactDAO;
    private EventDAO eventDAO;

    @Override
    public void init() throws ServletException {
        try {
            impactDAO = new ImpactDAO();
            eventDAO = new EventDAO();
        } catch (SQLException e) {
            throw new ServletException("Database connection failed!", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("currentUser");  // Changed to "currentUser"
        
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = user.getId();
        String action = request.getParameter("action");

        try {
            if (action == null || action.equals("list")) {
                List<Impact> impacts = impactDAO.getUserImpacts(userId);
                request.setAttribute("impacts", impacts);
                request.getRequestDispatcher("impact_dashboard.jsp").forward(request, response);
            } else if (action.equals("addEvent")) {
                showAddEventForm(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erreur lors de la récupération des impacts.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("currentUser");  // Changed to "currentUser"

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = user.getId();
        String action = request.getParameter("action");

        try {
            if (action.equals("addImpact")) {
                addImpact(request, response, userId);
            } else if (action.equals("addEvent")) {
                addEvent(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erreur lors de l'enregistrement de l'impact ou de l'événement.");
        }
    }

    private void addImpact(HttpServletRequest request, HttpServletResponse response, int userId) throws SQLException, IOException {
        String impactType = request.getParameter("impact_type");
        int impactValue = Integer.parseInt(request.getParameter("impact_value"));

        Impact impact = new Impact(0, userId, impactType, impactValue, new java.sql.Timestamp(System.currentTimeMillis()));
        impactDAO.addImpact(impact);
        response.sendRedirect("impact?action=list");
    }

    private void showAddEventForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("addEvent.jsp").forward(request, response);
    }

    private void addEvent(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        Event event = new Event();
        event.setTitle(request.getParameter("title"));
        event.setDescription(request.getParameter("description"));
        event.setEventDate(request.getParameter("eventDate"));
        event.setLocation(request.getParameter("location"));
        event.setImpactType(request.getParameter("impactType"));
        event.setImpactValue(Integer.parseInt(request.getParameter("impactValue")));

        eventDAO.addEvent(event);
        response.sendRedirect("events?action=list");
    }
}
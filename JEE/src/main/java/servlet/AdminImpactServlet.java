package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.ImpactDAO;
import model.Impact;
import model.User;

import java.sql.Timestamp;
import java.sql.Connection;
import java.sql.DriverManager;

import java.sql.SQLException;
import java.util.List;

/**
 * Servlet implementation class AdminImpactServlet
 */
@WebServlet("/adminImpactServlet")
public class AdminImpactServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    private ImpactDAO impactDAO;

    @Override
    public void init() throws ServletException {
        try {
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/greencommune", "root", "");
            impactDAO = new ImpactDAO(conn);
        } catch (SQLException e) {
            throw new ServletException("DB connection failed!", e);
        }
    }


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            // L'utilisateur n'est pas connecté, redirigez-le vers la page de login
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = user.getId();

        try {
            ImpactDAO impactDAO = new ImpactDAO();
            List<Impact> impacts = impactDAO.getUserImpacts(userId);
            request.setAttribute("impacts", impacts);
            request.getRequestDispatcher("impact_dashboard.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erreur lors de la récupération des impacts.");
        }
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if (action.equals("add")) {
                addImpact(request, response);
            } else if (action.equals("update")) {
                updateImpact(request, response);
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Impact existingImpact = impactDAO.getImpactById(id);
        request.setAttribute("impact", existingImpact);
        request.getRequestDispatcher("impact_mod.jsp").forward(request, response);
    }

    private void addImpact(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        Impact impact = new Impact(0,
                Integer.parseInt(request.getParameter("userId")),
                request.getParameter("impactType"),
                Integer.parseInt(request.getParameter("impactValue")),
                Timestamp.valueOf(request.getParameter("impactDate"))
        );

        impactDAO.addImpact(impact);
        response.sendRedirect("impacts?action=list");
    }

    private void updateImpact(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        Impact impact = new Impact(
                Integer.parseInt(request.getParameter("id")),
                Integer.parseInt(request.getParameter("userId")),
                request.getParameter("impactType"),
                Integer.parseInt(request.getParameter("impactValue")),
                Timestamp.valueOf(request.getParameter("impactDate"))
        );

        impactDAO.updateImpact(impact);
        response.sendRedirect("impacts?action=list");
    }

    private void deleteImpact(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        impactDAO.deleteImpact(id);
        response.sendRedirect("impacts?action=list");
    }
}
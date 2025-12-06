package servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.BadgeDAO;
import dao.ImpactDAO;
import model.Badge;
import model.User;

@WebServlet("/badges")
public class BadgeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        int userId = user.getId();

        try {
            BadgeDAO badgeDAO = new BadgeDAO();
            ImpactDAO impactDAO = new ImpactDAO();

            int totalImpact = impactDAO.getUserTotalImpact(userId);
            List<Badge> badges = badgeDAO.getAllBadges();

            // Vérifier les badges à attribuer
            for (Badge badge : badges) {
                if (totalImpact >= badge.getRequiredImpact() && !badgeDAO.hasBadge(userId, badge.getId())) {
                    badgeDAO.awardBadge(userId, badge.getId());
                }
            }

            request.setAttribute("badges", badges);
            request.getRequestDispatcher("badges_dashboard.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erreur lors de la récupération des badges.");
        }
    }
}
package servlet;

import dao.UserDAO;
import model.User;
import util.NotificationSender;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
@WebServlet("/auth")
public class AuthServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	@Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("register".equals(action)) {
            register(request, response);
        } else if ("login".equals(action)) {
            login(request, response);
        }
    }
	

    private void register(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String fullName = request.getParameter("fullName");

        User newUser = new User();
        newUser.setUsername(username);
        newUser.setEmail(email);
        newUser.setPassword(password);
        newUser.setRole("user"); // par défaut
        newUser.setFullName(fullName);

        boolean success = UserDAO.registerUser(newUser);
        if (success) {
            NotificationSender.sendNotification(email, "Bienvenue sur GreenCommune", "Merci pour votre inscription, " + fullName + " !");
            response.sendRedirect("login.jsp?message=Inscription réussie, veuillez vous connecter.");
        } else {
            response.sendRedirect("register.jsp?error=Échec de l'inscription, réessayez.");
        }
    }

    private void login(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        User user = UserDAO.login(email, password);
        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("currentUser", user);

            if ("admin".equals(user.getRole())) {
                response.sendRedirect("admin_dashboard.jsp");
            } else {
                response.sendRedirect("user_dashboard.jsp");
            }
        } else {
            response.sendRedirect("login.jsp?error=Email ou mot de passe incorrect.");
        }
    }
}


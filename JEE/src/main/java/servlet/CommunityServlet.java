package servlet;

import dao.UserDAO;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.itextpdf.text.Chunk;
import com.itextpdf.text.Document;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/users")
public class CommunityServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    private UserDAO userDAO;


    @Override
    public void init() throws ServletException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // Charger le driver JDBC
            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/greencommune", "root", "");
            userDAO = new UserDAO(connection);
            
            userDAO.deleteOldUsers();
        } catch (ClassNotFoundException e) {
            throw new ServletException("JDBC Driver not found!", e);
        } catch (SQLException e) {
            throw new ServletException("DB connection failed!", e);
        }
    }



    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if (action == null || action.equals("list")) {
                listUsers(request, response);
            } else if (action.equals("edit")) {
                showEditForm(request, response);
            } else if (action.equals("delete")) {
                deleteUser(request, response);
            } else if (action.equals("exportPdf")) {
                exportUsersToPDF(request, response);
            }
        } catch (SQLException e) {
            throw new ServletException("Error processing user actions", e);
        }
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if (action.equals("add")) {
                addUser(request, response);
            } else if (action.equals("update")) {
                updateUser(request, response);
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    private void listUsers(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        List<User> users = userDAO.getAllUsers();
        request.setAttribute("users", users);
        request.getRequestDispatcher("manageUsers.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Pour le moment tu n'as pas de getUserById dans UserDAO, donc à implémenter si besoin
        request.getRequestDispatcher("user_mod.jsp").forward(request, response);
    }

    private void addUser(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        User user = new User();
        user.setUsername(request.getParameter("username"));
        user.setEmail(request.getParameter("email"));
        user.setPassword(request.getParameter("password")); // À améliorer plus tard avec du hashage

        String role = request.getParameter("role");
        if (role == null || role.isEmpty()) {
            role = "user"; // valeur par défaut
        }
        user.setRole(role);

        user.setFullName(request.getParameter("fullName"));

        boolean success = UserDAO.registerUser(user);
        if (success) {
            response.sendRedirect("users?action=list");
        } else {
            response.sendRedirect("error.jsp?message=Échec de l'inscription, réessayez.");
        }
    }
    private void exportUsersToPDF(HttpServletRequest request, HttpServletResponse response) throws IOException {
        User user = (User) request.getSession().getAttribute("currentUser");
        if (user == null || !"admin".equals(user.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            List<User> users = userDAO.getAllUsers();

            // Configuration de la réponse HTTP
            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition", "attachment; filename=users.pdf");

            Document document = new Document();
            PdfWriter.getInstance(document, response.getOutputStream());
            document.open();

            document.add(new Paragraph("Liste des utilisateurs enregistrés"));
            document.add(Chunk.NEWLINE);

            PdfPTable table = new PdfPTable(4); // Change selon les colonnes
            table.addCell("ID");
            table.addCell("Nom d'utilisateur");
            table.addCell("Nom complet");
            table.addCell("Email");

            for (User u : users) {
                table.addCell(String.valueOf(u.getId()));
                table.addCell(u.getUsername());
                table.addCell(u.getFullName());
                table.addCell(u.getEmail());
            }

            document.add(table);
            document.close();

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erreur lors de la génération du PDF.");
        }
    }


    private void updateUser(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        // Update utilisateur - à implémenter si tu ajoutes un update dans UserDAO
    }
 


    private void deleteUser(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        userDAO.deleteUser(id);
        response.sendRedirect("users?action=list");
    }

}

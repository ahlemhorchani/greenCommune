package servlet;

import dao.EventDAO;
import model.Event;
import model.User;
import dao.UserDAO;
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

@WebServlet("/events")
public class EventServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private EventDAO eventDAO;

    @Override
    public void init() throws ServletException {
        try {
            // Adapter ici ton URL BDD
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/greencommune", "root", "");
            eventDAO = new EventDAO(conn);
        } catch (SQLException e) {
            throw new ServletException("DB connection failed!", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if (action == null || action.equals("list")) {
                List<Event> events = eventDAO.getAllEvents(); // une seule fois
                request.setAttribute("events", events); // une seule fois
                request.getRequestDispatcher("manageEvents.jsp").forward(request, response);
            } else if (action.equals("edit")) {
                showEditForm(request, response);
            } else if (action.equals("delete")) {
                deleteEvent(request, response);
            }  else if (action.equals("available")) {
                showAvailableEvents(request, response); // 👈 ajouté ici
            } else if (action.equals("exportPdff")) {
                exportEventsToPDF(request, response);
            }
        } catch (SQLException e) {
            throw new ServletException("Error retrieving events", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if (action.equals("add")) {
                addEvent(request, response);
            } else if (action.equals("update")) {
                updateEvent(request, response);
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }



    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Event existingEvent = eventDAO.getEventById(id);
        request.setAttribute("event", existingEvent);
        request.getRequestDispatcher("event_mod.jsp").forward(request, response);
    }



    private void addEvent(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        Event event = new Event();
        event.setTitle(request.getParameter("title"));
        event.setDescription(request.getParameter("description"));
        
        // Récupération de la date sous forme de chaîne
        String eventDate = request.getParameter("eventDate");
        event.setEventDate(eventDate); // Assurez-vous que le format est correct

        event.setLocation(request.getParameter("location"));
        event.setImpactType(request.getParameter("impactType"));
        event.setImpactValue(Integer.parseInt(request.getParameter("impactValue")));

        eventDAO.addEvent(event);
        response.sendRedirect("events?action=list");
    }
    private void exportEventsToPDF(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("currentUser");

        if (user == null || !"user".equals(user.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            List<Event> events = eventDAO.getAllEvents();

            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition", "attachment; filename=events.pdf");

            Document document = new Document();
            PdfWriter.getInstance(document, response.getOutputStream());
            document.open();

            document.add(new Paragraph("Liste des événements"));
            document.add(Chunk.NEWLINE);

            PdfPTable table = new PdfPTable(5); // Adapte selon tes colonnes
            table.addCell("ID");
            table.addCell("Titre");
            table.addCell("Date");
            table.addCell("Lieu");
            table.addCell("Type d'impact");

            for (Event e : events) {
                table.addCell(String.valueOf(e.getId()));
                table.addCell(e.getTitle());
                table.addCell(e.getEventDate());
                table.addCell(e.getLocation());
                table.addCell(e.getImpactType());
            }

            document.add(table);
            document.close();

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erreur lors de la génération du PDF.");
        }
    }


    private void updateEvent(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        Event event = new Event();
        event.setId(Integer.parseInt(request.getParameter("id")));
        event.setTitle(request.getParameter("title"));
        event.setDescription(request.getParameter("description"));
        event.setEventDate(request.getParameter("eventDate"));
        event.setLocation(request.getParameter("location"));
        event.setImpactType(request.getParameter("impactType"));
        event.setImpactValue(Integer.parseInt(request.getParameter("impactValue")));

        eventDAO.updateEvent(event);
        response.sendRedirect("events?action=list");
    }
    private void showAvailableEvents(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        List<Event> events = eventDAO.getAllEvents();
        request.setAttribute("events", events);
        request.getRequestDispatcher("availableEvents.jsp").forward(request, response);
    }



    private void deleteEvent(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        eventDAO.deleteEvent(id);
        response.sendRedirect("events?action=list");
    }
}
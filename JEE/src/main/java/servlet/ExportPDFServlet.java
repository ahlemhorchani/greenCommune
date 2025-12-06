package servlet;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;
import dao.ParticipationDAO;
import model.Participation;
import model.User;
 
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;
@WebServlet("/exportpdf")
public class ExportPDFServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	 protected void doGet(HttpServletRequest request, HttpServletResponse response)
	            throws ServletException, IOException {

	        User user = (User) request.getSession().getAttribute("currentUser");
	        if (user == null) {
	            response.sendRedirect("login.jsp");
	            return;
	        }

	        try {
	            List<Participation> participations = new ParticipationDAO().getUserParticipations(user.getId());

	            // Configuration de la réponse HTTP
	            response.setContentType("application/pdf");
	            response.setHeader("Content-Disposition", "attachment; filename=participations.pdf");

	            Document document = new Document();
	            PdfWriter.getInstance(document, response.getOutputStream());
	            document.open();

	            // Titre
	            document.add(new Paragraph("Liste de vos participations aux événements"));
	            document.add(Chunk.NEWLINE);

	            // Table
	            PdfPTable table = new PdfPTable(3);
	            table.addCell("ID Participation");
	            table.addCell("ID Événement");
	            table.addCell("Date de participation");

	            for (Participation p : participations) {
	                table.addCell(String.valueOf(p.getId()));
	                table.addCell(String.valueOf(p.getEventId()));
	                table.addCell(p.getParticipationDate().toString());
	            }

	            document.add(table);
	            document.close();

	        } catch (Exception e) {
	            e.printStackTrace();
	            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erreur lors de la génération du PDF.");
	        }
	    }
	}
package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.WeatherService;
import model.User;
/**
 * Servlet implementation class WeatherServlet
 */
@WebServlet("/WeatherServlet")
public class WeatherServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public WeatherServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    String ville = request.getParameter("city");

	    if (ville == null || ville.trim().isEmpty()) {
	        ville = "Tunis"; // Valeur par défaut
	    }

	    String meteoJson = WeatherService.getWeather(ville);

	    request.setAttribute("meteoJson", meteoJson);
	    request.setAttribute("ville", ville);

	    // Vérifier le rôle de l'utilisateur depuis la session
	    String role = (String) request.getSession().getAttribute("role");

	    if ("admin".equals(role)) {
	        request.getRequestDispatcher("/admin_dashboard.jsp").forward(request, response);
	    } else {
	        request.getRequestDispatcher("/meteo.jsp").forward(request, response);
	    }
	}

	

}

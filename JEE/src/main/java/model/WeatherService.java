package model;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URI;
import java.net.URL;

public class WeatherService {

	public static String getWeather(String city) {
	    String apiKey = "67b7324a80636f74854d6f5856160a8f"; 
	    String apiUrl = "http://api.openweathermap.org/data/2.5/weather?q=" + city + "&appid=" + apiKey + "&units=metric&lang=fr";
	    StringBuilder response = new StringBuilder();

	    try {
	        URI uri = URI.create(apiUrl);
	        URL url = uri.toURL();
	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        conn.setRequestMethod("GET");

	        // Vérifier le code de réponse
	        if (conn.getResponseCode() != 200) {
	            return "Erreur lors de la récupération des données météo.";
	        }

	        BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	        String inputLine;
	        while ((inputLine = in.readLine()) != null) {
	            response.append(inputLine);
	        }
	        in.close();

	    } catch (Exception e) {
	        e.printStackTrace();
	        return "Erreur lors de la récupération des données météo.";
	    }

	    return response.toString(); // JSON brut
	}
}

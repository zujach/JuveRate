package pk.wieik.web;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import pk.wieik.repository.ConcertRepository;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/koncerty")
public class ConcertsServlet extends HttpServlet {
    private final ConcertRepository concerts = new ConcertRepository();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        HttpSession session = request.getSession(false);
        String path = Html.escape(request.getContextPath());

        try {
            var rows = concerts.findAll();
            StringBuilder html = new StringBuilder("<h1>Lista koncertów</h1>");

            if (session != null && session.getAttribute("userId") != null) {
                html.append("<p>Zalogowano jako: <strong>")
                        .append(Html.escape((String) session.getAttribute("email")))
                        .append("</strong></p>")
                        .append("<form method='post' action='")
                        .append(path)
                        .append("/wyloguj'><button>Wyloguj</button></form>");
            } else {
                html.append("<p><a href='")
                        .append(path)
                        .append("/logowanie'>Zaloguj się</a></p>");
            }

            html.append("""
                    <table>
                        <thead>
                            <tr>
                                <th>Artysta</th><th>Festiwal</th><th>Scena</th>
                                <th>Miasto</th><th>Data</th><th>Godzina</th>
                            </tr>
                        </thead>
                        <tbody>
                    """);

            for (var row : rows) {
                html.append("<tr><td>").append(Html.escape(row.artysta()))
                        .append("</td><td>").append(Html.escape(row.festiwal()))
                        .append("</td><td>").append(Html.escape(row.scena()))
                        .append("</td><td>").append(Html.escape(row.miasto()))
                        .append("</td><td>").append(Html.escape(row.dataKoncertu()))
                        .append("</td><td>").append(Html.escape(row.godzina()))
                        .append("</td></tr>");
            }

            html.append("</tbody></table>");
            if (rows.isEmpty()) {
                html.append("<p>Nie ma jeszcze koncertów w bazie.</p>");
            }

            Html.send(response, "Lista koncertów", html.toString());
        } catch (SQLException e) {
            throw new ServletException("Błąd odczytu koncertów", e);
        }
    }
}
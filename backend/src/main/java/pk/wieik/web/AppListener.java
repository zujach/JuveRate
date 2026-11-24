package pk.wieik.web;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import pk.wieik.db.Database;
import pk.wieik.repository.UserRepository;

import java.io.IOException;
import java.sql.SQLException;

@WebListener
public class AppListener implements ServletContextListener {
    @Override
    public void contextInitialized(ServletContextEvent event) {
        try {
            Database.initialize();
            event.getServletContext().log("SQLite JuveRate: " + Database.getDatabaseFile());

            String email = System.getenv("adminemail");
            String password = System.getenv("adminpassword");

            if ((email == null) != (password == null)) {
                throw new IllegalStateException(
                        "Ustaw obie zmienne: adminemail i adminpassword");
            }

            UserRepository users = new UserRepository();
            if (email != null && users.countUsers() == 0) {
                users.createUser(email, password, "administrator");
                event.getServletContext().log("Utworzono pierwsze konto administratora");
            }
        } catch (IOException | SQLException e) {
            throw new IllegalStateException("Nie udało się zainicjalizować bazy JuveRate", e);
        }
    }
}
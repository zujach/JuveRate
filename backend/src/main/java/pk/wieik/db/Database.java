package pk.wieik.db;

import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public final class Database {
    private static final Path DB_FILE = Path.of(
            System.getProperty("catalina.base", System.getProperty("user.home")),
            "data", "juverate", "juverate.db"
    ).toAbsolutePath().normalize();

    private Database() {
    }

    public static Path getDatabaseFile() {
        return DB_FILE;
    }

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("org.sqlite.JDBC");
        } catch (ClassNotFoundException e) {
            throw new SQLException("Brakuje sterownika SQLite JDBC", e);
        }

        Connection connection = DriverManager.getConnection("jdbc:sqlite:" + DB_FILE);
        try (Statement statement = connection.createStatement()) {
            statement.execute("PRAGMA foreign_keys = ON");
            statement.execute("PRAGMA busy_timeout = 5000");
        } catch (SQLException e) {
            connection.close();
            throw e;
        }
        return connection;
    }

    public static void initialize() throws IOException, SQLException {
        Files.createDirectories(DB_FILE.getParent());

        String schema;
        try (InputStream input = Database.class.getResourceAsStream("/schemat.sql")) {
            if (input == null) {
                throw new IOException("Nie znaleziono schemat.sql w zasobach aplikacji");
            }
            schema = new String(input.readAllBytes(), StandardCharsets.UTF_8);
        }

        try (Connection connection = getConnection();
             Statement statement = connection.createStatement()) {
            connection.setAutoCommit(false);
            try {
                for (String command : schema.split(";")) {
                    if (!command.isBlank()) {
                        statement.execute(command.trim());
                    }
                }
                connection.commit();
            } catch (SQLException e) {
                connection.rollback();
                throw e;
            }
        }
    }
}
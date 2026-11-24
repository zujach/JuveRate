package pk.wieik.repository;

import pk.wieik.auth.PasswordUtil;
import pk.wieik.db.Database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Optional;

public class UserRepository {
    public record AuthUser(int id, String email, String rola) {}

    public int countUsers() throws SQLException {
        try (Connection connection = Database.getConnection();
             PreparedStatement ps = connection.prepareStatement(
                     "SELECT COUNT(*) FROM uzytkownicy");
             ResultSet rs = ps.executeQuery()) {
            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    public void createUser(String email, String password, String rola)
            throws SQLException {
        if (email == null || email.isBlank() || email.length() > 64) {
            throw new IllegalArgumentException("E-mail musi mieć od 1 do 64 znaków");
        }
        if (password == null || password.length() < 12) {
            throw new IllegalArgumentException("Hasło musi mieć co najmniej 12 znaków");
        }
        if (!"uzytkownik".equals(rola) && !"administrator".equals(rola)) {
            throw new IllegalArgumentException("Nieznana rola");
        }

        String sql = "INSERT INTO uzytkownicy (email, haslo_hash, rola) VALUES (?, ?, ?)";

        try (Connection connection = Database.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, email.trim());
            ps.setString(2, PasswordUtil.hashPassword(password));
            ps.setString(3, rola);
            ps.executeUpdate();
        }
    }

    public Optional<AuthUser> authenticate(String email, String password)
            throws SQLException {
        if (email == null || email.isBlank() || email.length() > 64
                || password == null) {
            return Optional.empty();
        }

        String sql = "SELECT id, email, haslo_hash, rola FROM uzytkownicy WHERE email = ?";

        try (Connection connection = Database.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, email.trim());

            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) {
                    return Optional.empty();
                }
                if (!PasswordUtil.verifyPassword(password, rs.getString("haslo_hash"))) {
                    return Optional.empty();
                }

                return Optional.of(new AuthUser(
                        rs.getInt("id"),
                        rs.getString("email"),
                        rs.getString("rola")
                ));
            }
        }
    }
}
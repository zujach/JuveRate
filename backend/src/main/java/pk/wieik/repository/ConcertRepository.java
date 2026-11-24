package pk.wieik.repository;

import pk.wieik.db.Database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ConcertRepository {
    public record ConcertRow(
            int id, String artysta, String festiwal, String scena,
            String miasto, String dataKoncertu, String godzina
    ) {}

    public List<ConcertRow> findAll() throws SQLException {
        String sql = """
                SELECT id, artysta, festiwal, scena, miasto, data_koncertu, godzina
                FROM katalog_koncertow
                ORDER BY id
                """;

        List<ConcertRow> rows = new ArrayList<>();

        try (Connection connection = Database.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                rows.add(new ConcertRow(
                        rs.getInt("id"),
                        rs.getString("artysta"),
                        rs.getString("festiwal"),
                        rs.getString("scena"),
                        rs.getString("miasto"),
                        rs.getString("data_koncertu"),
                        rs.getString("godzina")
                ));
            }
        }

        return rows;
    }
}
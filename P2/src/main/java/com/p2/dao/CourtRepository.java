package com.p2.dao;

import com.p2.model.*;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class CourtRepository {
    public boolean createCourt(Court court, Connection connection) throws SQLException {
        Statement statement = connection.createStatement();

        statement.executeUpdate("INSERT INTO court (number, venue_name, surface) VALUES " +
                "('" + court.getNumber() + "', " +
                "'" + court.getVenue().getName() + "', " +
                "'" + court.getSurface() + "')");

        statement.close();
        return true;
    }

    public SimpleCourt[] getCourts(Map<String, String> params, Connection connection) throws SQLException {
        Statement statement = connection.createStatement();
        List<SimpleCourt> courts = new ArrayList<>();

        StringBuilder whereQuery = new StringBuilder();
        int size = params.size();
        if (size > 0)
            whereQuery.append("WHERE ");

        for (Map.Entry<String, String> entry: params.entrySet()) {

            switch (entry.getKey()) {
                case "number":
                    whereQuery.append("number='").append(entry.getValue()).append("'");
                    if (size > 1)
                        whereQuery.append(" AND ");
                    break;
                case "venue":
                    whereQuery.append("venue_name='").append(entry.getValue()).append("'");
                    if (size > 1)
                        whereQuery.append(" AND ");
                    break;
                case "surface":
                    whereQuery.append("surface='").append(entry.getValue()).append("'");
                    if (size > 1)
                        whereQuery.append(" AND ");
                    break;
                default:
                    throw new SQLException();
            }
            size--;
        }

        ResultSet rs = statement.executeQuery("SELECT * FROM court " + whereQuery);
        while(rs.next()) {
            courts.add(new SimpleCourt(rs.getInt("number"), rs.getString("surface")));
        }

        statement.close();

        return courts.toArray(new SimpleCourt[0]);
    }
}

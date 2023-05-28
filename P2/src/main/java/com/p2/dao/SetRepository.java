package com.p2.dao;

import com.p2.model.CourtNumber;
import com.p2.model.Match;
import com.p2.model.Set;
import com.p2.model.SimpleVenue;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class SetRepository {
    public boolean createSet(Set[] sets, Connection connection) throws SQLException {
        Statement statement = connection.createStatement();
        if (sets.length < 2 || sets.length > 4) {
            throw new SQLException();
        }

        for (Set set : sets) {
            statement.executeUpdate("INSERT INTO played_set (match_id, set_number, p1_games_won, p2_games_won) VALUES " +
                    "('" + set.getId() + "', " +
                    "'" + set.getSetNumber() + "', " +
                    "'" + set.getP1Score() + "', " +
                    "'" + set.getP2Score() + "')");
        }

        statement.close();
        return true;
    }

    public Set[] getSets(Map<String, String> params, Connection connection) throws SQLException {
        Statement statement = connection.createStatement();
        StringBuilder whereQuery = new StringBuilder();
        int size = params.size();
        if (size > 0)
            whereQuery.append("WHERE ");

        for (Map.Entry<String, String> entry: params.entrySet()) {

            switch (entry.getKey()) {
                case "id":
                    whereQuery.append("match_id='").append(entry.getValue()).append("'");
                    if (size > 1)
                        whereQuery.append(" AND ");
                    break;
                case "set-number":
                    whereQuery.append("set_number='").append(entry.getValue()).append("'");
                    if (size > 1)
                        whereQuery.append(" AND ");
                    break;
                case "p1-score":
                    whereQuery.append("p1_games_won='").append(entry.getValue()).append("'");
                    if (size > 1)
                        whereQuery.append(" AND ");
                    break;
                case "p2-score":
                    whereQuery.append("p2_games_won='").append(entry.getValue()).append("'");
                    if (size > 1)
                        whereQuery.append(" AND ");
                    break;
                default:
                    throw new SQLException();
            }
            size--;
        }

        ResultSet rs = statement.executeQuery("SELECT * FROM played_set " + whereQuery);
        List<Set> sets = new ArrayList<>();

        while (rs.next()) {
            sets.add(new Set(
                    rs.getInt("match_id"),
                    rs.getInt("set_number"),
                    rs.getInt("p1_games_won"),
                    rs.getInt("p2_games_won"))
            );
        }

        statement.close();
        return sets.toArray(new Set[0]);
    }
}

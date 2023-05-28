package com.p2.dao;

import com.p2.model.*;

import javax.swing.plaf.nimbus.State;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class MatchRepository {
    public boolean createMatch(Match match, Connection connection) throws SQLException {
        Statement statement = connection.createStatement();
        statement.executeUpdate("INSERT INTO played_match (p1_email, p2_email, date_played, court_number, venue_name) VALUES " +
                "('" + match.getP1Email() + "', " +
                "'" + match.getP2Email() + "', " +
                "STR_TO_DATE('" + match.getDatePlayed() + "', '%d/%m/%Y'), " +
                "'" + match.getCourt().getNumber() + "', " +
                "'" + match.getVenue().getName() + "')");

        statement.close();
        return true;
    }

    public boolean createFullMatch(FullMatch match, Connection connection) throws SQLException, SQLTransientConnectionException {
        Statement statement = connection.createStatement();

        int setsNumber = match.getSet().length;
        String setScoreHelper = "";

        switch (setsNumber) {
            case 1:
                setScoreHelper += match.getSet()[0].getSetNumber() + ", " + match.getSet()[0].getP1Score() + ", " + match.getSet()[0].getP2Score() + ", NULL, NULL, NULL, NULL, NULL, NULL";
                break;
            case 2:
                setScoreHelper += match.getSet()[0].getSetNumber() + ", " + match.getSet()[0].getP1Score() + ", " + match.getSet()[0].getP2Score() + ", " + match.getSet()[1].getSetNumber() + ", " + match.getSet()[1].getP1Score() + ", " + match.getSet()[1].getP2Score() + ", NULL, NULL, NULL";
                break;
            case 3:
                setScoreHelper += match.getSet()[0].getSetNumber() + ", " + match.getSet()[0].getP1Score() + ", " + match.getSet()[0].getP2Score() + ", " + match.getSet()[1].getSetNumber() + ", " + match.getSet()[1].getP1Score() + ", " + match.getSet()[1].getP2Score() + ", " + match.getSet()[2].getSetNumber() + ", " + match.getSet()[2].getP1Score() + ", " + match.getSet()[2].getP2Score();
                break;
        }

        statement.executeUpdate("CALL proc_add_match('" + match.getP1Email() + "', '" + match.getP2Email() + "', " + "STR_TO_DATE('" + match.getDatePlayed() + "', '%d/%m/%Y'), '" + match.getCourt().getVenue().getName() + "', '" + match.getCourt().getNumber() + "', " + setScoreHelper + ")");


        statement.close();
        return true;
    }

    public Match[] getMatches(Map<String, String> params, Connection connection) throws SQLException {
        Statement statement = connection.createStatement();

        StringBuilder whereQuery = new StringBuilder();
        int size = params.size();
        if (size > 0)
            whereQuery.append("WHERE ");

        for (Map.Entry<String, String> entry : params.entrySet()) {

            switch (entry.getKey()) {
                case "p1-email":
                    whereQuery.append("p1_email='").append(entry.getValue()).append("'");
                    if (size > 1)
                        whereQuery.append(" AND ");
                    break;
                case "p2-email":
                    whereQuery.append("p2_email='").append(entry.getValue()).append("'");
                    if (size > 1)
                        whereQuery.append(" AND ");
                    break;
                case "date":
                    whereQuery.append("date_played='").append(entry.getValue()).append("'");
                    if (size > 1)
                        whereQuery.append(" AND ");
                    break;
                case "court":
                    whereQuery.append("court_number='").append(entry.getValue()).append("'");
                    if (size > 1)
                        whereQuery.append(" AND ");
                    break;
                case "venue":
                    whereQuery.append("venue_name='").append(entry.getValue()).append("'");
                    if (size > 1)
                        whereQuery.append(" AND ");
                    break;
                case "id":
                    whereQuery.append("id='").append(entry.getValue()).append("'");
                    if (size > 1)
                        whereQuery.append(" AND ");
                    break;
                default:
                    throw new SQLException();
            }
            size--;
        }

        ResultSet rs = statement.executeQuery("SELECT * FROM played_match " + whereQuery);
        List<Match> matches = new ArrayList<>();

        while (rs.next()) {
            matches.add(new Match(
                    rs.getInt("id"),
                    rs.getString("p1_email"),
                    rs.getString("p2_email"),
                    rs.getString("date_played"),
                    new CourtNumber(rs.getInt("court_number")),
                    new SimpleVenue(rs.getString("venue_name"))
            ));
        }
        statement.close();

        return matches.toArray(new Match[0]);
    }

    public FullMatch[] getMatchesSearch(Map<String, String> params, Connection connection) throws SQLException {
        Statement statement = connection.createStatement();

        StringBuilder whereQuery = new StringBuilder();
        int size = params.size();
        if (size > 0)
            whereQuery.append("WHERE ");

        for (Map.Entry<String, String> entry : params.entrySet()) {

            switch (entry.getKey()) {
                case "p1-email":
                    whereQuery.append("p1_email='").append(entry.getValue()).append("'");
                    if (size > 1)
                        whereQuery.append(" AND ");
                    break;
                case "p2-email":
                    whereQuery.append("p2_email='").append(entry.getValue()).append("'");
                    if (size > 1)
                        whereQuery.append(" AND ");
                    break;
                case "date":
                    whereQuery.append("date_played='").append(entry.getValue()).append("'");
                    if (size > 1)
                        whereQuery.append(" AND ");
                    break;
                case "court":
                    whereQuery.append("court_number='").append(entry.getValue()).append("'");
                    if (size > 1)
                        whereQuery.append(" AND ");
                    break;
                case "venue":
                    whereQuery.append("venue_name='").append(entry.getValue()).append("'");
                    if (size > 1)
                        whereQuery.append(" AND ");
                    break;
                case "id":
                    whereQuery.append("id='").append(entry.getValue()).append("'");
                    if (size > 1)
                        whereQuery.append(" AND ");
                    break;
                default:
                    throw new SQLException();
            }
            size--;
        }

        ResultSet rs = statement.executeQuery("SELECT * FROM played_match pm INNER JOIN played_set ps ON pm.id = ps.match_id INNER JOIN court c ON pm.court_number  = c.`number`  AND pm.venue_name = c.venue_name " + whereQuery + " ORDER BY date_played DESC");
        List<FullMatch> matches = new ArrayList<>();
        List<SimpleSet> sets = new ArrayList<>();

        int prevID = 0;
        String prevP1 = "";
        String prevP2 = "";
        String prevDate = "";
        Court prevCourt = null;

        while (rs.next()) {
            int currentID = rs.getInt("id");

            if (currentID != prevID && prevID != 0) {
                matches.add(new FullMatch(
                        prevID,
                        prevP1,
                        prevP2,
                        prevDate,
                        prevCourt,
                        sets.toArray(new SimpleSet[0]))
                );

                sets = new ArrayList<>();
            }

            prevID = rs.getInt("id");
            prevP1 = rs.getString("p1_email");
            prevP2 = rs.getString("p2_email");
            prevDate = rs.getString("date_played");
            prevCourt = new Court(rs.getInt("court_number"), rs.getString("surface"), new SimpleVenue(rs.getString("venue_name")));
            sets.add(new SimpleSet(rs.getInt("set_number"), rs.getInt("p1_games_won"), rs.getInt("p2_games_won")));
        }

        matches.add(new FullMatch(
                prevID,
                prevP1,
                prevP2,
                prevDate,
                prevCourt,
                sets.toArray(new SimpleSet[0]))
        );

        statement.close();

        return matches.toArray(new FullMatch[0]);
    }

    public int getMatchIndex(Connection connection) throws SQLException {
        Statement statement = connection.createStatement();

        ResultSet rs = statement.executeQuery("SELECT id FROM played_match ORDER BY id DESC LIMIT 1");
        int index = 0;

        if (rs.next()) {
            index = rs.getInt("id");
        }
        statement.close();

        return index;
    }

    public MatchWithNames[] getMatchWithNames(Map<String, String> params, Connection connection) throws SQLException {
        Statement statement = connection.createStatement();

        List<MatchWithNames> matches = new ArrayList<>();

        StringBuilder whereQuery = new StringBuilder();
        int size = params.size();
        int solidSize = size;
        if (size > 0) {
            whereQuery.append("WHERE ");
        }

        for (Map.Entry<String, String> entry : params.entrySet()) {
            switch (entry.getKey()) {
                case "full_name":
                    if (size > 1)
                        whereQuery.append("(");
                    if (solidSize > 1 && size == 1)
                        whereQuery.append("(");
                    whereQuery.append("full_name='").append(entry.getValue()).append("'");
                    if (size > 1)
                        whereQuery.append(") AND ");
                    if (solidSize > 1 && size == 1)
                        whereQuery.append(")");
                    break;
                case "date":
                    if (size > 1)
                        whereQuery.append("(");
                    whereQuery.append("date_played='").append(entry.getValue()).append("'");
                    if (size > 1)
                        whereQuery.append(") AND ");
                    if (solidSize > 1 && size == 1)
                        whereQuery.append(")");
                    break;
                case "court":
                    if (size > 1)
                        whereQuery.append("(");
                    if (solidSize > 1 && size == 1)
                        whereQuery.append("(");
                    if (entry.getValue().contains(",")) {
                        String[] courts = entry.getValue().split(",");
                        int cSize = courts.length;
                        for (int i = 0; i < cSize; i++) {
                            whereQuery.append("court_number='").append(courts[i]);
                            if (i != cSize - 1) {
                                whereQuery.append("' OR ");
                            }
                        }
                        whereQuery.append("'");
                    } else {
                        whereQuery.append("court_number='").append(entry.getValue()).append("'");
                    }

                    if (size > 1)
                        whereQuery.append(") AND ");
                    if (solidSize > 1 && size == 1)
                        whereQuery.append(")");
                    break;
                case "venue":
                    if (size > 1)
                        whereQuery.append("(");
                    if (solidSize > 1 && size == 1)
                        whereQuery.append("(");
                    if (entry.getValue().contains(",")) {
                        String[] venues = entry.getValue().split(",");
                        int vSize = venues.length;
                        for (int i = 0; i < vSize; i++) {
                            whereQuery.append("venue_name='").append(venues[i]);
                            if (i != vSize - 1) {
                                whereQuery.append("' OR ");
                            }
                        }
                        whereQuery.append("'");
                    } else {
                        whereQuery.append("venue_name='").append(entry.getValue()).append("'");
                    }
                    if (size > 1)
                        whereQuery.append(") AND ");
                    if (solidSize > 1 && size == 1)
                        whereQuery.append(")");
                    break;
                case "surface":
                    if (size > 1)
                        whereQuery.append("(");
                    if (solidSize > 1 && size == 1)
                        whereQuery.append("(");
                    if (entry.getValue().contains(",")) {
                        String[] surfaces = entry.getValue().split(",");
                        int sSize = surfaces.length;
                        for (int i = 0; i < sSize; i++) {
                            whereQuery.append("surface='").append(surfaces[i]);
                            if (i != sSize - 1) {
                                whereQuery.append("' OR ");
                            }
                        }
                        whereQuery.append("'");
                    } else {
                        whereQuery.append("surface='").append(entry.getValue()).append("'");
                    }
                    System.out.println(whereQuery);
                    if (size > 1)
                        whereQuery.append(") AND ");
                    if (solidSize > 1 && size == 1)
                        whereQuery.append(")");
                    break;
                default:
                    throw new SQLException();
            }
            size--;
        }
        ResultSet rs = statement.executeQuery("SELECT id, email, date_played,court_number,venue_name, full_name, elo, surface, GET_WIN_OF_MATCH(id) AS winner  FROM view_match_with_winner_surface pm JOIN view_player_details p ON pm.p1_email = p.email OR pm.p2_email = p.email " + whereQuery + " ORDER BY pm.id DESC, pm.date_played DESC");
        MatchWithNames match;
        while (rs.next()) {
            match = new MatchWithNames(
                    rs.getInt("id"),
                    rs.getString("email"),
                    rs.getString("date_played"),
                    rs.getInt("court_number"),
                    rs.getString("venue_name"),
                    rs.getString("full_name"),
                    rs.getInt("elo"),
                    rs.getString("surface"),
                    rs.getString("winner")
            );

            matches.add(match);
        }

        return matches.toArray(new MatchWithNames[0]);
    }
}

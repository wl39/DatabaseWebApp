package com.p2.database;

import com.p2.dao.*;
import com.p2.model.*;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.SQLTransientConnectionException;
import java.util.Map;

public class Database {
    private static final String MARIADB_URL = "jdbc:mariadb://wl39.host.cs.st-andrews.ac.uk:3306/wl39_CS3101_P2_dump";
    private static final String MARIADB_USERNAME = "wl39";
    private static final String MARIADB_PASSWORD = "dw8Y9b1YudE.5R";

    Connection connection = null;

    PlayerRepository pr = new PlayerRepository();
    VenueRepository vr = new VenueRepository();
    CourtRepository cr = new CourtRepository();
    MatchRepository mr = new MatchRepository();
    SetRepository sr = new SetRepository();

    /**
     * Create connection between spring boot and MariaDB
     *
     * @return connection
     */
    public Connection createConnection() {
        try {
            return DriverManager.getConnection(MARIADB_URL, MARIADB_USERNAME, MARIADB_PASSWORD);
        } catch (SQLException e) {
            System.out.println("Create Connection Error!");

            e.printStackTrace();
        }

        return null;
    }

    public void closeConnection(Connection connection) {
        try {
            connection.close();
        } catch (SQLException e) {
            System.out.println("Connection close failed!");
            e.printStackTrace();
        }
    }

    public void accessDB() {
        connection = createConnection();
    }

    public boolean createPlayer(Player player) throws SQLException, SQLTransientConnectionException {
        Connection connection = createConnection();

        boolean result = pr.createPlayer(player, connection);
        closeConnection(connection);

        return result;
    }

    public boolean editELO(Player player, int elo) throws SQLException {
        Connection connection = createConnection();

        boolean result = pr.editELO(player, elo, connection);
        closeConnection(connection);

        return result;
    }

    public Phone[] getPhones(String email) throws SQLException {
        Connection connection = createConnection();

        Phone[] phones = pr.getPhones(email, connection);
        closeConnection(connection);

        return phones;
    }

    public Player[] getPlayer(Map<String, String> params) throws SQLException {
        Connection connection = createConnection();

        Player[] players = pr.getPlayer(params, connection);
        closeConnection(connection);

        return players;
    }

    public FullNameElo getPlayerFullName(String email) throws SQLException {
        Connection connection = createConnection();

        FullNameElo fullName = pr.getPlayerFullName(email, connection);
        closeConnection(connection);

        return fullName;
    }

    public SimplePlayer[] getSimplePlayers() throws SQLException {
        Connection connection = createConnection();

        SimplePlayer[] simplePlayers = pr.getSimplePlayers(connection);
        closeConnection(connection);

        return simplePlayers;
    }

    public ViewPlayer[] getViewPlayers() throws SQLException {
        Connection connection = createConnection();

        ViewPlayer[] viewPlayers = pr.getViewPlayers(connection);
        closeConnection(connection);

        return viewPlayers;
    }

    public boolean createVenue(Venue venue) throws SQLException {
        Connection connection = createConnection();
        boolean result = vr.createVenue(venue, connection);
        closeConnection(connection);
        return result;
    }

    public Venue[] getVenues() throws SQLException {
        Connection connection = createConnection();

        Venue[] venues = vr.getVenues(connection);
        closeConnection(connection);

        return venues;
    }


    public boolean createCourt(Court court) throws SQLException {
        Connection connection = createConnection();
        boolean result = cr.createCourt(court, connection);
        closeConnection(connection);

        return result;
    }

    public SimpleCourt[] getCourts(Map<String, String> params) throws SQLException {
        Connection connection = createConnection();

        SimpleCourt[] courts = cr.getCourts(params, connection);
        closeConnection(connection);

        return courts;
    }


    public boolean createMatch(Match match) throws SQLException {
        Connection connection = createConnection();
        boolean result = mr.createMatch(match, connection);
        closeConnection(connection);

        return result;
    }

    public boolean createFullMatch(FullMatch match) throws SQLException, SQLTransientConnectionException {
        Connection connection = createConnection();
        boolean result = mr.createFullMatch(match, connection);
        closeConnection(connection);

        return result;
    }

    public Match[] getMatches(Map<String, String> params) throws SQLException {
        Connection connection = createConnection();
        Match[] matches = mr.getMatches(params, connection);
        closeConnection(connection);

        return matches;
    }

    public boolean createSet(Set[] set) throws SQLException {
        Connection connection = createConnection();
        boolean result = sr.createSet(set, connection);
        closeConnection(connection);

        return result;
    }

    public Set[] getSets(Map<String, String> params) throws SQLException {
        Connection connection = createConnection();
        Set[] sets = sr.getSets(params, connection);
        closeConnection(connection);

        return sets;
    }

    public FullMatch[] getMatchesSearch(Map<String, String> params) throws SQLException {
        Connection connection = createConnection();
        FullMatch[] matches = mr.getMatchesSearch(params, connection);
        closeConnection(connection);

        return matches;
    }

    public int getMatchIndex() throws SQLException {
        Connection connection = createConnection();
        int index = mr.getMatchIndex(connection);
        closeConnection(connection);

        return index;
    }

    public MatchWithNames[] getMatchWithNames(Map<String, String> params) throws SQLException {
        Connection connection = createConnection();
        MatchWithNames[] matches = mr.getMatchWithNames(params, connection);
        closeConnection(connection);

        return matches;
    }
}

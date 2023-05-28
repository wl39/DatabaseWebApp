package com.p2.dao;

import com.p2.model.*;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class PlayerRepository {
    public boolean createPlayer(Player player, Connection connection) throws SQLException, SQLTransientConnectionException {
        Statement statement = null;

        statement = connection.createStatement();

        StringBuilder middleNames = new StringBuilder();

        for (int i = 0; i < player.getMiddleNames().length; i++) {
            if (i == player.getMiddleNames().length - 1) {
                middleNames.append(player.getMiddleNames()[i]);
            } else {
                middleNames.append(player.getMiddleNames()[i]).append(",");
            }
        }

        for (Phone phone : player.phones) {
            Pattern pattern = Pattern.compile("^[0-9]{11}$");
            Matcher matcher = pattern.matcher(phone.phoneNumber);

            if (!matcher.find()) {
                throw new SQLException("Bad phone number", "45001");
            }
        }

        statement.executeUpdate("INSERT INTO player (email, forename, middlenames, surname, date_of_birth, elo) VALUES " +
                "('" + player.getEmail() + "', " +
                "'" + player.getForename() + "', " +
                "'" + middleNames + "', " +
                "'" + player.getSurname() + "', " +
                "STR_TO_DATE('" + player.getDateOfBirth() + "', '%d/%m/%Y'), " +
                "'" + player.getElo() + "')");

        for (Phone phone : player.phones) {

            statement.executeUpdate("INSERT INTO player_phone (email, phone_number, phone_type) VALUES " +
                    "('" + player.getEmail() + "', " +
                    "'" + phone.getPhoneNumber() + "', " +
                    "'" + phone.getPhoneType() + "')");

        }

        statement.close();
        return true;
    }

    public boolean editELO(Player player, int elo, Connection connection) throws SQLException {
        Statement statement = connection.createStatement();
        statement.execute("UPDATE player SET player.elo = '" + elo + "' WHERE (player.email ='" + player.getEmail() + "')");
        statement.close();
        return true;
    }

    public Player[] getPlayer(Map<String, String> params, Connection connection) throws SQLException {
        Statement statement = connection.createStatement();
        List<Phone> phones = new ArrayList<>();
        List<Player> players = new ArrayList<>();
        Player player = null;

        String pEmail = "";
        String forename = "";
        String[] middlenames = null;
        String surname = "";
        String date_of_birth = "";
        int elo = 0;

        StringBuilder whereQuery = new StringBuilder();
        int size = params.size();
        if (size > 0)
            whereQuery.append("WHERE ");

        for (Map.Entry<String, String> entry : params.entrySet()) {

            switch (entry.getKey()) {
                case "email":
                    whereQuery.append("email='").append(entry.getValue()).append("'");
                    if (size > 1)
                        whereQuery.append(" AND ");
                    break;
                case "forename":
                    whereQuery.append("forename='").append(entry.getValue()).append("'");
                    if (size > 1)
                        whereQuery.append(" AND ");
                    break;
                case "surname":
                    whereQuery.append("surname='").append(entry.getValue()).append("'");
                    if (size > 1)
                        whereQuery.append(" AND ");
                    break;
                case "dateOfBrith":
                    whereQuery.append("date_of_birth='").append(entry.getValue()).append("'");
                    if (size > 1)
                        whereQuery.append(" AND ");
                    break;
                case "elo":
                    whereQuery.append("elo='").append(entry.getValue()).append("'");
                    if (size > 1)
                        whereQuery.append(" AND ");
                    break;
                default:
                    throw new SQLException();
            }
            size--;
        }

        ResultSet rs = statement.executeQuery("SELECT * FROM player p INNER JOIN player_phone pp ON p.email=pp.email " + whereQuery + " ORDER BY p.email");

        while (rs.next()) {
            String currentEmail = rs.getString("email");

            if (!currentEmail.equals(pEmail) && !pEmail.equals("")) {
                players.add(new Player(pEmail, forename, middlenames, surname, date_of_birth, phones.toArray(new Phone[0]), elo));
                phones = new ArrayList<>();
            }

            pEmail = rs.getString("email");
            forename = rs.getString("forename");
            middlenames = rs.getString("middlenames").split(",");
            surname = rs.getString("surname");
            date_of_birth = rs.getString("date_of_birth");
            elo = rs.getInt("elo");
            phones.add(new Phone(rs.getString("phone_number"), rs.getString("phone_type")));
        }

        players.add(new Player(pEmail, forename, middlenames, surname, date_of_birth, phones.toArray(new Phone[0]), elo));

        return players.toArray(new Player[0]);
    }

    public FullNameElo getPlayerFullName(String email, Connection connection) throws SQLException {
        Statement statement = connection.createStatement();

        FullNameElo fullNameElo = null;

        ResultSet rs = statement.executeQuery("SELECT full_name, elo FROM view_player_details vpd WHERE vpd.email = '" + email + "'");
        while (rs.next()) {
            fullNameElo = new FullNameElo(rs.getString("full_name"), rs.getInt("elo"));
        }
        return fullNameElo;
    }

    public Phone[] getPhones(String email, Connection connection) throws SQLException {
        Statement statement = connection.createStatement();
        List<Phone> phones = new ArrayList<>();
        String number;
        String type;

        ResultSet rs = statement.executeQuery("SELECT * FROM player_phone WHERE email ='" + email + "'");
        while (rs.next()) {
            number = rs.getString("phone_number");
            type = rs.getString("phone_type");

            Phone phone = new Phone(number, type);
            phones.add(phone);
        }

        Phone[] p = new Phone[phones.size()];
        phones.toArray(p);

        return p;
    }

    public SimplePlayer[] getSimplePlayers(Connection connection) throws SQLException {
        Statement statement = connection.createStatement();
        List<SimplePlayer> simplePlayers = new ArrayList<>();

        ResultSet rs = statement.executeQuery("SELECT email, surname FROM player");
        while (rs.next()) {
            String email = rs.getString("email");
            String surname = rs.getString("surname");

            simplePlayers.add(new SimplePlayer(email, surname));
        }

        return simplePlayers.toArray(new SimplePlayer[0]);
    }

    public ViewPlayer[] getViewPlayers(Connection connection) throws SQLException {
        Statement statement = connection.createStatement();
        List<ViewPlayer> viewPlayers = new ArrayList<>();

        ResultSet rs = statement.executeQuery("SELECT * FROM view_player_details");
        while (rs.next()) {
            String fullName = rs.getString("full_name");
            String email = rs.getString("email");
            String dateOfBirth = rs.getString("date_of_birth");
            int elo = rs.getInt("elo");
            String phoneNumber = rs.getString("phone_numbers");

            viewPlayers.add(new ViewPlayer(fullName, email, dateOfBirth, elo, phoneNumber));
        }

        return viewPlayers.toArray(new ViewPlayer[0]);
    }
}

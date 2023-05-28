package com.p2.dao;

import com.p2.model.Venue;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class VenueRepository {

    public boolean createVenue(Venue venue, Connection connection) throws SQLException {
        Statement statement = connection.createStatement();
        statement.executeUpdate("INSERT INTO venue (name, address) VALUES " +
                "('" + venue.getName() + "', " +
                "'" + venue.getAddress() + "')");
        statement.close();
        return true;
    }

    public Venue[] getVenues(Connection connection) throws SQLException {
        Statement statement = connection.createStatement();
        ResultSet rs = statement.executeQuery("SELECT * FROM venue");

        List<Venue> venues = new ArrayList<>();

        while (rs.next()) {
            String vName = rs.getString("name");
            String address = rs.getString("address");

            venues.add(new Venue(vName, address));
        }

        statement.close();
        return venues.toArray(new Venue[0]);
    }
}

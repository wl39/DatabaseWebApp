package com.p2.controller;

import com.p2.database.Database;
import com.p2.model.Venue;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.sql.SQLException;

@RestController
public class VenueServiceController {
    Database database = new Database();

    @RequestMapping(value="/api/venue/create", method = RequestMethod.POST)
    public ResponseEntity<Object> createVenue(@RequestBody Venue venue) {
        boolean result = false;
        try {
            result = database.createVenue(venue);
            return new ResponseEntity<>(result, HttpStatus.OK);
        } catch (SQLException e) {
            e.printStackTrace();
            return new ResponseEntity<>("SQL syntax error", HttpStatus.BAD_REQUEST);
        }
    }

    @RequestMapping(value="/api/venue/get", method = RequestMethod.GET)
    public ResponseEntity<Object> getVenues() {
        try {

            return new ResponseEntity<>(database.getVenues(), HttpStatus.OK);
        } catch (SQLException e) {
            e.printStackTrace();
            return new ResponseEntity<>("SQL syntax error", HttpStatus.BAD_REQUEST);
        }
    }
}

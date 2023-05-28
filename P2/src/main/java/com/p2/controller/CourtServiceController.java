package com.p2.controller;

import com.p2.database.Database;
import com.p2.model.Court;
import com.p2.model.SimpleCourt;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.sql.SQLException;
import java.util.Map;

@RestController
public class CourtServiceController {
    Database database = new Database();

    @RequestMapping(value="/api/court/create", method = RequestMethod.POST)
    public ResponseEntity<Object> createCourt(@RequestBody Court court) {
        boolean result = false;
        try {
            result = database.createCourt(court);
            return new ResponseEntity<>(result, HttpStatus.OK);
        } catch (SQLException e) {
            e.printStackTrace();
            return new ResponseEntity<>("SQL syntax error", HttpStatus.BAD_REQUEST);
        }
    }

    @RequestMapping(value="/api/court/get", method = RequestMethod.GET)
    public ResponseEntity<Object> getCourts(@RequestParam Map<String, String> params) {
        SimpleCourt[] courts;
        try {
            courts = database.getCourts(params);
            return new ResponseEntity<>(courts, HttpStatus.OK);
        } catch (SQLException e) {
            e.printStackTrace();
            return new ResponseEntity<>("SQL syntax error", HttpStatus.BAD_REQUEST);
        }
    }
}

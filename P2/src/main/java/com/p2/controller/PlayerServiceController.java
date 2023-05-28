package com.p2.controller;

import com.p2.database.Database;
import com.p2.model.*;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.sql.SQLException;
import java.util.Map;

@RestController
public class PlayerServiceController {
    Database database = new Database();

    @RequestMapping(value="/api/player/create", method = RequestMethod.POST)
    public ResponseEntity<Object> createPlayer(@RequestBody Player player) {
        boolean result = false;
        try {
            result = database.createPlayer(player);
            return new ResponseEntity<>(result, HttpStatus.OK);
        } catch (SQLException e) {
            e.printStackTrace();
            switch (e.getSQLState()) {
                case "450002":
                    return new ResponseEntity<>("Bad phone type", HttpStatus.BAD_REQUEST);
                case "450001":
                    return new ResponseEntity<>("Bad phone number", HttpStatus.BAD_REQUEST);
                case "23000":
                    return new ResponseEntity<>("The email is already being used", HttpStatus.BAD_REQUEST);
                case "HY000":
                    return new ResponseEntity<>("Wrong date format", HttpStatus.BAD_REQUEST);
                default:
                    return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
            }
        } catch (NullPointerException e ) {
            return new ResponseEntity<>("Some fields are missing", HttpStatus.BAD_REQUEST);
        }
    }

    @RequestMapping(value="/api/player/change/elo", method = RequestMethod.PUT)
    public ResponseEntity<Object> editELO(@RequestHeader(value = "ELO") int elo, @RequestBody Player player) {
        boolean result = false;
        try {
            result = database.editELO(player, elo);
            return new ResponseEntity<>(result, HttpStatus.OK);
        } catch (SQLException e) {
            e.printStackTrace();
            return new ResponseEntity<>("SQL syntax error", HttpStatus.BAD_REQUEST);
        }
    }

    @RequestMapping(value="/api/player/get/phones", method = RequestMethod.GET)
    public ResponseEntity<Object> getPhones(@RequestParam(value = "email") String email) {
        Phone[] phones;
        try {
            phones = database.getPhones(email);
            return new ResponseEntity<>(phones, HttpStatus.OK);
        } catch (SQLException e) {
            e.printStackTrace();
            return new ResponseEntity<>("SQL syntax error", HttpStatus.BAD_REQUEST);
        }
    }

    @RequestMapping(value="/api/player/get", method = RequestMethod.GET)
    public ResponseEntity<Object> getPlayer(@RequestParam Map<String, String> params) {
        Player[] players;
        try {
            players = database.getPlayer(params);
            return new ResponseEntity<>(players, HttpStatus.OK);
        } catch (SQLException e) {
            e.printStackTrace();
            return new ResponseEntity<>("SQL syntax error", HttpStatus.BAD_REQUEST);
        }
    }

    @RequestMapping(value="/api/player/get/name", method = RequestMethod.GET)
    public ResponseEntity<Object> getPlayerFullName(@RequestParam String email) {
        FullNameElo fullName;
        try {
            fullName = database.getPlayerFullName(email);
            return new ResponseEntity<>(fullName, HttpStatus.OK);
        } catch (SQLException e) {
            e.printStackTrace();
            return new ResponseEntity<>("SQL syntax error", HttpStatus.BAD_REQUEST);
        }
    }

    @RequestMapping(value="/api/player/simple/get", method = RequestMethod.GET)
    public ResponseEntity<Object> getSimplePlayers() {
        SimplePlayer[] simplePlayers;
        try {
            simplePlayers = database.getSimplePlayers();
            return new ResponseEntity<>(simplePlayers, HttpStatus.OK);
        } catch (SQLException e) {
            e.printStackTrace();
            return new ResponseEntity<>("SQL syntax error", HttpStatus.BAD_REQUEST);
        }
    }

    @RequestMapping(value="/api/player/view/get", method = RequestMethod.GET)
    public ResponseEntity<Object> getViewPlayers() {
        ViewPlayer[] viewPlayers;
        try {
            viewPlayers = database.getViewPlayers();
            return new ResponseEntity<>(viewPlayers, HttpStatus.OK);
        } catch (SQLException e) {
            e.printStackTrace();
            return new ResponseEntity<>("SQL syntax error", HttpStatus.BAD_REQUEST);
        }
    }
}

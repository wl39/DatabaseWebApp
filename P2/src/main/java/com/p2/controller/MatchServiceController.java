package com.p2.controller;

import com.p2.database.Database;
import com.p2.model.FullMatch;
import com.p2.model.Match;
import com.p2.model.MatchWithNames;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.sql.SQLException;
import java.sql.SQLTransientConnectionException;
import java.util.Map;

@RestController
public class MatchServiceController {
    Database database = new Database();

    @RequestMapping(value="/api/match/create", method = RequestMethod.POST)
    public ResponseEntity<Object> createMatch(@RequestBody Match match) {
        boolean result = false;

        try {
            result = database.createMatch(match);
            return new ResponseEntity<>(result, HttpStatus.OK);
        } catch (SQLException e) {
            e.printStackTrace();
            return new ResponseEntity<>("SQL syntax error", HttpStatus.BAD_REQUEST);
        }
    }

    @RequestMapping(value="/api/match/full/create", method = RequestMethod.POST)
    public ResponseEntity<Object> createFullMatch(@RequestBody FullMatch match) {
        boolean result = false;

        try {
            result = database.createFullMatch(match);
            return new ResponseEntity<>(result, HttpStatus.OK);
        } catch (SQLException e) {
            e.printStackTrace();
            switch (e.getSQLState()) {
                case "45005":
                    return new ResponseEntity<>("Player 1 and Player 2 have to be different", HttpStatus.BAD_REQUEST);
                case "45001":
                    return new ResponseEntity<>("Bad match sets.", HttpStatus.BAD_REQUEST);
                case "HY000":
                    return new ResponseEntity<>("Wrong date format", HttpStatus.BAD_REQUEST);
                default:
                    return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
            }
        } catch (NullPointerException e ) {
            return new ResponseEntity<>("Some fields are missing", HttpStatus.BAD_REQUEST);
        }
    }

    @RequestMapping(value="/api/match/get", method = RequestMethod.GET)
    public ResponseEntity<Object> getMatches(@RequestParam Map<String, String> params) {
        try {
            Match[] matches;
            matches = database.getMatches(params);
            return new ResponseEntity<>(matches, HttpStatus.OK);
        } catch (SQLException e) {
            e.printStackTrace();
            return new ResponseEntity<>("SQL syntax error", HttpStatus.BAD_REQUEST);
        }
    }

    @RequestMapping(value="/api/match/search", method = RequestMethod.GET)
    public ResponseEntity<Object> getMatchesSearch(@RequestParam Map<String, String> params) {
        try {
            FullMatch[] matches;
            matches = database.getMatchesSearch(params);
            return new ResponseEntity<>(matches, HttpStatus.OK);
        } catch (SQLException e) {
            e.printStackTrace();
            return new ResponseEntity<>("SQL syntax error", HttpStatus.BAD_REQUEST);
        }
    }

    @RequestMapping(value="/api/match/index", method = RequestMethod.GET)
    public ResponseEntity<Object> getMatchIndex() {
        try {
            int index = database.getMatchIndex();
            return new ResponseEntity<>(index, HttpStatus.OK);
        } catch (SQLException e) {
            e.printStackTrace();
            return new ResponseEntity<>("SQL syntax error", HttpStatus.BAD_REQUEST);
        }
    }

    @RequestMapping(value="/api/match/get/withName", method = RequestMethod.GET)
    public ResponseEntity<Object> getMatchWithName(@RequestParam Map<String, String> params) {
        try {
            MatchWithNames[] matches = database.getMatchWithNames(params);
            return new ResponseEntity<>(matches, HttpStatus.OK);
        } catch (SQLException e) {
            e.printStackTrace();
            return new ResponseEntity<>("SQL syntax error", HttpStatus.BAD_REQUEST);
        }
    }
}

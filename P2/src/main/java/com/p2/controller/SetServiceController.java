package com.p2.controller;

import com.p2.database.Database;
import com.p2.model.Match;
import com.p2.model.Set;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.sql.SQLException;
import java.util.Map;

@RestController
public class SetServiceController {
    Database database = new Database();

    @RequestMapping(value="/api/set/create", method = RequestMethod.POST)
    public ResponseEntity<Object> createMatch(@RequestBody Set[] set) {
        boolean result = false;

        try {
            result = database.createSet(set);
            return new ResponseEntity<>(result, HttpStatus.OK);
        } catch (SQLException e) {
            e.printStackTrace();
            return new ResponseEntity<>("SQL syntax error", HttpStatus.BAD_REQUEST);
        }
    }

    @RequestMapping(value="/api/set/get", method = RequestMethod.GET)
    public ResponseEntity<Object> getMatches(@RequestParam Map<String, String> params) {
        try {
            Set[] sets;
            sets = database.getSets(params);
            return new ResponseEntity<>(sets, HttpStatus.OK);
        } catch (SQLException e) {
            e.printStackTrace();
            return new ResponseEntity<>("SQL syntax error", HttpStatus.BAD_REQUEST);
        }
    }
}

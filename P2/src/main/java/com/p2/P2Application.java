package com.p2;

import com.p2.database.Database;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class P2Application {

    public static void main(String[] args) {
        // specify database
        Database application = new Database();

        // check db is open
        application.accessDB();
        SpringApplication.run(P2Application.class, args);
    }

}

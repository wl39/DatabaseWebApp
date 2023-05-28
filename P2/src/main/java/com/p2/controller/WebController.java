package com.p2.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class WebController {
    @RequestMapping(value = {"/", "/match","/match/{id}","/player", "/admin"})
    public String index() {return "index.html";}
}

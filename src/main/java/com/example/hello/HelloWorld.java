package com.example.hello;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.ui.Model;

@Controller
public class HelloWorld {
    @GetMapping("/hello")
    public String start(Model model) {
        model.addAttribute("message", "Hello World");
        return "HelloWorld"; // これは src/main/resources/templates/HelloWorld.html を指します
    }
}

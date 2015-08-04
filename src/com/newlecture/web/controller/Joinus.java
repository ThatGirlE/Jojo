package com.newlecture.web.controller;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/joinus/*")
public class Joinus {
   
   
   @RequestMapping("login")
   public String login(Model model){
      
      
      return "/WEB-INF/view/joinus/login.jsp";
   }
}
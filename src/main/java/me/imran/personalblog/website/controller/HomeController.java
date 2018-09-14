
package me.imran.personalblog.website.controller;


import me.imran.personalblog.login.model.Login;
import me.imran.personalblog.login.util.VerifyRecaptcha;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.context.MessageSource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.*;




/**
 * @author Imran Hossain
 */

@Controller
public class HomeController {
    private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

    @Autowired
    private MessageSource messageSource;

    @Autowired
    VerifyRecaptcha verifyRecaptcha;

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        StringTrimmerEditor stringtrimmer = new StringTrimmerEditor(true);
        binder.registerCustomEditor(String.class, stringtrimmer);


    }


    @RequestMapping(value = {"", "/", "index.html"}, method = RequestMethod.GET)
    public String indexPage(Model model, Locale locale, HttpServletRequest request) {
        model.addAttribute("loginForm", new Login());
        model.addAttribute("page","registration");
        return "login/index";
    }



    @RequestMapping(value = {"fblogin.html"}, method = RequestMethod.GET)
    public  String fblogin(Model model,Locale locale,@RequestParam("user_name")String username,@RequestParam("user_email")String useremail ,HttpServletRequest request)
    {
        model.addAttribute("user_name",username);
        model.addAttribute("user_email",useremail);
        return "redirect:/apiregistration";
    }


  }


package com.fresh.FreshApp.ui;

import java.io.IOException;

import com.fresh.FreshApp.businessLogic.BusinessLogic;
import com.fresh.FreshApp.exception.AutorNullException;
import com.fresh.FreshApp.model.Utente;
import com.fresh.FreshApp.utils.Constants;
import com.fresh.FreshApp.utils.EmailUtils;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/toggleSeguiti")
public class ToggleSeguitiServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Utente userLogged = (Utente) req.getSession().getAttribute(Constants.USER_DATA_KEY);
            if (userLogged == null) {
                req.getRequestDispatcher("/jsp/public/login.jsp").forward(req, resp);
                return;
            }
            BusinessLogic bl = (BusinessLogic) getServletContext().getAttribute(Constants.BL_KEY);
            String usernameUserToFollow = req.getParameter(Constants.FOLLOW_UTENTE_KEY);
            String emailUserToFollow = req.getParameter(Constants.MAIL_KEY);
            Boolean isSeguito = bl.toggleSeguiti(userLogged, usernameUserToFollow);
            String destinatario = emailUserToFollow;
            String oggetto;
            String contenuto;
            if (isSeguito) {
                oggetto = "Nuovo homie !";
                contenuto = "il bro " + userLogged.getUsername() + " ha iniziato a seguirti";
            } else {
                oggetto = "Un falso in meno";
                contenuto = "quel traditore di " + userLogged.getUsername() + " ti ha tolto il follow";
            }
            EmailUtils.sendEmail(emailUserToFollow, oggetto, contenuto);
        } catch (AutorNullException e) {
            e.printStackTrace();
            req.setAttribute(Constants.AUTOR_NULL_KEY, e.getMessage());
            req.getRequestDispatcher("/jsp/public/login.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute(Constants.UNEXPECTED_ERROR_KEY, e.getMessage());
            req.getRequestDispatcher("/jsp/public/error.jsp").forward(req, resp);
        }
    }
}
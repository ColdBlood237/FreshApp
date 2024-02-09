package com.fresh.FreshApp.ui;

import java.io.IOException;
import java.util.List;

import com.fresh.FreshApp.businessLogic.BusinessLogic;
import com.fresh.FreshApp.exception.UserNonExistantException;
import com.fresh.FreshApp.model.Utente;
import com.fresh.FreshApp.utils.Constants;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/searchUsers")
public class SearchUsersServlet extends HttpServlet {

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
            String username = req.getParameter(Constants.USERNAME_KEY);
            List<Utente> utenti = bl.searchUsersByUsername(username);
            req.setAttribute(Constants.PROFILES_FOUND, utenti);
            req.getRequestDispatcher("jsp/private/search.jsp").forward(req, resp);
        } catch (UserNonExistantException e) {
            e.printStackTrace();
            req.setAttribute(Constants.USER_NON_EXISTANT_KEY, e.getMessage());
            req.getRequestDispatcher("/jsp/private/home.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute(Constants.UNEXPECTED_ERROR_KEY, e.getMessage());
            req.getRequestDispatcher("/jsp/public/error.jsp").forward(req, resp);
        }
    }
}
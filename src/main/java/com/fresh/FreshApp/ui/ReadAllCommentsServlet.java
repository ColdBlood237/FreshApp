package com.fresh.FreshApp.ui;

import java.io.IOException;
import java.util.List;

import com.fresh.FreshApp.businessLogic.BusinessLogic;
import com.fresh.FreshApp.model.Commento;
import com.fresh.FreshApp.utils.Constants;
import com.fresh.FreshApp.model.Utente;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/readAllComments")
public class ReadAllCommentsServlet extends HttpServlet {

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
            BusinessLogic businessLogic = (BusinessLogic) getServletContext().getAttribute(Constants.BL_KEY);
            List<Commento> commenti = businessLogic.retrieveComments();
            req.setAttribute(Constants.ALL_COMMENTS_KEY, commenti);
            req.getRequestDispatcher("/jsp/private/home.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute(Constants.UNEXPECTED_ERROR_KEY, e.getMessage());
            req.getRequestDispatcher("/jsp/public/error.jsp").forward(req, resp);

        }

    }
}

package com.fresh.FreshApp.ui;

import java.io.IOException;

import com.fresh.FreshApp.utils.Constants;
import com.fresh.FreshApp.businessLogic.*;
import com.fresh.FreshApp.model.Utente;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/deletePost")
public class DeletePostServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Utente userLoggato = (Utente) req.getSession().getAttribute(Constants.USER_DATA_KEY);
            if (userLoggato == null) {
                req.getRequestDispatcher("/jsp/public/login.jsp").forward(req, resp);
                return;
            }
            Integer idPost = Integer.parseInt(req.getParameter(Constants.POST_ID_KEY));
            BusinessLogic bl = (BusinessLogic) getServletContext().getAttribute(Constants.BL_KEY);
            bl.deletePost(idPost);
            resp.sendRedirect(req.getContextPath() + "/readAllPosts");
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute(Constants.UNEXPECTED_ERROR_KEY, e.getMessage());
            req.getRequestDispatcher("/jsp/public/error.jsp").forward(req, resp);
        }
    }
}
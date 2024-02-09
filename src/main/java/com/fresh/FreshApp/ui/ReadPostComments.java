package com.fresh.FreshApp.ui;

import java.io.IOException;

import com.fresh.FreshApp.businessLogic.BusinessLogic;
import com.fresh.FreshApp.model.Post;
import com.fresh.FreshApp.model.Utente;
import com.fresh.FreshApp.utils.Constants;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/readPostComments")
public class ReadPostComments extends HttpServlet {

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
            Integer postId;
            if (req.getParameter(Constants.POST_ID_KEY) == null) {
                postId = (Integer) req.getAttribute(Constants.POST_ID_KEY);
            } else {
                postId = Integer.parseInt(req.getParameter(Constants.POST_ID_KEY));
            }
            Post post = businessLogic.retrievePostById(postId);
            if (post == null) {
                req.getRequestDispatcher("/jsp/public/error.jsp").forward(req, resp);
                return;
            }
            req.setAttribute(Constants.POST_DATA_KEY, post);
            req.getRequestDispatcher("/jsp/private/comments.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            req.getRequestDispatcher("/jsp/public/error.jsp").forward(req, resp);
        }
    }
}

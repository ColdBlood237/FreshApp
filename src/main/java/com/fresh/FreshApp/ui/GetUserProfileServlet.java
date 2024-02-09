package com.fresh.FreshApp.ui;

import java.io.IOException;
import java.util.List;

import com.fresh.FreshApp.businessLogic.BusinessLogic;
import com.fresh.FreshApp.exception.UserNonExistantException;
import com.fresh.FreshApp.model.Utente;
import com.fresh.FreshApp.model.Post;
import com.fresh.FreshApp.utils.Constants;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/getUserProfile")
public class GetUserProfileServlet extends HttpServlet {

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
            String userEmail = req.getParameter(Constants.MAIL_KEY);
            Utente user = businessLogic.retrieveUserByEmail(userEmail);
            req.setAttribute(Constants.USER_DATA_KEY, user);
            req.getRequestDispatcher("/jsp/private/profile.jsp").forward(req, resp);
        } catch (UserNonExistantException e) {
            e.printStackTrace();
            req.setAttribute(Constants.USER_NON_EXISTANT_KEY, e.getMessage());
            resp.sendRedirect(req.getContextPath() + "/readAllPosts");
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute(Constants.UNEXPECTED_ERROR_KEY, e.getMessage());
            req.getRequestDispatcher("/jsp/public/error.jsp").forward(req, resp);
        }
    }
}
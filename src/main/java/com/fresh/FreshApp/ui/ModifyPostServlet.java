package com.fresh.FreshApp.ui;

import java.io.IOException;

import com.fresh.FreshApp.businessLogic.BusinessLogic;
import com.fresh.FreshApp.exception.EmptyPostTextException;
import com.fresh.FreshApp.model.Utente;
import com.fresh.FreshApp.utils.Constants;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@MultipartConfig
@WebServlet("/modifyPost")
public class ModifyPostServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Utente userLogged = (Utente) req.getSession().getAttribute(Constants.USER_DATA_KEY);
            if (userLogged == null) {
                req.getRequestDispatcher("/jsp/public/login.jsp").forward(req, resp);
                return;
            }
            Integer postId = Integer.parseInt(req.getParameter(Constants.POST_ID_KEY));
            String postText = req.getParameter(Constants.POST_TEXT_KEY);
            req.setAttribute(Constants.POST_TEXT_KEY, postText);
            req.setAttribute(Constants.POST_ID_KEY, postId);
            req.getRequestDispatcher("/jsp/private/postForm.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute(Constants.UNEXPECTED_ERROR_KEY, e.getMessage());
            req.getRequestDispatcher("/jsp/public/error.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Utente userLogged = (Utente) req.getSession().getAttribute(Constants.USER_DATA_KEY);
            if (userLogged == null) {
                req.getRequestDispatcher("/jsp/public/login.jsp").forward(req, resp);
            }
            BusinessLogic bl = (BusinessLogic) getServletContext().getAttribute(Constants.BL_KEY);
            Integer postId = Integer.parseInt(req.getParameter(Constants.POST_ID_KEY));
            String postModificato = req.getParameter(Constants.CREATE_POST_KEY);
            bl.modifyPost(postId, postModificato);
            resp.sendRedirect(req.getContextPath() + "/readAllPosts");
        } catch (EmptyPostTextException e) {
            e.printStackTrace();
            req.setAttribute(Constants.EMPTY_POST_ERROR, e.getMessage());
            req.getRequestDispatcher("/jsp/private/home.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute(Constants.UNEXPECTED_ERROR_KEY, e.getMessage());
            req.getRequestDispatcher("/jsp/public/error.jsp").forward(req, resp);
        }
    }
}
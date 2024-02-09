package com.fresh.FreshApp.ui;

import java.io.IOException;
import java.io.PrintWriter;

import com.fresh.FreshApp.businessLogic.BusinessLogic;
import com.fresh.FreshApp.exception.AutorNullException;
import com.fresh.FreshApp.exception.PostNullException;
import com.fresh.FreshApp.model.Utente;
import com.fresh.FreshApp.utils.Constants;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/toggleLike")
public class ToggleLikeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Utente utenteLoggato = (Utente) req.getSession().getAttribute(Constants.USER_DATA_KEY);
            if (utenteLoggato == null) {
                req.getRequestDispatcher("/jsp/public/login.jsp").forward(req, resp);
                return;
            }
            BusinessLogic bl = (BusinessLogic) getServletContext().getAttribute(Constants.BL_KEY);
            Integer postId = Integer.parseInt(req.getParameter(Constants.POST_ID_KEY));
            // Boolean isOrderedByLikes =
            // Boolean.parseBoolean(req.getParameter(Constants.ORDER_BY_LIKES_KEY));
            // Boolean isOrderedByComments =
            // Boolean.parseBoolean(req.getParameter(Constants.ORDER_BY_COMMENTS_KEY));
            bl.toggleLikePost(postId, utenteLoggato);
            // if (isOrderedByLikes != null && isOrderedByLikes) {
            // resp.sendRedirect(req.getContextPath() + "/readAllPosts?" +
            // Constants.ORDER_BY_LIKES_KEY + "=" + isOrderedByLikes);
            // } else if (isOrderedByComments != null && isOrderedByComments) {
            // resp.sendRedirect(req.getContextPath() + "/readAllPosts?" +
            // Constants.ORDER_BY_COMMENTS_KEY + "="
            // + isOrderedByComments);
            // } else {
            // resp.sendRedirect(req.getContextPath() + "/readAllPosts");
            // }

            req.getRequestDispatcher("/readAllPosts").forward(req, resp);
        } catch (AutorNullException e) {
            e.printStackTrace();
            req.setAttribute(Constants.AUTOR_NULL_KEY, e.getMessage());
            req.getRequestDispatcher("/jsp/public/login.jsp").forward(req, resp);
        } catch (PostNullException e) {
            e.printStackTrace();
            req.setAttribute(Constants.POST_NULL_KEY, e.getMessage());
            req.getRequestDispatcher("/jsp/public/error.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute(Constants.UNEXPECTED_ERROR_KEY, e.getMessage());
            req.getRequestDispatcher("/jsp/public/error.jsp").forward(req, resp);
        }
    }
}
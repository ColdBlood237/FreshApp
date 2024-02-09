package com.fresh.FreshApp.ui;

import java.io.IOException;

import com.fresh.FreshApp.businessLogic.BusinessLogic;
import com.fresh.FreshApp.exception.AutorNullException;
import com.fresh.FreshApp.exception.EmptyCommentTextException;
import com.fresh.FreshApp.exception.PostNullException;
import com.fresh.FreshApp.model.Commento;
import com.fresh.FreshApp.model.Utente;
import com.fresh.FreshApp.utils.Constants;
import com.fresh.FreshApp.utils.EmailUtils;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/createComment")
public class CreateCommentServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Integer postId = null;
        try {
            Utente userLogged = (Utente) req.getSession().getAttribute(Constants.USER_DATA_KEY);
            if (userLogged == null) {
                req.getRequestDispatcher("/jsp/public/login.jsp").forward(req, resp);
                return;
            }
            BusinessLogic bl = (BusinessLogic) getServletContext().getAttribute(Constants.BL_KEY);
            String testo = req.getParameter(Constants.COMMENT_TEXT_KEY);
            postId = Integer.parseInt(req.getParameter(Constants.POST_ID_KEY));
            Utente utenteLoggato = (Utente) req.getSession().getAttribute(Constants.USER_DATA_KEY);
            Commento commentoInserito = bl.insertCommento(testo, utenteLoggato, postId);
            if (!commentoInserito.getPost().getAutore().equals(utenteLoggato)) {
                String destinatario = commentoInserito.getPost().getAutore().getEmail();
                String oggetto = "Nuovo Commentooo";
                String contenuto = "il bro " + commentoInserito.getAutore().getUsername()
                        + " ha commentato un tuo post :)";
                EmailUtils.sendEmail(destinatario, oggetto, contenuto);
            }
            resp.sendRedirect(req.getContextPath() + "/readPostComments?" + Constants.POST_ID_KEY + "=" + postId);
        } catch (EmptyCommentTextException e) {
            e.printStackTrace();
            req.setAttribute(Constants.EMPTY_COMMENT, e.getMessage());
            resp.sendRedirect(req.getContextPath() + "/readPostComments?" + Constants.POST_ID_KEY + "=" + postId);
        } catch (AutorNullException e) {
            e.printStackTrace();
            req.setAttribute(Constants.AUTOR_NULL_KEY, e.getMessage());
            req.getRequestDispatcher("/jsp/public/login.jsp").forward(req, resp);
        } catch (PostNullException e) {
            e.printStackTrace();
            req.setAttribute(Constants.POST_NULL_KEY, e.getMessage());
            req.getRequestDispatcher("/jsp/private/home.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute(Constants.UNEXPECTED_ERROR_KEY, e.getMessage());
            req.getRequestDispatcher("/jsp/public/error.jsp").forward(req, resp);
        }
    }
}
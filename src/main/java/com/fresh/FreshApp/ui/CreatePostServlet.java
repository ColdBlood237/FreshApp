package com.fresh.FreshApp.ui;

import java.io.IOException;

import com.fresh.FreshApp.businessLogic.BusinessLogic;
import com.fresh.FreshApp.exception.EmptyPostTextException;
import com.fresh.FreshApp.model.Utente;
import com.fresh.FreshApp.utils.Constants;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/createPost")
public class CreatePostServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			BusinessLogic bl = (BusinessLogic) getServletContext().getAttribute(Constants.BL_KEY);
			Utente autore = (Utente) req.getSession().getAttribute(Constants.USER_DATA_KEY);
			if (autore == null) {
				req.getRequestDispatcher("/jsp/public/login.jsp").forward(req, resp);
				return;
			}
			String testo = req.getParameter(Constants.CREATE_POST_KEY);
			bl.insertPost(testo, autore);
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

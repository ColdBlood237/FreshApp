package com.fresh.FreshApp.ui;

import java.io.IOException;

import com.fresh.FreshApp.businessLogic.BusinessLogic;
import com.fresh.FreshApp.model.Utente;
import com.fresh.FreshApp.utils.Constants;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/signout")
public class SignoutServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			BusinessLogic businessLogic = (BusinessLogic) getServletContext().getAttribute(Constants.BL_KEY);
			Utente userLogged = (Utente) req.getSession().getAttribute(Constants.USER_DATA_KEY);
			if (userLogged == null) {
				req.getRequestDispatcher("/jsp/public/login.jsp").forward(req, resp);
				return;
			}
			businessLogic.deleteUser(userLogged.getId());
			req.getSession().removeAttribute(Constants.USER_LOGGED_KEY);
			req.getSession().removeAttribute(Constants.USER_DATA_KEY);
			req.getRequestDispatcher("/jsp/public/login.jsp").forward(req, resp);
		} catch (Exception e) {
			e.printStackTrace();
			req.setAttribute(Constants.UNEXPECTED_ERROR_KEY, e.getMessage());
			req.getRequestDispatcher("/jsp/public/error.jsp").forward(req, resp);
		}
	}
}

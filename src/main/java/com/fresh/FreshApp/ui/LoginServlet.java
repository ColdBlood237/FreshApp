package com.fresh.FreshApp.ui;

import java.io.IOException;

import com.fresh.FreshApp.businessLogic.BusinessLogic;
import com.fresh.FreshApp.exception.IncorrectPasswordException;
import com.fresh.FreshApp.exception.UserNonExistantException;
import com.fresh.FreshApp.model.Utente;
import com.fresh.FreshApp.utils.Constants;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			BusinessLogic businessLogic = (BusinessLogic) getServletContext().getAttribute(Constants.BL_KEY);
			String email = req.getParameter(Constants.MAIL_KEY);
			String password = req.getParameter(Constants.PSW_KEY);
			Utente userLogging = businessLogic.retrieveUserByEmailAndPassword(email, password);
			if (userLogging != null) {
				req.getSession().setAttribute(Constants.USER_LOGGED_KEY, true);
				req.getSession().setAttribute(Constants.USER_DATA_KEY, userLogging);
				resp.sendRedirect(req.getContextPath() + "/readAllPosts");
			}
		} catch (UserNonExistantException e) {
			e.printStackTrace();
			req.setAttribute(Constants.USER_NON_EXISTANT_KEY, e.getMessage());
			req.getRequestDispatcher("/jsp/public/login.jsp").forward(req, resp);
		} catch (IncorrectPasswordException e) {
			e.printStackTrace();
			req.setAttribute(Constants.INCORRECT_PWD_KEY, e.getMessage());
			req.getRequestDispatcher("/jsp/public/login.jsp").forward(req, resp);
		} catch (Exception e) {
			e.printStackTrace();
			req.setAttribute(Constants.UNEXPECTED_ERROR_KEY, e.getMessage());
			req.getRequestDispatcher("/jsp/public/error.jsp").forward(req, resp);
		}
	}
}

package com.fresh.FreshApp.ui;

import java.io.IOException;

import javax.persistence.EntityManager;

import com.fresh.FreshApp.businessLogic.BusinessLogic;
import com.fresh.FreshApp.exception.EmailAlreadyUsedException;
import com.fresh.FreshApp.exception.InvalidFieldsException;
import com.fresh.FreshApp.exception.PasswordsNotMatchingException;
import com.fresh.FreshApp.exception.UsernameAlreadyUsedException;
import com.fresh.FreshApp.exception.ImgNullException;
import com.fresh.FreshApp.model.Utente;
import com.fresh.FreshApp.utils.Constants;
import jakarta.servlet.http.Part;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.File;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.annotation.MultipartConfig;

@MultipartConfig
@WebServlet("/signup")
public class SignupServlet extends HttpServlet {
	EntityManager manager = null;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			BusinessLogic businessLogic = (BusinessLogic) getServletContext().getAttribute(Constants.BL_KEY);
			String email = req.getParameter(Constants.MAIL_KEY);
			String username = req.getParameter(Constants.USER_KEY);
			String password = req.getParameter(Constants.PSW_KEY);
			String confermaPassword = req.getParameter(Constants.CONF_PSW_KEY);
			String dataNascita = req.getParameter(Constants.BORN_KEY);
			Part file = req.getPart(Constants.ADD_IMG_KEY);
			if (file != null && file.getSize() > 0) {
				String imgFileName = file.getSubmittedFileName();
				InputStream inputStream = file.getInputStream();
				String uploadPath = (String) getServletContext().getAttribute(Constants.IMG_PATH_KEY) + File.separator
						+ imgFileName;
				FileOutputStream fos = new FileOutputStream(uploadPath);
				byte[] data = new byte[inputStream.available()];
				inputStream.read(data);
				fos.write(data);
				fos.close();
				Utente newUserImg = businessLogic.insertUser(email, username, password, confermaPassword, dataNascita,
						imgFileName);
				req.getSession().setAttribute(Constants.USER_DATA_KEY, newUserImg);
			} else {
				Utente newUser = businessLogic.insertUser(email, username, password, confermaPassword, dataNascita);
				req.getSession().setAttribute(Constants.USER_DATA_KEY, newUser);
			}
			req.getSession().setAttribute(Constants.USER_LOGGED_KEY, true);
			resp.sendRedirect(req.getContextPath() + "/readAllPosts");
			// req.getRequestDispatcher("/readAllPosts").forward(req, resp);
		} catch (InvalidFieldsException e) {
			e.printStackTrace();
			req.setAttribute(Constants.INVALID_FIELDS, e.getMessage());
			req.getRequestDispatcher("/jsp/public/signup.jsp").forward(req, resp);
		} catch (UsernameAlreadyUsedException e) {
			e.printStackTrace();
			req.setAttribute(Constants.USER_ALREADY_EXIST, e.getMessage());
			req.getRequestDispatcher("/jsp/public/signup.jsp").forward(req, resp);
		} catch (EmailAlreadyUsedException e) {
			e.printStackTrace();
			req.setAttribute(Constants.EMAIL_ALREADY_EXIST, e.getMessage());
			req.getRequestDispatcher("/jsp/public/signup.jsp").forward(req, resp);
		} catch (PasswordsNotMatchingException e) {
			e.printStackTrace();
			req.setAttribute(Constants.PASSWORD_NOT_MATCH, e.getMessage());
			req.getRequestDispatcher("/jsp/public/signup.jsp").forward(req, resp);
		} catch (ImgNullException e) {
			e.printStackTrace();
			req.setAttribute(Constants.IMG_NULL_ERROR, e.getMessage());
			req.getRequestDispatcher("/jsp/public/signup.jsp").forward(req, resp);
		} catch (Exception e) {
			e.printStackTrace();
			req.setAttribute(Constants.UNEXPECTED_ERROR_KEY, e.getMessage());
			req.getRequestDispatcher("/jsp/public/error.jsp").forward(req, resp);
		}

	}

}

package com.fresh.FreshApp.ui;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

import com.fresh.FreshApp.businessLogic.BusinessLogic;
import com.fresh.FreshApp.exception.EmptyPostTextException;
import com.fresh.FreshApp.exception.ImgNullException;
import com.fresh.FreshApp.model.Utente;
import com.fresh.FreshApp.utils.Constants;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@MultipartConfig
@WebServlet("/createImgPost")
public class CreateImgPostServlet extends HttpServlet {
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
			Utente autore = userLogged;
			BusinessLogic bl = (BusinessLogic) getServletContext().getAttribute(Constants.BL_KEY);

			String testo = req.getParameter(Constants.CREATE_POST_KEY);
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

				bl.insertPostWithImg(testo, autore, imgFileName);
			} else {
				bl.insertPost(testo, autore);
			}
			resp.sendRedirect(req.getContextPath() + "/readAllPosts");
		} catch (EmptyPostTextException e) {
			e.printStackTrace();
			req.setAttribute(Constants.EMPTY_POST_ERROR, e.getMessage());
			req.getRequestDispatcher("/jsp/private/postForm.jsp").forward(req, resp);
		} catch (ImgNullException e) {
			e.printStackTrace();
			req.setAttribute(Constants.IMG_NULL_ERROR, e.getMessage());
			req.getRequestDispatcher("/jsp/private/postForm.jsp").forward(req, resp);
		} catch (Exception e) {
			e.printStackTrace();
			req.setAttribute(Constants.UNEXPECTED_ERROR_KEY, e.getMessage());
			req.getRequestDispatcher("/jsp/public/error.jsp").forward(req, resp);
		}
	}

}

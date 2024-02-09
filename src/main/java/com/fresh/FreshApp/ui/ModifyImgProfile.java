package com.fresh.FreshApp.ui;

import java.io.IOException;
import java.io.InputStream;
import java.io.FileOutputStream;
import java.io.File;

import com.fresh.FreshApp.businessLogic.BusinessLogic;
import com.fresh.FreshApp.model.Utente;
import com.fresh.FreshApp.exception.ImgNullException;
import com.fresh.FreshApp.utils.Constants;
import com.fresh.FreshApp.exception.AutorNullException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.Part;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@MultipartConfig
@WebServlet("/modifyImgProfile")
public class ModifyImgProfile extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            BusinessLogic bl = (BusinessLogic) getServletContext().getAttribute(Constants.BL_KEY);
            Utente utenteLoggato = (Utente) req.getSession().getAttribute(Constants.USER_DATA_KEY);
            if (utenteLoggato == null) {
                req.getRequestDispatcher("jsp/public/login.jsp").forward(req, resp);
                return;
            }
            Part file = req.getPart(Constants.ADD_IMG_KEY);
            if (file != null && file.getSize() > 0) {
                String imgFileName = file.getSubmittedFileName();
                String uploadPath = getServletContext().getRealPath("") + File.separator + "images" + File.separator
                        + imgFileName;
                FileOutputStream fos = new FileOutputStream(uploadPath);
                InputStream is = file.getInputStream();
                byte[] data = new byte[is.available()];
                is.read(data);
                fos.write(data);
                fos.close();
                bl.modifyImgProfile(utenteLoggato, imgFileName);
            }
            req.getRequestDispatcher("jsp/private/profiloPrivato.jsp").forward(req, resp);
        } catch (ImgNullException e) {
            e.printStackTrace();
            req.setAttribute(Constants.IMG_NULL_ERROR, e.getMessage());
            req.getRequestDispatcher("/jsp/private/home.jsp").forward(req, resp);
        } catch (AutorNullException e) {
            e.printStackTrace();
            req.setAttribute(Constants.UNEXPECTED_ERROR_KEY, e.getMessage());
            req.getRequestDispatcher("/jsp/public/login.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute(Constants.UNEXPECTED_ERROR_KEY, e.getMessage());
            req.getRequestDispatcher("/jsp/public/error.jsp").forward(req, resp);
        }
    }
}

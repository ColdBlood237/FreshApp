package com.fresh.FreshApp.ui;

import java.io.IOException;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.File;

import com.fresh.FreshApp.businessLogic.BusinessLogic;
import com.fresh.FreshApp.utils.Constants;
import com.fresh.FreshApp.model.Utente;

import jakarta.servlet.http.Part;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/addImage")
public class AddImageServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Utente userLoggato = (Utente) req.getSession().getAttribute(Constants.USER_DATA_KEY);
            if (userLoggato == null) {
                req.getRequestDispatcher("/jsp/public/login.jsp").forward(req, resp);
                return;
            }
            BusinessLogic bl = (BusinessLogic) getServletContext().getAttribute(Constants.BL_KEY);
            String id = req.getParameter(Constants.POST_ID_KEY);
            Integer idPost = Integer.parseInt(id);
            // cattura l'immagine dalla jsp
            Part file = req.getPart(Constants.ADD_IMG_KEY);
            // estrae nome del file
            String imgFileName = file.getSubmittedFileName();
            String uploadPath = (String) getServletContext().getAttribute(Constants.IMG_PATH_KEY) + File.separator
                    + imgFileName;
            // processo per inserire il file nella directory indicata
            FileOutputStream fos = new FileOutputStream(uploadPath);
            InputStream is = file.getInputStream();
            byte[] data = new byte[is.available()];
            is.read(data);
            fos.write(data);
            fos.close();
            bl.insertImgPost(idPost, imgFileName);
            resp.sendRedirect("/jsp/private.home.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute(Constants.UNEXPECTED_ERROR_KEY, e.getMessage());
            req.getRequestDispatcher("/jsp/public/error.jsp").forward(req, resp);
        }
    }
}

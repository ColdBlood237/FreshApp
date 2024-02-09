package com.fresh.FreshApp.ui;

import java.io.InputStream;
import java.util.Properties;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import com.fresh.FreshApp.businessLogic.BusinessLogic;
import com.fresh.FreshApp.dao.CommentoDao;
import com.fresh.FreshApp.dao.PostDao;
import com.fresh.FreshApp.dao.UtenteDao;
import com.fresh.FreshApp.utils.Constants;
import com.fresh.FreshApp.utils.EmailUtils;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;

@WebServlet(value = "/Fresh", loadOnStartup = 1)
public class InitServlet extends HttpServlet {

	@Override
	public void init() throws ServletException {
		EntityManager entityManager = null;
		try {
			Properties prop = new Properties();
			InputStream is = InitServlet.class.getClassLoader().getResourceAsStream("images.properties");
			prop.load(is);
			String imagePath = prop.getProperty("pathImage");
			EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("Fresh");
			entityManager = entityManagerFactory.createEntityManager();
			UtenteDao utenteDao = new UtenteDao(entityManager);
			PostDao postDao = new PostDao(entityManager);
			CommentoDao commentoDao = new CommentoDao(entityManager);
			BusinessLogic businessLogic = new BusinessLogic(entityManager, utenteDao, postDao, commentoDao);
			getServletContext().setAttribute(Constants.BL_KEY, businessLogic);
			getServletContext().setAttribute(Constants.IMG_PATH_KEY, imagePath);
		} catch (Exception e) {
			e.printStackTrace();
			if (entityManager != null) {
				entityManager.close();
			}
			System.exit(0);
		}
	}
}

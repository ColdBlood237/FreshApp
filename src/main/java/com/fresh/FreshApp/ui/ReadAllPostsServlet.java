package com.fresh.FreshApp.ui;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.fresh.FreshApp.businessLogic.BusinessLogic;
import com.fresh.FreshApp.model.Post;
import com.fresh.FreshApp.model.Utente;
import com.fresh.FreshApp.utils.Constants;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/readAllPosts")
public class ReadAllPostsServlet extends HttpServlet {

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
			BusinessLogic businessLogic = (BusinessLogic) getServletContext().getAttribute(Constants.BL_KEY);
			Boolean isOrderedByLikes = Boolean.parseBoolean(req.getParameter(Constants.ORDER_BY_LIKES_KEY));
			Boolean isOrderedByComments = Boolean.parseBoolean(req.getParameter(Constants.ORDER_BY_COMMENTS_KEY));

			List<Post> posts = new ArrayList<Post>();
			if (isOrderedByLikes != null && isOrderedByLikes) {
				posts = businessLogic.retrievePostsByLikesDesc();
				req.setAttribute(Constants.ORDER_BY_LIKES_KEY, true);
				req.setAttribute(Constants.ORDER_BY_COMMENTS_KEY, false);
			} else if (isOrderedByComments != null && isOrderedByComments) {
				posts = businessLogic.retrievePostsByCommentsDesc();
				req.setAttribute(Constants.ORDER_BY_COMMENTS_KEY, true);
				req.setAttribute(Constants.ORDER_BY_LIKES_KEY, false);
			} else {
				posts = businessLogic.retrievePosts();
				req.setAttribute(Constants.ORDER_BY_COMMENTS_KEY, false);
				req.setAttribute(Constants.ORDER_BY_LIKES_KEY, false);
			}
			req.setAttribute(Constants.ALL_POSTS_KEY, posts);
			req.getRequestDispatcher("/jsp/private/home.jsp").forward(req, resp);
		} catch (Exception e) {
			e.printStackTrace();
			req.setAttribute(Constants.UNEXPECTED_ERROR_KEY, e.getMessage());
			req.getRequestDispatcher("/jsp/public/error.jsp").forward(req, resp);

		}

	}
}

package com.fresh.FreshApp.ui;

import java.io.IOException;

import com.fresh.FreshApp.utils.Constants;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;

@WebFilter("/jsp/private/*")
public class FiltroAccessi implements Filter {

	@Override
	public void doFilter(ServletRequest arg0, ServletResponse arg1, FilterChain arg2)
			throws IOException, ServletException {
		try {
			HttpServletRequest req = (HttpServletRequest) arg0;
			Boolean loggato = (Boolean) req.getSession().getAttribute(Constants.USER_LOGGED_KEY);
			if (loggato != null && loggato) {
				arg2.doFilter(arg0, arg1);
			} else {
				req.getRequestDispatcher("/jsp/public/login.jsp").forward(arg0, arg1);
			}
		} catch (Exception e) {
			e.printStackTrace();
			arg0.getRequestDispatcher("/jsp/public/login.jsp").forward(arg0, arg1);
		}

	}

}

package com.mub.utils;

import com.mub.models.UserModel;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

public class AuthUtil {
	public static boolean isUserLoggedIn(HttpServletRequest request) {
		HttpSession session = request.getSession(false); // do not create new session
		return session != null && session.getAttribute("token") != null;
	}

	public static boolean isUserAuthorize(HttpServletRequest request) {
		boolean flag = false;
		HttpSession session = request.getSession(false);
		UserModel user = (UserModel)session.getAttribute("token");
		if(user.role.equals("customer") || user.role.equals("admin")) {
			flag = true;
		}
		return flag;
	}
	
	public static boolean isAdmin(HttpServletRequest request) {
		boolean flag = false;
		HttpSession session = request.getSession(false);
		UserModel user = (UserModel)session.getAttribute("token");
		if(user.role.equals("admin")) {
			flag = true;
		}
		return flag;
	}
}

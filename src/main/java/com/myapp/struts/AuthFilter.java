/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.myapp.struts;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.logging.Filter;

/**
 *
 * @author us8610
 */
public class AuthFilter implements Filter {

    public void init(FilterConfig config)
            throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;
        HttpSession ses = request.getSession();
        if (ses == null || ses.getAttribute("user_name") == null) {
            response.sendRedirect("/tu/frame/login.do?method=view");
        } else {
            chain.doFilter(request, response);
        }
    }

    public void destroy() {
    }
}
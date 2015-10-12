/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.myapp.filter;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.StringTokenizer;
 
// Implements Filter class
public class UserAuthFilter implements Filter {
 
  private ArrayList urlList = new ArrayList();
  private ArrayList StrUrlList = new ArrayList();
 
  public void destroy() {
  }
 
  public void doFilter(ServletRequest req, ServletResponse res,
      FilterChain chain) throws IOException, ServletException {
 
    HttpServletRequest request = (HttpServletRequest) req;
    HttpServletResponse response = (HttpServletResponse) res;
    String url = request.getServletPath();
    boolean allowedRequest = false;
    String strURL = "";
 
    for (int i = 0; i < StrUrlList.size(); i++) {
      strURL = StrUrlList.get(i).toString();
      if (url.contains(strURL)) { 
        allowedRequest = true;
      }
    }
 
    if (!allowedRequest) {
      HttpSession session = request.getSession(false);
      if (session == null
          || session.getAttribute("db_name") == null) {
        // Forward the control to login.jsp if authentication fails
        request.getRequestDispatcher("/frame/login.jsp").forward(request,
            response);
      }
    }
    chain.doFilter(req, res);
  }
 
  public void init(FilterConfig config) throws ServletException {
    // Read the URLs to be avoided for authentication check (From web.xml)
    String urls = config.getInitParameter("avoid-urls");
    StringTokenizer token = new StringTokenizer(urls, ",");
    StrUrlList = new ArrayList();
    while (token.hasMoreTokens()) {
      StrUrlList.add(token.nextToken());
    }
  }
} 
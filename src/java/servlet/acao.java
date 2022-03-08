/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import DAO.UsuarioDAO;
import entidade.Usuario;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Airan Iuri
 */
public class acao extends HttpServlet {
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet action</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet action at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String param = request.getParameter("parameter");
       
        if (param.equals("logout")) {
            request.getSession().removeAttribute("logado");
            request.getSession().invalidate();
            response.sendRedirect("index.jsp");
        } 
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String param = request.getParameter("parameter");
       
        if (param.equals("login")) { 
            int salt = new UsuarioDAO().consultaSalt(request.getParameter("loginusuario"));
            if (new UsuarioDAO().autenticaUsuario(request.getParameter("loginusuario"), request.getParameter("senha"), salt)) {         
                Usuario u = new Usuario();
                UsuarioDAO ud = new UsuarioDAO();
                u = (Usuario) ud.consultarId(String.valueOf(ud.getIdPorLogin(request.getParameter("loginusuario"))));
                HttpSession session = request.getSession();
                session.setAttribute("logado", u);
                response.sendRedirect("main.jsp");
            } else  {
                request.getSession().invalidate();
                response.sendRedirect("invalido.jsp");
            }  
        } 
    }
    
    private void pageForward(String page, HttpServletRequest request, HttpServletResponse response) {
        try {
            RequestDispatcher rd = request.getRequestDispatcher(page);
            rd.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
 
}

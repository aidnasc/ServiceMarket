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

/**
 *
 * @author Airan Iuri
 */
public class acaousuario extends HttpServlet {
    
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
       
        if (param.equals("editaSenha")) {
            Usuario u = (Usuario) new UsuarioDAO().consultarId(request.getParameter("id"));
            request.setAttribute("usuario", u);
            pageForward("editasenha.jsp", request, response);
        } else if (param.equals("excluiUsuario")) {
            UsuarioDAO ud = new UsuarioDAO();
            ud.desativar(request.getParameter("id"));
            request.setAttribute("fonte", "usuarios.jsp");
            response.sendRedirect("usuarios.jsp");
        } 

    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String param = request.getParameter("parameter");
       
        switch (param) {
            case "recadastroSenha":
                {
                    Usuario u = (Usuario) new UsuarioDAO().consultarId(request.getParameter("idusuario"));
                    UsuarioDAO ud = new UsuarioDAO();
                    if (request.getParameter("novasenha").equals(request.getParameter("confnovasenha"))) {
                        if (ud.verificaSenha(u, request.getParameter("senhaatual"))) {
                            u.setSenha(request.getParameter("novasenha"));
                            ud.atualizaSenha(u);
                            response.sendRedirect("sucessoeditasenha.jsp");
                        } else {
                            pageForward("erroeditasenha.jsp", request, response);
                        }
                    } else {
                        pageForward("erroeditasenha.jsp", request, response);
                    }       
                    break;
                }
            case "registro":
                {
                    Usuario u = new Usuario();
                    UsuarioDAO ud = new UsuarioDAO();
                    u.setNome(request.getParameter("nomeusuario"));
                    u.setLogin(request.getParameter("loginusuario"));
                    u.setSenha(request.getParameter("senha"));
                    u.setLogradouro(request.getParameter("logradouro"));
                    u.setBairro(request.getParameter("bairro"));
                    u.setEmail(request.getParameter("email"));
                    u.setTelefone(request.getParameter("telefone"));
                    u.setTipo(request.getParameter("tipo"));
                    ud.salvar(u);
                    response.sendRedirect("login.jsp");
                    break;
                }
            case "editaPerfil":
                {
                    Usuario u = new Usuario();
                    UsuarioDAO ud = new UsuarioDAO();
                    u.setId(Integer.parseInt(request.getParameter("idusuario")));
                    u.setNome(request.getParameter("nomeusuario"));
                    u.setLogin(request.getParameter("loginusuario"));
                    u.setLogradouro(request.getParameter("logradouro"));
                    u.setBairro(request.getParameter("bairro"));
                    u.setEmail(request.getParameter("email"));
                    u.setTelefone(request.getParameter("telefone"));
                    u.setTipo(request.getParameter("tipo"));
                    ud.atualizar(u);
                    response.sendRedirect("sucessoeditaperfil.jsp");
                    break;
                }
            default:
                break;
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

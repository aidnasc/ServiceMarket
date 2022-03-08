/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Airan Iuri
 */
public class filtro extends HttpServlet implements Filter {
    List<String> url = new ArrayList<>();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet filter</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet filter at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
    
    @Override
    public String getServletInfo() {
        return "Short description";
    }
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {    
        url.add("/ServiceMarket");
        url.add("/ServiceMarket/acao");
        url.add("/ServiceMarket/acaousuario");
        url.add("/ServiceMarket/acaotiposervico");
        url.add("/ServiceMarket/acaosugestao");
        url.add("/ServiceMarket/acaoservico");
        url.add("/ServiceMarket/index.jsp");
        url.add("/ServiceMarket/registro.jsp");
        url.add("/ServiceMarket/sugestao.jsp");
        url.add("/ServiceMarket/prestador.jsp");
        url.add("/ServiceMarket/avaliacao.jsp");
        url.add("/ServiceMarket/tiposervico.jsp");
        url.add("/ServiceMarket/meusservicos.jsp");
        url.add("/ServiceMarket/servicosdisponiveis.jsp");
	url.add("/ServiceMarket/atendimento.jsp");
        url.add("/ServiceMarket/confirmacao.jsp");
        url.add("/ServiceMarket/detalhes.jsp");
        url.add("/ServiceMarket/header.jsp");
        url.add("/ServiceMarket/sucessoeditasenha.jsp");
        url.add("/ServiceMarket/sucessoeditaperfil.jsp");
        url.add("/ServiceMarket/erroeditasenha.jsp");
        url.add("/ServiceMarket/invalido.jsp");
        url.add("/ServiceMarket/login.jsp");
        url.add("/ServiceMarket/main.jsp");
        url.add("/ServiceMarket/usuarios.jsp");
        url.add("/ServiceMarket/editasenha.jsp");
        url.add("/ServiceMarket/editaperfil.jsp");
        url.add("/ServiceMarket/cadsugestao.jsp");
        url.add("/ServiceMarket/cadtiposervico.jsp");
        url.add("/ServiceMarket/cadservico.jsp");
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;

        if (url.contains(req.getRequestURI())) {
            request.setAttribute("parameter", "login");
            chain.doFilter(request, response);
        } else {
            HttpSession session = ((HttpServletRequest) request).getSession();
            if (session.getAttribute("logado") == null) {
                ((HttpServletResponse) response).sendRedirect("index.jsp");
            } else {
                chain.doFilter(request, response);
            }
        }
    
    }
    
}

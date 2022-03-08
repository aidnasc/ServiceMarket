/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;


import apoio.EnviarEmail;
import DAO.SugestaoDAO;
import entidade.Sugestao;
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
public class acaosugestao extends HttpServlet {

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

        if (param.equals("rejeitaSugestao")) {
            SugestaoDAO sd = new SugestaoDAO();
            sd.desativar(request.getParameter("id"));
            request.setAttribute("fonte", "sugestao.jsp");
            response.sendRedirect("sugestao.jsp");
        } else if (param.equals("aprovaSugestao")) {
            SugestaoDAO sd = new SugestaoDAO();
            sd.aprovar(request.getParameter("id"));
            request.setAttribute("fonte", "sugestao.jsp");
            response.sendRedirect("sugestao.jsp");
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String param = request.getParameter("parameter");

        if (param.equals("adicionaSugestao")) {
            int id = Integer.parseInt(request.getParameter("idsugestao"));
            Sugestao s = new Sugestao();
            SugestaoDAO sd = new SugestaoDAO();

            if (id != 0) {
                s.setId(id);
                s.setSugestao(request.getParameter("nomesugestao"));
                sd.atualizar(s);
                request.setAttribute("sugestao", null);
                response.sendRedirect("cadsugestao.jsp");
            } else {
                s.setSugestao(request.getParameter("nomesugestao"));
                sd.salvar(s);
                request.setAttribute("sugestao", null);
                response.sendRedirect("cadsugestao.jsp");
            }
        }
        String mensagemUsuario = null;

        if (request.getMethod().equals("POST")) {
            EnviarEmail enviar = new EnviarEmail();
            enviar.setEmailDestinatario("univateswebwolf@gmail.com");
            enviar.setAssunto("Service Market - Sugestão");
        //uso StringBuffer para otimizar a concatenação 
            //de string
            StringBuffer texto = new StringBuffer();
            texto.append("<h2 align='center'>Service Market - Sugestão</h2>");
            texto.append("<br/>");
            texto.append("Sugestão: ");
            texto.append(request.getParameter("nomesugestao"));
            texto.append("<br/>");

            enviar.setMsg(texto.toString());

            boolean enviou = enviar.enviarGmail();
            if (enviou) {
                mensagemUsuario = "Dados enviados com sucesso";
            } else {
                mensagemUsuario = "Não foi Possível enviar as informações";
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

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import DAO.ServicoDAO;
import DAO.UsuarioDAO;
import entidade.Servico;
import entidade.Usuario;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Airan Iuri
 */
public class acaoservico extends HttpServlet {
    
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
       
        switch (param) {
            case "editaServico":
                Servico s = (Servico) new ServicoDAO().consultarId(request.getParameter("id"));
                request.setAttribute("servico", s);
                pageForward("cadservico.jsp", request, response);
                break;
            case "excluiServico":
                ServicoDAO sd = new ServicoDAO();
                sd.desativar(request.getParameter("id"));
                request.setAttribute("fonte", "meusservicos.jsp");
                response.sendRedirect("meusservicos.jsp");
                break;
            case "detalheServico":
                Servico sdet = (Servico) new ServicoDAO().consultarId(request.getParameter("id"));
                request.setAttribute("servico", sdet);
                pageForward("detalhes.jsp", request, response);
                break;
            case "avaliacao":
                Servico av = (Servico) new ServicoDAO().consultarId(request.getParameter("id"));
                request.setAttribute("servico", av);
                pageForward("avaliacao.jsp", request, response);
                break;
            case "atendimento":
                Servico sdisp = (Servico) new ServicoDAO().consultarId(request.getParameter("id"));
                request.setAttribute("servico", sdisp);
                pageForward("atendimento.jsp", request, response);
                break;
            case "aprovaServico":
                new ServicoDAO().aprovar(request.getParameter("id"));
                request.setAttribute("fonte", "detalhes.jsp");
                response.sendRedirect("meusservicos.jsp");
                break;
            case "rejeitaServico":
                new ServicoDAO().rejeitar(request.getParameter("id"));
                request.setAttribute("fonte", "detalhes.jsp");
                response.sendRedirect("meusservicos.jsp");
                break;
            case "finalizaServico":
                new ServicoDAO().finalizar(request.getParameter("id"));
                request.setAttribute("fonte", "detalhes.jsp");
                response.sendRedirect("meusservicos.jsp");
                break;
            case "detalhaPrestador":
                Usuario prest = (Usuario) new UsuarioDAO().consultarId(request.getParameter("id"));
                request.setAttribute("uprest", prest);
                pageForward("prestador.jsp", request, response);
                break;
            default:
                break;
        }

    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String param = request.getParameter("parameter");
        ServicoDAO sd = new ServicoDAO();
       
        if (param.equals("adicionaServico")) {
            int id = Integer.parseInt(request.getParameter("idservico"));
            Servico s = new Servico();

            if (id != 0) {
                s.setId(id);
                s.setDescricao(request.getParameter("descricao"));
                s.setId_tiposervico(Integer.parseInt(request.getParameter("tiposervico")));
                sd.atualizar(s);
                request.setAttribute("servico", null);
                response.sendRedirect("meusservicos.jsp");
            } else {
                Usuario l = (Usuario) request.getSession().getAttribute("logado");
                s.setDescricao(request.getParameter("descricao"));
                s.setId_tiposervico(Integer.parseInt(request.getParameter("tiposervico")));
                s.setId_solicitante(l.getId());               
                sd.salvar(s);
                request.setAttribute("servico", null);
                response.sendRedirect("meusservicos.jsp");
            }
        } else if (param.equals("avaliaServico")) {
            sd.avaliaServico(request.getParameter("idservicoavaliado"), Integer.parseInt(request.getParameter("avaliacao")));
            response.sendRedirect("meusservicos.jsp");
        } else if (param.equals("atendeServico")) {
            int id = Integer.parseInt(request.getParameter("idservico"));
            Servico s = new Servico();
            s.setId(id);
            s.setValor(Double.parseDouble(request.getParameter("valor")));
            s.setId_prestador(Integer.parseInt(request.getParameter("prestador")));
            s.setData_realizacao(Date.valueOf(request.getParameter("datareal")));
            sd.atender(s);
            request.setAttribute("servico", null);
            response.sendRedirect("servicosdisponiveis.jsp");
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

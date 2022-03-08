<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="net.sf.jasperreports.engine.*"%>
<%@page import="net.sf.jasperreports.view.*"%>
<%@page import="apoio.Conexao" %>
<%@page import="DAO.SugestaoDAO" %>
<%@page import="javax.servlet.ServletResponse"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>PDF_Sugestao</title>
    </head>
    <body>
        <%
            Conexao con = new Conexao();
            File reportfile = new File (application.getRealPath("relatorios/relSugestao.jasper"));
            Map<String, Object> parameter = new HashMap<String, Object>();
            byte[] bytes = JasperRunManager.runReportToPdf(reportfile.getPath(), parameter, con.getConexao());
            response.setContentType("application/pdf");
            response.setContentLength(bytes.length);
            ServletOutputStream outputstream = response.getOutputStream();
            
            outputstream.write(bytes, 0, bytes.length);
            outputstream.flush();
            outputstream.close();
	    con.encerra();
        %>
    </body>
</html>

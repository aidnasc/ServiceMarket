<%@include file="main.jsp" %>
<%@page import="entidade.Servico"%>
<%@page import="DAO.ServicoDAO"%>
<%@page import="entidade.TipoServico"%>
<%@page import="java.util.ArrayList"%>
<%@page import="DAO.TipoServicoDAO"%>
<%@page import="DAO.UsuarioDAO"%>
<%@page import="apoio.Formatacao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/materialize.min.css"/>
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <title>Detalhes do Servi&ccedil;o</title>
    </head>
    <body>
        <%
            if (logado.getTipo().contains("Consumidor")) {
                response.sendRedirect("meusservicos.jsp");
            } 
            
            Servico serv = (Servico) request.getAttribute("servico");
            
            if (serv == null) {
                serv = new Servico();
                serv.setDescricao("");
                serv.setValor(0.00);
                serv.setId_prestador(0);
                serv.setId_solicitante(0);
                serv.setId_tiposervico(0);
                serv.setSituacao("");
            }           
        %>
        <div class="container">
            <div class="row">
                <div class="col card s8 offset-s2">
                    <form name="atendimento"
                          action="/ServiceMarket/acaoservico?parameter=atendeServico"
                          method="post">
                        <div class="card-content">
                            <span class="card-title center-align">
                                Atendimento de Servi&ccedil;o</span>
                        <div class="row">
                            <input type="hidden" 
                                   name="idservico"
                                   class="validate"
                                   value="<%=serv.getId()%>"/>
                            <input type="hidden"
                                   name="prestador"
                                   class="validate"
                                   value="<%=logado.getId()%>"/>
                            <div class="input-field col s4">
                                <i class="material-icons prefix">monetization_on</i>
                                <label>Valor</label>
                                <input name="valor"
                                       type="number"
                                       required=""
                                       value="<%=serv.getValor()%>"/>
                            </div>  
                            <div class="input-field col s4">
                                <i class="material-icons prefix">date_range</i>
                                <label>Realiza&ccedil;&atilde;o</label>
                                <br/>
                                <input name="datareal"
                                       id="datareal"
                                       type="date"
                                       pattern="(0[1-9]|1[0-9]|2[0-9]|3[01]).(0[1-9]|1[012]).[0-9]{4}"
                                       required=""
                                       value="<%=Formatacao.ajustaDataDMA(serv.getData_realizacao()+"")%>"/>
                            </div>     
                        </div>            
                    </div>            
                    <div class="card-action center-align">
                        <input type="submit"
                               class="btn cyan waves-effect waves-light"
                               value="Salvar">
                        <input type="reset"
                               class="btn cyan waves-effect waves-light"
                               value="Limpar">
                            <a href="servicosdisponiveis.jsp" 
                               class="btn cyan waves-effect waves-light">Voltar</a>
                    </div>                
                </div>
            </div>        
        </div>
                                        
        <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
        <script src="js/materialize.min.js"></script>
        <script>
            $document.ready(function () { 
                Materialize.updateTextFields();
            });
            window.onunload = refreshParent;
            function refreshParent() {
                window.opener.location.reload();
            }
        </script> 
    </body>
</html>

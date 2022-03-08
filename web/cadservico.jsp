<%@include file="main.jsp" %>
<%@page import="entidade.Servico"%>
<%@page import="DAO.ServicoDAO"%>
<%@page import="entidade.TipoServico"%>
<%@page import="java.util.ArrayList"%>
<%@page import="DAO.TipoServicoDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/materialize.min.css"/>
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <title>Servi&ccedil;os</title>
    </head>
    <body>
        <%
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
                    <form name="servico"
                          action="/ServiceMarket/acaoservico?parameter=adicionaServico"
                          method="post">
                        <div class="card-content">
                            <span class="card-title center-align">
                                Requisi&ccedil;&atilde;o de Servi&ccedil;o</span>
                            <div class="row">
                                <input type="hidden" 
                                       name="idservico"
                                       class="validate"
                                       value="<%=serv.getId()%>"/>
                                <div class="input-field col s12">
                                    <i class="material-icons prefix">edit</i>
                                    <input name="descricao"
                                           id="descricao"
                                           type="text"
                                           minlength="1"
                                           maxlength="200"
                                           class="validate"
                                           required="true"
                                           value="<%=serv.getDescricao()%>"
                                           autofocus/>
                                    <label for="descricao">Descri&ccedil;&atilde;o</label>
                                </div>
                                <div class="input col s12">
                                    <i class="material-icons prefix">build</i>
                                    <label>Tipo de Servi&ccedil;o</label>
                                    <select class="left" name="tiposervico" required="" > 
                                        <option value="" disabled selected>Selecione...</option>
                                        <%
                                            ArrayList<Object> tipos = new TipoServicoDAO().ativos();
                                            for (int i = 0; i < tipos.size(); i++) {
                                                TipoServico tiposlista = (TipoServico) tipos.get(i);
                                        %>
                                        <option value="<%=tiposlista.getId()%>" 
                                                <% if (tiposlista.getId() == serv.getId_tiposervico()) { %> selected="" <% } %> >
                                                <%=tiposlista.getDescricao()%>
                                        </option>                                      
                                        <% } %> 
                                    </select>
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
                            <a href="meusservicos.jsp" 
                               class="btn cyan waves-effect waves-light">Voltar</a>
                        </div>                
                    </form>
                </div>
            </div>        
        </div>
                                        
        <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
        <script src="js/materialize.min.js"></script>
        <script>
            $('select[name=tiposervico]').material_select();
            
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

<%@include file="main.jsp" %>
<%@page import="entidade.TipoServico"%>
<%@page import="DAO.TipoServicoDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/materialize.min.css"/>
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <title>Trabalhar com tipos de servi&ccedil;o</title>
    </head>
    <body>    
        <%
            if (! logado.getTipo().contains("Administrador")) { 
                response.sendRedirect("main.jsp");
            }
            
            TipoServico tserv = (TipoServico) request.getAttribute("tiposervico");
            
            if (tserv == null) {
                tserv = new TipoServico();
                tserv.setDescricao("");
                tserv.setSituacao("");
            }           
        %>
        <div class="container">
            <div class="row">
                <div class="col card s6 offset-s3">
                    <form name="tiposervico"
                          action="/ServiceMarket/acaotiposervico?parameter=adicionaTipo"
                          method="post">
                        <div class="card-content">
                            <span class="card-title center-align">
                                Tipo de servi&ccedil;o</span>
                            <div class="row">
                                <input type="hidden" 
                                       name="idtiposervico"
                                       class="validate"
                                       value="<%=tserv.getId()%>"/>
                                <div class="input-field col s12">
                                    <i class="material-icons prefix">edit</i>
                                    <input name="descricao"
                                           type="text"
                                           minlength="1"
                                           maxlength="64"
                                           class="validate"
                                           required="true"
                                           value="<%=tserv.getDescricao()%>"
                                           autofocus/>
                                    <label for="descricao">Descri&ccedil;&atilde;o</label>
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
                            <a href="tiposervico.jsp" 
                               class="btn cyan waves-effect waves-light">Voltar</a>
                        </div>                
                    </form>
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

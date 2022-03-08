<%@include file="main.jsp" %>
<%@page import="entidade.Sugestao"%>
<%@page import="DAO.SugestaoDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/materialize.min.css"/>
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <title>Sugest&ccedil;&otilde;es</title>
    </head>
    <body> 
        <%
            Sugestao sug = (Sugestao) request.getAttribute("sugestao");
            
            if (sug == null) {
                sug = new Sugestao();
                sug.setSugestao("");
                sug.setSituacao("");
            }           
        %>
        <div class="container">
            <div class="row">
                <div class="col card s12">
                    <form name="sugestao"
                          action="/ServiceMarket/acaosugestao?parameter=adicionaSugestao"
                          method="post">
                        <div class="card-content">
                            <span class="card-title center-align">
                                Sugest&atilde;o</span>
                            <div class="row">
                                <input type="hidden" 
                                       name="idsugestao"
                                       class="validate"
                                       value="<%=sug.getId()%>"/>
                                <div class="input-field col s12">
                                    <i class="material-icons prefix">edit</i>
                                    <input name="nomesugestao"
                                           type="text"
                                           minlength="1"
                                           maxlength="200"
                                           class="validate"
                                           required="true"
                                           value="<%=sug.getSugestao()%>"
                                           autofocus />
                                    <label for="nomesugestao">Descri&ccedil;&atilde;o</label>
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
                            <a href="main.jsp" 
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

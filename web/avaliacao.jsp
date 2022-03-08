<%@include file="main.jsp" %>
<%@page import="entidade.Servico"%>
<%@page import="DAO.ServicoDAO"%>
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
                <div class="col card s12">
                    <form name="avaliar"
                          action="/ServiceMarket/acaoservico?parameter=avaliaServico"
                          method="post">
                        <div class="card-content">
                            <span class="card-title center-align">
                                Avalia&ccedil;&atilde;o</span>
                            <div class="row">
                                <input type="hidden" 
                                       name="idservicoavaliado"
                                       class="validate"
                                       value="<%=serv.getId()%>"/>
                                <div class="col s12">
                                    <i class="material-icons prefix">star</i>Deixe aqui sua avalia&ccedil;&atilde;o do servi&ccedil;o! 
                                    <br/>
                                    <br/>
                                    <p class="centered">
                                    <input class="with-gap"
                                           type="radio" 
                                           name="avaliacao"
                                           id="1"
                                           value="1" />
                                    <label for="1"><img src="images/star1.png"></img></label>
                                    <input class="with-gap"
                                           type="radio" 
                                           name="avaliacao"
                                           id="2" 
                                           value="2" />
                                    <label for="2"><img src="images/star1.png"></img>
                                                   <img src="images/star1.png"></img></label>
                                    <input class="with-gap"
                                           type="radio" 
                                           name="avaliacao"
                                           id="3" 
                                           value="3" />
                                    <label for="3"><img src="images/star1.png"></img>
                                                   <img src="images/star1.png"></img>
                                                   <img src="images/star1.png"></img></label>
                                    <input class="with-gap"
                                           type="radio"
                                           name="avaliacao" 
                                           id="4" 
                                           value="4" />
                                    <label for="4"><img src="images/star1.png"></img>
                                                   <img src="images/star1.png"></img>
                                                   <img src="images/star1.png"></img>
                                                   <img src="images/star1.png"></img></label>
                                    <input class="with-gap"
                                           type="radio" 
                                           name="avaliacao"
                                           id="5" 
                                           value="5" />
                                    <label for="5"><img src="images/star1.png"></img>
                                                   <img src="images/star1.png"></img>
                                                   <img src="images/star1.png"></img>
                                                   <img src="images/star1.png"></img>
                                                   <img src="images/star1.png"></img></label>
                                    </p>
                                </div>
                            </div>            
                        </div>            
                        <div class="card-action center-align">
                            <input type="submit"
                                   class="btn cyan waves-effect waves-light"
                                   value="Salvar">
                            <a href="detalhes.jsp" 
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


<%@include file="main.jsp" %>
<%@page import="DAO.UsuarioDAO"%>
<%@page import="entidade.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/materialize.min.css"/>
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <title>Recadastro de senha</title>
    </head>
    <body>
         <div class="container">
            <div class="row">
                <div class="col card s6 offset-s3">
                    <form name="recadastrosenha"
                          action="/ServiceMarket/acaousuario?parameter=recadastroSenha"
                          method="post">
                        <div class="card-content">
                            <span class="card-title center-align">
                                Recadastrar Senha</span>    
                            <div class="row">
                                <input type="hidden" 
                                       name="idusuario"
                                       class="validate"
                                       value="<%=logado.getId()%>" />
                                <div class="input-field col s12">
                                    <i class="material-icons prefix">lock_outline</i>
                                    <input name="senhaatual" 
                                           id="senhaatual"
                                           type="password" 
                                           minlength="1"
                                           maxlength="64"
                                           class="validate"
                                           required="required"
                                           autofocus/>
                                    <label for="senhaatual">Senha Atual</label>
                                </div>
                                <div class="input-field col s12">
                                    <i class="material-icons prefix">lock_outline</i>
                                    <input name="novasenha" 
                                           id="novasenha"
                                           type="password" 
                                           minlength="1"
                                           maxlength="64"
                                           class="validate"
                                           required="required"
                                           autofocus/>
                                    <label for="novasenha">Nova Senha</label>
                                </div>
                                <div class="input-field col s12">
                                    <i class="material-icons prefix">lock_outline</i>
                                    <input name="confnovasenha"
                                           id="confnovasenha"
                                           type="password" 
                                           minlength="1"
                                           maxlength="64"
                                           class="validate"
                                           required="required"
                                           autofocus/>
                                    <label for="confnovasenha">Confirma&ccedil;&atilde;o de Nova Senha</label>
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
        <script>
            var novasenha = document.getElementById("novasenha");
            var confnovasenha = document.getElementById("confnovasenha");

            function validarSenhas(){
                if(novasenha.value !== confnovasenha.value) {
                    confnovasenha.setCustomValidity("As senhas devem coincidir!");
                    <%
                        request.setAttribute("senhaatual", null);
                        request.setAttribute("novasenha", null);
                        request.setAttribute("confnovasenha", null);
                    %>
                } else {
                    confnovasenha.setCustomValidity('');
                }
            }

            novasenha.onchange = validarSenhas;
            confnovasenha.onkeyup = validarSenhas;
        </script>
    </body>
</html>

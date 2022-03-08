<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
       <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/materialize.min.css"/>
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <title>Registro de nova conta</title>
    </head>
    <body>
        <div class="container">
            <div class="row">
                <div class="col card s8 offset-s2">
                    <form name="registro"
                          id="registro"
                          action="/ServiceMarket/acaousuario?parameter=registro"
                          method="post">
                        <div class="card-content">
                            <span class="card-title center-align">
                                Registro de nova conta</span>
                            <div class="row">
                                <div class="input-field col s6">
                                    <i class="material-icons prefix">person</i>
                                    <input name="nomeusuario"
                                           type="text"
                                           minlength="1"
                                           maxlength="64"
                                           class="validate"
                                           required="true"
                                           autofocus/>
                                    <label for="nomeusuario">Nome</label>
                                </div>
                                <div class="input-field col s6">
                                    <i class="material-icons prefix">account_circle</i>
                                    <input name="loginusuario"
                                           type="text"
                                           minlength="1"
                                           maxlength="64"
                                           class="validate"
                                           required="true"
                                           autofocus/>
                                    <label for="loginusuario">Login</label>
                                </div>
                                <div class="input-field col s6">
                                    <i class="material-icons prefix">lock_outline</i>
                                    <input name="senha"
                                           id="senha"
                                           type="password"
                                           minlength="1"
                                           maxlength="64"
                                           class="validate"
                                           required="true"
                                           autofocus>
                                    <label for="senha">Senha</label>
                                </div>
                                <div class="input-field col s6">
                                    <i class="material-icons prefix">lock_outline</i>
                                    <input name="confsenha"
                                           id="confsenha"
                                           type="password"
                                           minlength="1"
                                           maxlength="64"
                                           class="validate"
                                           required="true"                                           
                                           autofocus>
                                    <label for="confsenha">Confirma&ccedil;&atilde;o de Senha</label>
                                </div>
                                <div class="input-field col s12">
                                    <i class="material-icons prefix">email</i>
                                    <input name="email"
                                           type="email"
                                           minlength="1"
                                           maxlength="64"
                                           class="validate"
                                           required="true"                                         
                                           autofocus/>
                                    <label for="email">Email</label>
                                </div>
                                <div class="input-field col s12">
                                    <i class="material-icons prefix">location_on</i>
                                    <input name="logradouro"
                                           type="text"
                                           minlength="1"
                                           maxlength="64"
                                           class="validate"
                                           required="true"
                                           autofocus/>
                                    <label for="logradouro">Logradouro</label>
                                </div>
                                <div class="input-field col s6">
                                    <i class="material-icons prefix">my_location</i>
                                    <input name="bairro"
                                           type="text"
                                           minlength="1"
                                           maxlength="64"
                                           class="validate"
                                           required="true"
                                           autofocus/>
                                    <label for="bairro">Bairro</label>   
                                </div>
                                <div class="input-field col s6">
                                    <i class="material-icons prefix">phone</i>
                                    <input name="telefone"
                                           type="tel"
                                           minlength="1"
                                           maxlength="64"
                                           class="validate"
                                           required="true"
                                           autofocus/>
                                    <label for="telefone">Telefone</label>   
                                </div>
                                <div class="col s12">
                                    <p class="centered">
                                        <i class="material-icons prefix">people</i>
                                        <input class="with-gap"
                                               type="radio" 
                                               name="tipo"
                                               id="consumidor"
                                               value="Consumidor" 
                                               required="" />
                                        <label for="consumidor">Consumidor</label>
                                        <input class="with-gap"
                                               type="radio" 
                                               name="tipo" 
                                               id="prestador"
                                               value="Prestador"
                                               required="" />
                                        <label for="prestador">Prestador</label>
                                        <input class="with-gap"
                                               type="radio" 
                                               name="tipo" 
                                               id="ambos"
                                               value="Ambos"
                                               required="" />
                                        <label for="ambos">Ambos</label>
                                    </p>
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
                            <a href="usuarios.jsp" 
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
            var senha = document.getElementById("senha");
            var confsenha = document.getElementById("confsenha");

            function validarSenhas(){
                if(senha.value !== confsenha.value) {
                    confsenha.setCustomValidity("As senhas devem coincidir!");
                    <%
                        request.setAttribute("senha", null);
                        request.setAttribute("confsenha", null);
                    %>
                } else {
                    confsenha.setCustomValidity('');
                }
            }

            senha.onchange = validarSenhas;
            confsenha.onkeyup = validarSenhas;
        </script>
    </body>
</html>                                                                 
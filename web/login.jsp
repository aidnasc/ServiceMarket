<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/style.css"/>
        <link rel="stylesheet" href="css/materialize.min.css"/>
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <title>Login</title>
    </head>
    <body>
        <div class="valign-wrapper row login-box">
            <div class="col card hoverable s10 pull-s1 m6 pull-m3 l4 pull-l4">
                <form name="login"
                      action="/ServiceMarket/acao?parameter=login"
                      method="post">
                    <div class="card-content">
                        <span class="card-title center-align">
                            ServiceMarket - Login</span>
                        <div class="row">
                            <div class="input-field col s12">
                                <i class="material-icons prefix">account_circle</i>
                                <input type="text" 
                                       name="loginusuario" 
                                       value=""
                                       minlength="1"
                                       maxlength="64"
                                       class="validate"
                                       required="true"
                                       autofocus/>
                                <label for="loginusuario">Login de Usu&aacute;rio</label>
                            </div>
                            <div class="input-field col s12">
                                <i class="material-icons prefix">lock_outline</i>
                                <input type="password" 
                                       name="senha" 
                                       value="" 
                                       minlength="1"
                                       maxlength="64"
                                       class="validate"
                                       required="true"
                                       autofocus/>
                                <label for="senha">Senha</label>
                            </div>
                        </div>
                    </div>
                    <div class="card-action center-align ">
                        <input type="submit" name="login"
                               class="btn cyan waves-effect waves-light"
                               value="Entrar">
                        <input type="reset" name="limpar"
                               class="btn cyan waves-effect waves-light"
                               value="Limpar">
                    </div>
                    <div class="card-action center-align">
                        <a class="waves-effect waves-teal btn-flat"
                           href="registro.jsp">N&atilde;o &eacute; registrado&quest; Cadastre-se aqui&excl;</a>
                    </div>
                </form>
            </div>
        </div> 
        <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
        <script src="js/materialize.min.js"></script>
    </body>
</html>

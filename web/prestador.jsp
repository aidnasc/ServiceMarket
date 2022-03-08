<%@include file="main.jsp" %>
<%@page import="entidade.Usuario"%>
<%@page import="DAO.UsuarioDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
       <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/materialize.min.css"/>
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <title>Informa&ccedil;&otilde;es do prestador</title>
    </head>
    <body> 
        <%
            Usuario p = (Usuario) request.getAttribute("uprest");
        %>    
        <div class="container">
            <div class="row">
                <div class="col card s8 offset-s2">
                    <div class="card-content">
                        <span class="card-title center-align">
                            Informa&ccedil;&otilde;es do prestador</span>
                        <div class="row">
                            <div class="col s4">
                                <i class="material-icons prefix">person</i>
                                <label>Nome</label>
                                <input name="nomeusuario"
                                       type="text"
                                       class="validate"
                                       disabled=""
                                       value="<%=p.getNome()%>" />
                            </div>
                            <div class="col s4">
                                <i class="material-icons prefix">email</i>
                                <label>Email</label>
                                <input name="email"
                                       type="email"
                                       class="validate"
                                       disabled="" 
                                       value="<%=p.getEmail()%>" />
                            </div>
                            <div class="col s4">
                                <i class="material-icons prefix">phone</i>
                                <label>Telefone</label>
                                <input name="telefone"
                                       type="tel"
                                       class="validate"
                                       disabled=""
                                       value="<%=p.getTelefone()%>" />   
                            </div>             
                            <div class="col s8">
                                <i class="material-icons prefix">location_on</i>
                                <label>Logradouro</label>
                                <input name="logradouro"
                                       type="text"
                                       maxlength="64"
                                       class="validate"
                                       disabled=""
                                       value="<%=p.getLogradouro()%>" />
                            </div>
                            <div class="col s4">
                                <i class="material-icons prefix">my_location</i>
                                <label>Bairro</label> 
                                <input name="bairro"
                                       type="text"
                                       class="validate"
                                       disabled=""
                                       value="<%=p.getBairro()%>" />  
                            </div>        
                        </div>  
                    </div>          
                    <div class="card-action center-align">
                        <a href="meusservicos.jsp" 
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

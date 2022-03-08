<%@page import="entidade.Usuario"%>
<%@page import="DAO.UsuarioDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/materialize.min.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <title>ServiceMarket</title>
    </head>
    <body>
        <%
            Usuario logado = (Usuario) session.getAttribute("logado");

            if (logado == null) {
                response.sendRedirect("index.jsp");
            } 
            
            if (logado.getTipo().contains("Administrador")) { 
        %>
        <div class="navbar-fixed">
            <ul id="dropdown1" class="dropdown-content">
                <li><a href="editaperfil.jsp">
                    <i class="material-icons left">edit</i>Editar informa&ccedil;&otilde;es</a>
                </li>
                <li class="divider"></li>
                <li><a href="editasenha.jsp">  
                    <i class="material-icons left">lock</i>Modificar senha</a>    
                </li>
            </ul>
	    <ul id="dropdown3" class="dropdown-content">
                <li><a href="meusservicos.jsp">
                    <i class="material-icons left">assignment</i>Minhas solicita&ccedil;&otilde;es</a>
                </li>
                <li class="divider"></li>
                <li><a href="servicosdisponiveis.jsp">  
                    <i class="material-icons left">info_outline</i>Atender solicita&ccedil;&atilde;o</a>    
                </li>
            </ul>
            <nav>
                <div class="nav-wrapper cyan black-text">
                    <a class="brand-logo right"><img src="images/logos.png" height="65" width="200" ></img></a>
                    <ul class="left hide-on-med-and-down">
                        <li><div class="chip">
                            <img src="images/profile.svg" height="55" width="55" ></img>
                            Bem-vindo, <%out.write(logado.getNome());%>
                            </div>
                        </li>
                        <li><a class="dropdown-trigger" data-activates="dropdown1" data-beloworigin="true" data-constrainwidth="false" >Perfil
                            <i class="material-icons left">person_pin</i>
                            <i class="material-icons right">arrow_drop_down</i></a>    
                        </li>
			<li><a href="usuarios.jsp">
                                <i class="material-icons left">people</i>Usu&aacute;rios</a>
                        </li>
                        <li><a href="sugestao.jsp">
                                <i class="material-icons left">question_answer</i>Sugest&atilde;o</a>
                        </li>
                        <li><a href="tiposervico.jsp">
                                <i class="material-icons left">note_add</i>Tipo de servi&ccedil;o</a>
                        </li>
			<li><a class="dropdown-trigger" data-activates="dropdown3" data-beloworigin="true" data-constrainwidth="false" >Servi&ccedil;o
                            <i class="material-icons left">build</i>
                            <i class="material-icons right">arrow_drop_down</i></a>    
                        </li>
                        <li><a class="waves-effect waves-light" 
                               href="/ServiceMarket/acao?parameter=logout"> 
                               <i class="material-icons left">power_settings_new</i>Sair</a></li>
                    </ul>
                </div>
            </nav>
        </div>
        
        <% } else if (logado.getTipo().contains("Consumidor")) { %>
        <div class="navbar-fixed">
            <ul id="dropdown1" class="dropdown-content">
                <li><a href="editaperfil.jsp">
                    <i class="material-icons left">edit</i>Editar informa&ccedil;&otilde;es</a>
                </li>
                <li class="divider"></li>
                <li><a href="editasenha.jsp">  
                    <i class="material-icons left">lock</i>Modificar senha</a>    
                </li>
            </ul>
	    <ul id="dropdown2" class="dropdown-content">
                <li><a href="meusservicos.jsp">
                    <i class="material-icons left">assignment</i>Minhas solicita&ccedil;&otilde;es</a>
                </li>
            </ul>
            <nav>
                <div class="nav-wrapper cyan black-text">
                    <a class="brand-logo right"><img src="images/logos.png" height="65" width="200" ></img></a>
                    <ul class="left hide-on-med-and-down">
                        <li><div class="chip">
                            <img src="images/profile.svg" height="55" width="55" ></img>
                            Bem-vindo, <%out.write(logado.getNome());%>
                            </div>
                        </li>
                        <li><a class="dropdown-trigger" data-activates="dropdown1" data-beloworigin="true" data-constrainwidth="false" >Perfil
                            <i class="material-icons left">person_pin</i>
                            <i class="material-icons right">arrow_drop_down</i></a>    
                        </li>
                        <li><a href="cadsugestao.jsp">
                                <i class="material-icons left">question_answer</i>Sugest&atilde;o</a>
                        </li>
                        <li><a class="dropdown-trigger" data-activates="dropdown2" data-beloworigin="true" data-constrainwidth="false" >Servi&ccedil;o
                            <i class="material-icons left">build</i>
                            <i class="material-icons right">arrow_drop_down</i></a>    
                        </li>
                        <li><a class="waves-effect waves-light" 
                               href="/ServiceMarket/acao?parameter=logout"> 
                               <i class="material-icons left">power_settings_new</i>Sair</a></li>
                    </ul>
                </div>
            </nav>
        </div>
              
        <% } else { %> 
	<div class="navbar-fixed">
            <ul id="dropdown1" class="dropdown-content">
                <li><a href="editaperfil.jsp">
                    <i class="material-icons left">edit</i>Editar informa&ccedil;&otilde;es</a>
                </li>
                <li class="divider"></li>
                <li><a href="editasenha.jsp">  
                    <i class="material-icons left">lock</i>Modificar senha</a>    
                </li>
            </ul>
	    <ul id="dropdown3" class="dropdown-content">
                <li><a href="meusservicos.jsp">
                    <i class="material-icons left">assignment</i>Minhas solicita&ccedil;&otilde;es</a>
                </li>
                <li class="divider"></li>
                <li><a href="servicosdisponiveis.jsp">  
                    <i class="material-icons left">info_outline</i>Atender solicita&ccedil;&atilde;o</a>    
                </li>
            </ul>
            <nav>
                <div class="nav-wrapper cyan black-text">
                    <a class="brand-logo right"><img src="images/logos.png" height="65" width="200" ></img></a>
                    <ul class="left hide-on-med-and-down">
                        <li><div class="chip">
                            <img src="images/profile.svg" height="55" width="55" ></img>
                            Bem-vindo, <%out.write(logado.getNome());%>
                            </div>
                        </li>
                        <li><a class="dropdown-trigger" data-activates="dropdown1" data-beloworigin="true" data-constrainwidth="false" >Perfil
                            <i class="material-icons left">person_pin</i>
                            <i class="material-icons right">arrow_drop_down</i></a>    
                        </li>
                        <li><a href="cadsugestao.jsp">
                                <i class="material-icons left">question_answer</i>Sugest&atilde;o</a>
                        </li>
                        <li><a class="dropdown-trigger" data-activates="dropdown3" data-beloworigin="true" data-constrainwidth="false" >Servi&ccedil;o
                            <i class="material-icons left">build</i>
                            <i class="material-icons right">arrow_drop_down</i></a>    
                        </li>
                        <li><a class="waves-effect waves-light" 
                               href="/ServiceMarket/acao?parameter=logout"> 
                               <i class="material-icons left">power_settings_new</i>Sair</a></li>
                    </ul>
                </div>
            </nav>
        </div>

        <% } %>       
                        
        <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
        <script src="js/materialize.min.js"></script>
        <script>   
            $(document).ready(function () {
                $('.dropdown-trigger').dropdown( { hover: true } );
            });
        </script>                

    </body>
</html>

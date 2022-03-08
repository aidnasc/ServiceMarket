<%@include file="main.jsp" %>
<%@page import="java.util.ArrayList"%>
<%@page import="entidade.Usuario"%>
<%@page import="DAO.UsuarioDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/materialize.min.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <title>Usu&aacute;rios</title>
    </head>
    <body>
        <%
            if (!logado.getTipo().contains("Administrador")) {
                response.sendRedirect("main.jsp");
            }
        %>      
        <div class="container">
            <div class="row">
                <div class="col card s12">
                    <div class="card-content">
                        <span class="card-title left-align">
                            Filtro</span>
                        </span>
                        <div class="row">
                            <div class="col s12">
                                <i class="material-icons prefix">search</i>
                                <label>Descri&ccedil;&atilde;o</label>
                                <input name="filtrologin"
                                       id="filtrologin"
                                       type="text"
                                       placeholder="Digite o login do usuário..."
                                       minlength="1"
                                       maxlength="200"			       	
                                       class="validate" /> 
                            </div>	  
                        </div>
                    </div>                
                </div>                    
            </div>
        </div>

        <div id="excluiUsuarioModal" class="modal">
            <div class="modal-content black-text">
                <h4>Excluir registro</h4>
                <p>Deseja realmente excluir o registro?</p>
            </div>
            <div class="modal-footer">
                <a onclick="excluiUsuario()"
                   class="modal-action modal-close waves-effect waves-green btn-flat">Sim</a>
                <a class="modal-action modal-close waves-effect waves-red btn-flat">Não</a>
            </div>
        </div>

        <div class="container">
            <div class="row">
                <div class="col s12">
                    <table class="striped cyan-text left-align">
                        <thead>
                            <tr>
                                <th><b>A&ccedil;&otilde;es</b></th><th><b>Login</b></th><th><b>Nome</b></th><th><b>Tipo</b></th>
                            </tr>
                        </thead> 

                        <%
                            ArrayList<Object> listaUsuarios = new UsuarioDAO().ativos();
                            for (int i = 0; i < listaUsuarios.size(); i++) {
                                Usuario usrlista = (Usuario) listaUsuarios.get(i);
                        %>

                        <tbody>
                            <tr>
                                <td>
                                    <a data-target="excluiUsuarioModal" data-id="<%=usrlista.getId()%>" id="excluiUsuario"
                                       class="waves-effect waves-teal btn-flat btn-flat modal-trigger"><img src="images/remove.png" title="Excluir" width="28" height="28"></a>
                                </td>
                                <td><%out.write(usrlista.getLogin());%></td>	
                                <td><%out.write(usrlista.getNome());%></td>
                                <td><%out.write(usrlista.getTipo());%></td>
                            </tr>
                        </tbody>                        
                        <%
                            }
                        %>
                    </table>
                </div>
            </div>
        </div>
        <div class="fixed-action-btn horizontal" style="right: 1180px; top: 150px">
            <a class="btn-floating btn-large waves-effect waves-light red"
               onclick="window.open('pdfUsuarios.jsp')">
                <i class="material-icons">picture_as_pdf</i>Relat&oacute;rio</a>
        </div>

        <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
        <script src="js/materialize.min.js"></script>
        <script>
                   $(document).ready(function () {
                       $(".modal").modal();
                   });
                   $('.modal-trigger').on('click', function () {
                       $('#excluiUsuario').val($(this).data('id'));
                   });

                   $('#filtrologin').keyup(function () {
                       var login = $(this).val().toLowerCase();
                       $('table tbody').find('tr').each(function () {
                           var conteudoCelula = $(this).find('td:eq(1)').text();
                           var corresponde = conteudoCelula.toLowerCase().indexOf(login) >= 0;
                           $(this).css('display', corresponde ? '' : 'none');
                       });
                   });

                   function getXMLHttpRequestObject()
                   {
                       var objAjax;

                       if (window.XMLHttpRequest) {
                           objAjax = new XMLHttpRequest();
                       } else if (window.ActiveXObject) {
                           try {
                               objAjax = new ActiveXObject("Msxml2.XMLHTTP");
                           } catch (e) {
                               try {
                                   objAjax = new ActiveXObject("Microsoft.XMLHTTP");
                               } catch (ex) {
                                   objAjax = false;
                               }
                           }
                       }
                       return objAjax;
                   }

                   function excluiUsuario() {
                       var http = new getXMLHttpRequestObject();
                       id = document.getElementById("excluiUsuario").value;
                       var url = "/ServiceMarket/acaousuario?parameter=excluiUsuario&id=" + id;
                       http.onreadystatechange = function () {
                           if (http.readystate === 4) {
                               window.location = "ServiceMarket/usuarios.jsp";
                           }
                       };
                       http.open("GET", url, true);
                       http.send();
                       window.location.reload();
                   }
        </script>
    </body>
</html>
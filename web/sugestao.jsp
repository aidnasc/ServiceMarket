<%@include file="main.jsp" %>
<%@page import="java.util.ArrayList"%>
<%@page import="entidade.Sugestao"%>
<%@page import="DAO.SugestaoDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/materialize.min.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <title>Sugest&otilde;es</title>
    </head>
    <body>
        <%
            if (! logado.getTipo().contains("Administrador")) { 
                response.sendRedirect("cadsugestao.jsp");
            }
        %>
        <div class="modal"
             id="pesquisaModal">
            <div class="modal-content">
                <div class="row">
                    <form class="col s12"
                          onsubmit="pesquisaSugestao()">
                        <div class="input-field col s12">
                            <input id="criterio"
                                   name="criterio"
                                   type="text"
                                   class="validate"
                                   placeholder="Digite o que deseja pesquisar..."
                                   autofocus>
                            <input id="buttonSearch"
                                   name="buttonSearch"
                                   type="submit"
                                   class="btn-flat waves-effect waves-teal right"
                                   value="Pesquisar">
                        </div>
                </div>
            </div>
        </div>

        <div id="aprovaModal" class="modal">
            <div class="modal-content black-text">
                <h4>Aprovar sugest&atilde;o</h4>
                <p>Deseja realmente aprovar a sugest&atilde;o?</p>
            </div>
            <div class="modal-footer">
                <a onclick="aprovaSugestao()"
                   class="modal-action modal-close waves-effect waves-green btn-flat">Sim</a>
                <a class="modal-action modal-close waves-effect waves-red btn-flat">Não</a>
            </div>
        </div>
        
        <div id="rejeitaModal" class="modal">
            <div class="modal-content black-text">
                <h4>Rejeitar sugest&atilde;o</h4>
                <p>Deseja realmente rejeitar a sugest&atilde;o?</p>
            </div>
            <div class="modal-footer">
                <a onclick="rejeitaSugestao()"
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
                                <th><b>A&ccedil;&otilde;es</b></th><th><b>Descri&ccedil;&atilde;o</b></th><th><b>Situa&ccedil;&atilde;o</b></th>
                            </tr>
                        </thead> 

                        <%
                            String criterio = request.getParameter("criterio");
                            if (criterio == null) {
                                ArrayList<Object> listaSugestoes = new SugestaoDAO().todos();
                                for (int i = 0; i < listaSugestoes.size(); i++) {
                                    Sugestao suglista = (Sugestao) listaSugestoes.get(i);
                        %>

                        <tbody>
                            <tr>
                               <td><a data-target="aprovaModal" data-id="<%=suglista.getId()%>" id="aprovaSugestao"
                                   class="waves-effect waves-teal btn-flat btn-flat modal-trigger"><img src="images/approve.jpg" title="Aprovar" width="42" height="28" alt="approve"></a>
                                   <a data-target="rejeitaModal" data-id="<%=suglista.getId()%>" id="rejeitaSugestao"
                                   class="waves-effect waves-teal btn-flat btn-flat modal-trigger"><img src="images/remove.png" title="Rejeitar" width="28" height="28" alt="remove"></a>
                                </td>
                                <td><%out.write(suglista.getSugestao());%></td>
                                <td><%out.write(suglista.getSituacao());%></td>
                             </tr>
                        </tbody>
                        
                        <%
                            }
                        } else {
                            ArrayList<Object> listaSugestoes = new SugestaoDAO().pesquisa(criterio);
                                for (int i = 0; i < listaSugestoes.size(); i++) {
                                    Sugestao suglista = (Sugestao) listaSugestoes.get(i);
                        %>
                        
                        <tbody>
                            <tr>
                            <td><a data-target="aprovaModal" data-id="<%=suglista.getId()%>" id="aprovaSugestao"
                                class="waves-effect waves-teal btn-flat btn-flat modal-trigger"><img src="images/approve.jpg" title="Aprovar" width="42" height="28" alt="approve"></a>
                                <a data-target="rejeitaModal" data-id="<%=suglista.getId()%>" id="rejeitaSugestao"
                                class="waves-effect waves-teal btn-flat btn-flat modal-trigger"><img src="images/remove.png" title="Rejeitar" width="28" height="28" alt="remove"></a>
                            </td>
                            <td><%out.write(suglista.getSugestao());%></td>
                            <td><%out.write(suglista.getSituacao());%></td>
                        </tr>   
                        </tbody>
                        
                        <%
                                }
                            }
                        %>
                        
                    </table>
                </div>
            </div>
        </div>

        <div class="fixed-action-btn horizontal" style="right: 1180px; top: 90px">
            <a class="btn-floating btn-large waves-effect waves-light green"
               href="cadsugestao.jsp">
                <i class="material-icons">add_circle</i>Novo</a>
            <ul>
                <li><a data-target="pesquisaModal"
                       class="btn-floating waves-effect waves-light grey modal-trigger">
                       <i class="material-icons">search</i></a></li>
            </ul>
         </div>

	<div class="fixed-action-btn horizontal" style="right: 1180px; top: 150px">
            <a class="btn-floating btn-large waves-effect waves-light red"
               onclick="window.open('pdfSugestao.jsp')">
                <i class="material-icons">picture_as_pdf</i>Relat&oacute;rio</a>
         </div>
                        
        <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
        <script src="js/materialize.min.js"></script>
        <script>
            $(document).ready(function () {
                $(".modal").modal();
            });
            $('.modal-trigger').on('click', function () {
                $('#rejeitaSugestao').val($(this).data('id'));
                $('#aprovaSugestao').val($(this).data('id'));
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

            function pesquisaSugestao() {
                var http = new getXMLHttpRequestObject();
                criteria = document.getElementById("criterio").value;
                var url = "sugestao.jsp?criterio=" + criterio;
                http.onreadystatechange = function () {
                    if (http.readyState === 4) {
                        document.getElementById("buttonSearch").innerHTML = this.responseText;
                    }
                };
                http.open("GET", url, true);
                http.send();
            }

            function rejeitaSugestao() {
                var http = new getXMLHttpRequestObject();
                id = document.getElementById("rejeitaSugestao").value;
                var url = "/ServiceMarket/acaosugestao?parameter=rejeitaSugestao&id=" + id;
                http.onreadystatechange = function () {
                    if (http.readystate === 4) {
                        window.location = "/ServiceMarket/sugestao.jsp";
                    }
                };
                http.open("GET", url, true);
                http.send();
                window.location.reload();
            }
            
            function aprovaSugestao() {
                var http = new getXMLHttpRequestObject();
                id = document.getElementById("aprovaSugestao").value;
                var url = "/ServiceMarket/acaosugestao?parameter=aprovaSugestao&id=" + id;
                http.onreadystatechange = function () {
                    if (http.readystate === 4) {
                        window.location = "ServiceMarket/sugestao.jsp";
                    }
                };
                http.open("GET", url, true);
                http.send();
                window.location.reload();
            }
        </script>
    </body>
</html>

<%@include file="main.jsp" %>
<%@page import="entidade.Servico"%>
<%@page import="DAO.ServicoDAO"%>
<%@page import="entidade.TipoServico"%>
<%@page import="java.util.ArrayList"%>
<%@page import="DAO.TipoServicoDAO"%>
<%@page import="DAO.UsuarioDAO"%>
<%@page import="apoio.Formatacao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/materialize.min.css"/>
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <title>Detalhes do Servi&ccedil;o</title>
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
        <div id="excluiServicoModal" class="modal">
            <div class="modal-content black-text">
                <h4>Excluir requisi&ccedil;&atilde;o</h4>
                <p>Deseja realmente excluir a requisi&ccedil;&atilde;o?</p>
            </div>
            <div class="modal-footer">
                <a onclick="excluiServico()"
                   class="modal-action modal-close waves-effect waves-green btn-flat">Sim</a>
                <a class="modal-action modal-close waves-effect waves-red btn-flat">Não</a>
            </div>
        </div>
        
        <div id="finalizaServicoModal" class="modal">
            <div class="modal-content black-text">
                <h4>Finalizar servi&ccedil;o</h4>
                <p>Deseja realmente definir o servi&ccedil;o como Finalizado?</p>
            </div>
            <div class="modal-footer">
                <a onclick="finalizaServico()"
                   class="modal-action modal-close waves-effect waves-green btn-flat">Sim</a>
                <a class="modal-action modal-close waves-effect waves-red btn-flat">Não</a>
            </div>
        </div>
        
        <div id="aprovaServicoModal" class="modal">
            <div class="modal-content black-text">
                <h4>Aprovar servi&ccedil;o</h4>
                <p>Deseja realmente aprovar a realiza&ccedil;&atilde;o do servi&ccedil;o?</p>
            </div>
            <div class="modal-footer">
                <a onclick="aprovaServico()"
                   class="modal-action modal-close waves-effect waves-green btn-flat">Sim</a>
                <a class="modal-action modal-close waves-effect waves-red btn-flat">Não</a>
            </div>
        </div>
        
        <div id="rejeitaServicoModal" class="modal">
            <div class="modal-content black-text">
                <h4>Rejeitar servi&ccedil;o</h4>
                <p>Deseja realmente rejeitar a realiza&ccedil;&atilde;o do servi&ccedil;o?</p>
            </div>
            <div class="modal-footer">
                <a onclick="rejeitaServico()"
                   class="modal-action modal-close waves-effect waves-green btn-flat">Sim</a>
                <a class="modal-action modal-close waves-effect waves-red btn-flat">Não</a>
            </div>
        </div>
        
        <div class="container">
            <div class="row">
                <div class="col card s8 offset-s2">
                    <div class="card-content">
                        <span class="card-title center-align">
                            Detalhes do Servi&ccedil;o</span>
                        <div class="row">
                            <div class="col s4">
                                <i class="material-icons prefix">edit</i>
                                <label for="descricao">Descri&ccedil;&atilde;o</label>
                                <input name="descricao"
                                       type="text"
                                       disabled=""
                                       value="<%=serv.getDescricao()%>"/>
                            </div>
                            <div class="col s4">
                                <i class="material-icons prefix">monetization_on</i>
                                <label>Valor</label>
                                <input name="valor"
                                       type="text"
                                       disabled=""
                                       value="<%=serv.getValor()%>"/>
                            </div> 
                            <div class="col s4">
                                <i class="material-icons prefix">build</i>
                                <label>Tipo de Servi&ccedil;o</label>
                                <input name="tiposervico"
                                       type="text"
                                       disabled=""
                                       value="<%=new TipoServicoDAO().getDescricaoPorId(serv.getId_tiposervico())%>"/>
                            </div>     
                            <div class="col s4">
                                <i class="material-icons prefix">speaker_notes</i>
                                <label>Situa&ccedil;&atilde;o</label>
                                <input name="situacao"
                                       type="text"
                                       disabled=""
                                       value="<%=serv.getSituacao()%>"/>
                            </div>
                            <div class="col s4">
                                <i class="material-icons prefix">date_range</i>
                                <label>Agendamento</label>
                                <input name="dataagend"
                                       type="text"
                                       disabled=""
                                       value="<%=Formatacao.ajustaDataDMA(serv.getData_agendamento()+"")%>"/>
                            </div>  
                            <div class="col s4">
                                <i class="material-icons prefix">date_range</i>
                                <label>Realiza&ccedil;&atilde;o</label>
                                <input name="datareal"
                                       type="text"
                                       disabled=""
                                       value="<%=Formatacao.ajustaDataDMA(serv.getData_realizacao()+"")%>"/>
                            </div>  
                            <div class="col s6">
                                <i class="material-icons prefix">person</i>
                                <label>Prestador</label>
                                <input name="prestador"
                                       type="text"
                                       disabled=""
                                       value="<%=new UsuarioDAO().getNomePorId(serv.getId_prestador())%>"/>
                                <a  href="/ServiceMarket/acaoservico?parameter=detalhaPrestador&id=<%=serv.getId_prestador()%>" 
                                class="btn cyan waves-effect waves-light">Detalhes do Prestador</a>    
                            </div>
                            <div class="col s6">
                                <i class="material-icons prefix">star_border</i>
                                <label>Avalia&ccedil;&atilde;o</label>
                                <br/>
                                <input name="avaliacao1"
				       type="image"
				       src="<% if (serv.getAvaliacao() >= 1) { %> images/star1.png <% } else { %> images/star0.png <% } %>"
				       disabled="" />
				<input name="avaliacao2"
				       type="image"
				       src="<% if (serv.getAvaliacao() >= 2) { %> images/star1.png <% } else { %> images/star0.png <% } %>"
				       disabled="" />
				<input name="avaliacao3"
				       type="image"
				       src="<% if (serv.getAvaliacao() >= 3) { %> images/star1.png <% } else { %> images/star0.png <% } %>"
				       disabled="" />
				<input name="avaliacao4"
				       type="image"
				       src="<% if (serv.getAvaliacao() >= 4) { %> images/star1.png <% } else { %> images/star0.png <% } %>"
				       disabled="" />
				<input name="avaliacao5"
				       type="image"
				       src="<% if (serv.getAvaliacao() >= 5) { %> images/star1.png <% } else { %> images/star0.png <% } %>"
				       disabled="" />	
                            </div>    
                        </div>            
                    </div>            
                    <div class="card-action center-align">
                        <% if (serv.getSituacao().contains("andamento")) { %>
                        <a data-target="finalizaServicoModal" data-id="<%=serv.getId()%>" id="finalizaServico"
                        class="btn cyan waves-effect waves-light modal-trigger">Finalizar</a>
                        <a href="meusservicos.jsp" 
                        class="btn cyan waves-effect waves-light">Voltar</a> 
                        <% } else if (serv.getSituacao().contains("Pendente")) { %>
                        <a class="btn cyan waves-effect waves-light"
                        href="/ServiceMarket/acaoservico?parameter=editaServico&id=<%=serv.getId()%>">Editar</a>
                        <a data-target="excluiServicoModal" data-id="<%=serv.getId()%>" id="excluiServico"
                        class="btn cyan waves-effect waves-light modal-trigger">Excluir</a>
                        <a href="meusservicos.jsp" 
                        class="btn cyan waves-effect waves-light">Voltar</a>
                        <% } else if (serv.getSituacao().contains("Finalizado")) { %>
                        <a class="btn cyan waves-effect waves-light"
                        href="/ServiceMarket/acaoservico?parameter=avaliacao&id=<%=serv.getId()%>">Avaliar</a>
                        <a href="meusservicos.jsp" 
                        class="btn cyan waves-effect waves-light">Voltar</a>
                        <% } else if (serv.getSituacao().contains("Aguardando")) { %>
                        <a data-target="aprovaServicoModal" data-id="<%=serv.getId()%>" id="aprovaServico"
                        class="btn cyan waves-effect waves-light modal-trigger">Aprovar</a>
                        <a data-target="rejeitaServicoModal" data-id="<%=serv.getId()%>" id="rejeitaServico"
                        class="btn cyan waves-effect waves-light modal-trigger">Rejeitar</a>
                        <a href="meusservicos.jsp" 
                        class="btn cyan waves-effect waves-light">Voltar</a>
                        <% } else if (serv.getSituacao().contains("Inativo")) { %>
                        <a href="meusservicos.jsp" 
                        class="btn cyan waves-effect waves-light">Voltar</a>
                        <% } %>
                    </div>                
                </div>
            </div>        
        </div>
                                        
        <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
        <script src="js/materialize.min.js"></script>

        <script>          
            $(document).ready(function () {
                $(".modal").modal();
            });

            $('.modal-trigger').on('click', function () {
                $('#excluiServico').val($(this).data('id'));
                $('#rejeitaServico').val($(this).data('id'));
                $('#aprovaServico').val($(this).data('id'));
                $('#finalizaServico').val($(this).data('id'));
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
            
            function excluiServico() {
                var http = new getXMLHttpRequestObject();
                id = document.getElementById("excluiServico").value;
                var url = "/ServiceMarket/acaoservico?parameter=excluiServico&id=" + id;
                http.onreadystatechange = function () {
                    if (http.readystate === 4) {
                        window.location = "/ServiceMarket/meusservicos.jsp";
                    }
                };
                http.open("GET", url, true);
                http.send();
                window.location.reload();
            }
            
            function rejeitaServico() {
                var http = new getXMLHttpRequestObject();
                id = document.getElementById("rejeitaServico").value;
                var url = "/ServiceMarket/acaoservico?parameter=rejeitaServico&id=" + id;
                http.onreadystatechange = function () {
                    if (http.readystate === 4) {
                        window.location = "/ServiceMarket/detalhes.jsp";
                    }
                };
                http.open("GET", url, true);
                http.send();
                window.location.reload();
            }
            
            function aprovaServico() {
                var http = new getXMLHttpRequestObject();
                id = document.getElementById("aprovaServico").value;
                var url = "/ServiceMarket/acaoservico?parameter=aprovaServico&id=" + id;
                http.onreadystatechange = function () {
                    if (http.readystate === 4) {
                        window.location = "ServiceMarket/detalhes.jsp";
                    }
                };
                http.open("GET", url, true);
                http.send();
                window.location.reload();
            }
            
            function finalizaServico() {
                var http = new getXMLHttpRequestObject();
                id = document.getElementById("finalizaServico").value;
                var url = "/ServiceMarket/acaoservico?parameter=finalizaServico&id=" + id;
                http.onreadystatechange = function () {
                    if (http.readystate === 4) {
                        window.location = "ServiceMarket/detalhes.jsp";
                    }
                };
                http.open("GET", url, true);
                http.send();
                window.location.reload();
            }
        </script>  
    </body>
</html>


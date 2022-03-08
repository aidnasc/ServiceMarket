<%@include file="main.jsp" %>
﻿<%@page import="apoio.Formatacao"%>
<%@page import="entidade.TipoServico"%>
<%@page import="DAO.TipoServicoDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="entidade.Servico"%>
<%@page import="DAO.ServicoDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/materialize.min.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <title>Servi&ccedil;os Dispon&iacute;veis</title>
    </head>
    <body>
        <%
            if (logado.getTipo().contains("Consumidor")) {
                response.sendRedirect("meusservicos.jsp");
            }  
        %>
        <div class="container">
            <div class="row">
                <div class="col card s12">
                    <div class="card-content">
                        <span class="card-title left-align">
                            Filtros</span>
                        </span>
                        <div class="row">
                            <div class="col s4">
                                <i class="material-icons prefix">build</i>
                                <label>Tipo de Servi&ccedil;o</label>
                                <select class="centered" id="filtrotiposervico" name="tiposervico"> 
                                    <option value="" disabled selected>Selecione...</option>
                                    <%
                                        ArrayList<Object> tipos = new TipoServicoDAO().ativos();
                                        for (int i = 0; i < tipos.size(); i++) {
                                            TipoServico tiposlista = (TipoServico) tipos.get(i);
                                    %>
                                    <option value="<%=tiposlista.getDescricao()%>"><%=tiposlista.getDescricao()%></option>
                                    <%  }
                                    %>
                                </select>
                            </div>
			    <div class="col s8">
				<i class="material-icons prefix">search</i>
				<label>Descri&ccedil;&atilde;o</label>
				<input name="filtrodescricao"
				       id="filtrodescricao"
				       type="text"
				       placeholder="Digite a descrição do serviço..."
				       minlength="1"
				       maxlength="200"			       	
				       class="validate" /> 
		            </div>	  
                        </div>
                    </div>                
                </div>                    
            </div>
        </div>                                                       
                              
        <div class="container">
            <div class="row">
                <div class="col s12">
                    <table class="striped cyan-text left-align">
                        <thead>
                            <tr>
                                <th><b>A&ccedil;&otilde;es</b></th><th><b>Descri&ccedil;&atilde;o</b></th><th><b>Tipo de Servi&ccedil;o</b></th>
                                <th><b>Data de Agendamento</b></th><th><b>Situa&ccedil;&atilde;o</b></th>
                            </tr>
                        </thead>
                        <%
                            ArrayList<Object> listaServicosUsuario = new ServicoDAO().pendentes();
                            for (int i = 0; i < listaServicosUsuario.size(); i++) {
                                Servico servlista = (Servico) listaServicosUsuario.get(i);    
                        %>
                        <tbody>
                            <tr>
                                <td>
                                   <a class="waves-effect waves-teal btn-flat"
                                   href="/ServiceMarket/acaoservico?parameter=atendimento&id=<%=servlista.getId()%>">
                                   <img src="images/detail.png" title="Ver Detalhes" width="28" height="28" alt="detail"></a>
                                </td>
                                <td><%out.write(servlista.getDescricao());%></td>
                                <td><%out.write(new TipoServicoDAO().getDescricaoPorId(servlista.getId_tiposervico()));%></td>
                                <td><%out.write(Formatacao.ajustaDataDMA(servlista.getData_agendamento()+""));%></td>
                                <td><%out.write(servlista.getSituacao());%></td>
                            </tr>    
                        </tbody>
                        <% } %>
                    </table>
                </div>
            </div>
        </div>              
                        
        <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
        <script src="js/materialize.min.js"></script>
        <script>
	    $('select[name=tiposervico]').material_select();
    
            $('#filtrodescricao').keyup(function() {
    		var descricao = $(this).val().toLowerCase();
    	    $('table tbody').find('tr').each(function() {
            	var conteudoCelula = $(this).find('td:eq(1)').text();
            	var corresponde = conteudoCelula.toLowerCase().indexOf(descricao) >= 0;
                $(this).css('display', corresponde ? '' : 'none');
    		});
	    });	

            $("#filtrotiposervico").on('change', function() {
                var tiposervico = $(this).val().toLowerCase();
    	    $('table tbody').find('tr').each(function() {
            	var conteudoCelula = $(this).find('td:eq(2)').text();
            	var corresponde = conteudoCelula.toLowerCase().indexOf(tiposervico) >= 0;
                $(this).css('display', corresponde ? '' : 'none');
    		});
            });
        </script>                            
    </body>
</html>

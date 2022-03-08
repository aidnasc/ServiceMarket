/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import apoio.Conexao;
import apoio.Formatacao;
import entidade.Servico;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.util.ArrayList;

/**
 *
 * @author Airan Iuri
 */
public class ServicoDAO implements InterfaceDAO {

    @Override
    public void salvar(Object o) {
        Servico s = (Servico) o;
        
        try {
            LocalDate data = java.time.LocalDate.now();    
            String dataAjustada = Formatacao.ajustaDataDMA(data+"");
            Conexao con = new Conexao();
            ResultSet rs = con.executaQuery("INSERT INTO servico VALUES ("
                    + "DEFAULT, "
                    + "'"+s.getDescricao()+"', "
                    + 0.00+", "
                    + "'"+dataAjustada+"', "
                    + null+", "
                    + null+", "
                    + "'Pendente', "
                    + s.getId_tiposervico()+", "
                    + s.getId_solicitante()+", "
                    + null+"); ");
            
            rs.close();
            con.encerra();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void atualizar(Object o) {
        Servico s = (Servico) o;
        
        try {
            Conexao con = new Conexao();
            ResultSet rs = con.executaQuery("UPDATE servico SET "
                    + "descricao = '"+s.getDescricao()+"', "
                    + "id_tiposervico = "+s.getId_tiposervico()+" "
                    + "WHERE id = "+s.getId()+";");
            
            rs.close();
            con.encerra();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void desativar(String id) {
        try {
            int iId = Integer.parseInt(id);
            Conexao con = new Conexao();
            ResultSet rs = con.executaQuery("UPDATE servico SET "
                    + "situacao = 'Inativo' "
                    + "WHERE id ="+iId);
            
            rs.close();
            con.encerra();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public ArrayList<Object> ativos() {
        ArrayList<Object> listaServicos = new ArrayList<>();

        try {
            Conexao con = new Conexao();
            ResultSet rs = con.executaQuery("SELECT * FROM servico WHERE situacao = 'Pendente' OR situacao = 'Em andamento' ORDER BY id");

            while (rs.next()) {
                Servico s = new Servico();
                s.setId(rs.getInt("id"));
                s.setDescricao(rs.getString("descricao"));
                s.setValor(rs.getDouble("valor"));
                s.setData_agendamento(rs.getDate("data_agendamento"));
                s.setData_realizacao(rs.getDate("data_realizacao"));
                s.setAvaliacao(rs.getInt("avaliacao"));
                s.setSituacao(rs.getString("situacao"));
                s.setId_tiposervico(rs.getInt("id_tiposervico"));
                s.setId_solicitante(rs.getInt("id_solicitante"));
                s.setId_prestador(rs.getInt("id_prestador"));
                listaServicos.add(s);
            }

            rs.close();
            con.encerra();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return listaServicos;
    }

    @Override
    public ArrayList<Object> todos() {
        ArrayList<Object> listaServicos = new ArrayList<>();

        try {
            Conexao con = new Conexao();
            ResultSet rs = con.executaQuery("SELECT * FROM servico ORDER BY id");

            while (rs.next()) {
                Servico s = new Servico();
                s.setId(rs.getInt("id"));
                s.setDescricao(rs.getString("descricao"));
                s.setValor(rs.getDouble("valor"));
                s.setData_agendamento(rs.getDate("data_agendamento"));
                s.setData_realizacao(rs.getDate("data_realizacao"));
                s.setAvaliacao(rs.getInt("avaliacao"));
                s.setSituacao(rs.getString("situacao"));
                s.setId_tiposervico(rs.getInt("id_tiposervico"));
                s.setId_solicitante(rs.getInt("id_solicitante"));
                s.setId_prestador(rs.getInt("id_prestador"));
                listaServicos.add(s);
            }

            rs.close();
            con.encerra();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return listaServicos;
    }

    @Override
    public ArrayList<Object> pesquisa(String criterio) {
        ArrayList<Object> listaServicos = new ArrayList<>();

        try {
            Conexao con = new Conexao();
            ResultSet rs = con.executaQuery("SELECT * FROM servico "
                    + "WHERE (descricao LIKE '%"+criterio+"%' "
                    + "OR data_agendamento LIKE '%"+Formatacao.ajustaDataDMA(criterio)+"' "
                    + "OR data_realizacao LIKE '%"+Formatacao.ajustaDataDMA(criterio)+"') "        
                    + "AND situacao = 'Pendente' OR situacao = 'Em andamento' "
                    + "ORDER BY id");

            while (rs.next()) {
                Servico s = new Servico();
                s.setId(rs.getInt("id"));
                s.setDescricao(rs.getString("descricao"));
                s.setValor(rs.getDouble("valor"));
                s.setData_agendamento(rs.getDate("data_agendamento"));
                s.setData_realizacao(rs.getDate("data_realizacao"));
                s.setAvaliacao(rs.getInt("avaliacao"));
                s.setSituacao(rs.getString("situacao"));
                s.setId_tiposervico(rs.getInt("id_tiposervico"));
                s.setId_solicitante(rs.getInt("id_solicitante"));
                s.setId_prestador(rs.getInt("id_prestador"));
                listaServicos.add(s);
            }

            rs.close();
            con.encerra();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return listaServicos;
    }

    @Override
    public Object consultarId(String id) {
        Servico s = new Servico();

        try {
            int iId = Integer.parseInt(id);
            Conexao con = new Conexao();
            ResultSet rs = con.executaQuery("SELECT * FROM servico "
                    + "WHERE id = "+iId);
            
            if (rs.next()) {
                s.setId(rs.getInt("id"));
                s.setDescricao(rs.getString("descricao"));
                s.setValor(rs.getDouble("valor"));
                s.setData_agendamento(rs.getDate("data_agendamento"));
                s.setData_realizacao(rs.getDate("data_realizacao"));
                s.setAvaliacao(rs.getInt("avaliacao"));
                s.setSituacao(rs.getString("situacao"));
                s.setId_tiposervico(rs.getInt("id_tiposervico"));
                s.setId_solicitante(rs.getInt("id_solicitante"));
                s.setId_prestador(rs.getInt("id_prestador"));
                con.encerra();
                return s;
            } else {
                rs.close();
                con.encerra();
                return null;
            }

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    
    public void atender(Object o) {
        Servico s = (Servico) o;
        
        try {
            Conexao con = new Conexao();
            ResultSet rs = con.executaQuery("UPDATE servico SET "
                    + "valor = "+s.getValor()+", "
                    + "id_prestador = "+s.getId_prestador()+", "
                    + "data_realizacao = '"+Formatacao.ajustaDataDMA(s.getData_realizacao()+"")+"', "
                    + "situacao = 'Aguardando aprovação' "
                    + "WHERE id = "+s.getId()+";");
            
            rs.close();
            con.encerra();
        } catch (Exception e) {
            e.printStackTrace();
        } 
    }
    
    public void aprovar(String id) {
        try {
            int iId = Integer.parseInt(id);
            Conexao con = new Conexao();
            ResultSet rs = con.executaQuery("UPDATE servico SET "
                    + "situacao = 'Em andamento' "
                    + "WHERE id = "+iId+";");
            
            rs.close();
            con.encerra();
        } catch (Exception e) {
            e.printStackTrace();
        } 
    }
    
    public void rejeitar(String id) {
        try {
            int iId = Integer.parseInt(id);
            Conexao con = new Conexao();
            ResultSet rs = con.executaQuery("UPDATE servico SET "
                    + "valor = 0.00, "
                    + "data_realizacao = null, "
                    + "id_prestador = null, "
                    + "situacao = 'Pendente' "
                    + "WHERE id = "+iId+";");
            
            rs.close();
            con.encerra();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public void finalizar(String id) {
        try {
            int iId = Integer.parseInt(id);
            Conexao con = new Conexao();
            ResultSet rs = con.executaQuery("UPDATE servico SET "
                    + "situacao = 'Finalizado' "
                    + "WHERE id = "+iId+";");
            
            rs.close();
            con.encerra();
        } catch (Exception e) {
            e.printStackTrace();
        } 
    }
    
    public ArrayList<Object> todosUsuario(String id) {
        ArrayList<Object> listaServicos = new ArrayList<>();

        try {
            int iId = Integer.parseInt(id);
            Conexao con = new Conexao();
            ResultSet rs = con.executaQuery("SELECT * FROM servico "
                    + "WHERE id_solicitante = "+iId+" "
                    + "ORDER BY id");

            while (rs.next()) {
                Servico s = new Servico();
                s.setId(rs.getInt("id"));
                s.setDescricao(rs.getString("descricao"));
                s.setValor(rs.getDouble("valor"));
                s.setData_agendamento(rs.getDate("data_agendamento"));
                s.setData_realizacao(rs.getDate("data_realizacao"));
                s.setAvaliacao(rs.getInt("avaliacao"));
                s.setSituacao(rs.getString("situacao"));
                s.setId_tiposervico(rs.getInt("id_tiposervico"));
                s.setId_solicitante(rs.getInt("id_solicitante"));
                s.setId_prestador(rs.getInt("id_prestador"));
                listaServicos.add(s);
            }

            rs.close();
            con.encerra();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return listaServicos;
    }
    
    public ArrayList<Object> pendentes() {
        ArrayList<Object> listaServicos = new ArrayList<>();

        try {
            Conexao con = new Conexao();
            ResultSet rs = con.executaQuery("SELECT * FROM servico "
                    + "WHERE situacao = 'Pendente' "
                    + "ORDER BY id");

            while (rs.next()) {
                Servico s = new Servico();
                s.setId(rs.getInt("id"));
                s.setDescricao(rs.getString("descricao"));
                s.setValor(rs.getDouble("valor"));
                s.setData_agendamento(rs.getDate("data_agendamento"));
                s.setData_realizacao(rs.getDate("data_realizacao"));
                s.setAvaliacao(rs.getInt("avaliacao"));
                s.setSituacao(rs.getString("situacao"));
                s.setId_tiposervico(rs.getInt("id_tiposervico"));
                s.setId_solicitante(rs.getInt("id_solicitante"));
                s.setId_prestador(rs.getInt("id_prestador"));
                listaServicos.add(s);
            }

            rs.close();
            con.encerra();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return listaServicos;
    }
    
    public void avaliaServico(String id, int avaliacao) {
        try {
            int iId = Integer.parseInt(id);
            Conexao con = new Conexao();
            ResultSet rs = con.executaQuery("UPDATE servico SET "
                    + "avaliacao = "+avaliacao+" "
                    + "WHERE id = "+iId+";");

            rs.close();
            con.encerra();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

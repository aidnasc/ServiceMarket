/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import apoio.Conexao;
import entidade.TipoServico;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 *
 * @author Airan Iuri
 */
public class TipoServicoDAO implements InterfaceDAO {

    @Override
    public void salvar(Object o) {
        TipoServico t = (TipoServico) o;
        
        try {
            Conexao con = new Conexao();
            ResultSet rs = con.executaQuery("INSERT INTO tiposervico VALUES ("
                    + "DEFAULT, "
                    + "'"+t.getDescricao()+"', "
                    + "'A');");
            
            rs.close();
            con.encerra();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void atualizar(Object o) {
        TipoServico t = (TipoServico) o;
        
        try {
            Conexao con = new Conexao();
            ResultSet rs = con.executaQuery("UPDATE tiposervico SET "
                    + "descricao = '"+t.getDescricao()+"' "
                    + "WHERE id = "+t.getId()+";");
            
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
            ResultSet rs = con.executaQuery("UPDATE tiposervico SET "
                    + "situacao = 'I' "
                    + "WHERE id ="+iId);
            
            rs.close();
            con.encerra();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public ArrayList<Object> ativos() {
        ArrayList<Object> listaTipos = new ArrayList<>();

        try {
            Conexao con = new Conexao();
            ResultSet rs = con.executaQuery("SELECT * FROM tiposervico WHERE situacao = 'A' ORDER BY id");

            while (rs.next()) {
                TipoServico t = new TipoServico();
                t.setId(rs.getInt("id"));
                t.setDescricao(rs.getString("descricao"));
                t.setSituacao(rs.getString("situacao"));
                listaTipos.add(t);
            }

            rs.close();
            con.encerra();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return listaTipos;
    }

    @Override
    public ArrayList<Object> todos() {
        ArrayList<Object> listaTipos = new ArrayList<>();

        try {
            Conexao con = new Conexao();
            ResultSet rs = con.executaQuery("SELECT * FROM tiposervico ORDER BY id");

            while (rs.next()) {
                TipoServico t = new TipoServico();
                t.setId(rs.getInt("id"));
                t.setDescricao(rs.getString("descricao"));
                t.setSituacao(rs.getString("situacao"));
                listaTipos.add(t);
            }

            rs.close();
            con.encerra();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return listaTipos;
    }

    @Override
    public ArrayList<Object> pesquisa(String criterio) {
        ArrayList<Object> listaTipos = new ArrayList<>();

        try {
            Conexao con = new Conexao();
            ResultSet rs = con.executaQuery("SELECT * FROM tiposervico "
                    + "WHERE descricao LIKE '%"+criterio+"%' "       
                    + "AND situacao = 'A' "
                    + "ORDER BY id");

            while (rs.next()) {
                TipoServico t = new TipoServico();
                t.setId(rs.getInt("id"));
                t.setDescricao(rs.getString("descricao"));
                t.setSituacao(rs.getString("situacao"));
                listaTipos.add(t);
            }

            rs.close();
            con.encerra();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return listaTipos;
    }

    @Override
    public Object consultarId(String id) {
        TipoServico t = new TipoServico();
        
        try {
            int iId = Integer.parseInt(id);
            Conexao con = new Conexao();
            ResultSet rs = con.executaQuery("SELECT * FROM tiposervico "
                    + "WHERE id = "+iId);

            if (rs.next()) {
                t.setId(rs.getInt("id"));
                t.setDescricao(rs.getString("descricao"));
                t.setSituacao(rs.getString("situacao"));
                con.encerra();
                return t;
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
    
    public String getDescricaoPorId(int id) {
        String descricao = "";
        
        try {
            Conexao con = new Conexao();
            ResultSet rs = con.executaQuery("SELECT descricao FROM tiposervico "
                    + "WHERE id = "+id);

            if (rs.next()) {
                descricao = rs.getString("descricao");
            } 

            rs.close();
            con.encerra();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return descricao;
    }
    
}

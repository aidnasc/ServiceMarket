/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import apoio.Conexao;
import entidade.Sugestao;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 *
 * @author Airan Iuri
 */
public class SugestaoDAO implements InterfaceDAO {

    @Override
    public void salvar(Object o) {
        Sugestao s = (Sugestao) o;
        
        try {
            Conexao con = new Conexao();
            ResultSet rs = con.executaQuery("INSERT INTO sugestao VALUES ("
                    + "DEFAULT, "
                    + "'"+s.getSugestao()+"', "
                    + "'Pendente');");
            
            rs.close();
            con.encerra();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void atualizar(Object o) {
        Sugestao s = (Sugestao) o;
        
        try {
            Conexao con = new Conexao();
            ResultSet rs = con.executaQuery("UPDATE sugestao SET "
                    + "sugestao = '"+s.getSugestao()+"' "
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
            ResultSet rs = con.executaQuery("UPDATE sugestao SET "
                    + "situacao = 'Rejeitada' "
                    + "WHERE id ="+iId);
            
            rs.close();
            con.encerra();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public ArrayList<Object> ativos() {
        ArrayList<Object> listaSugestoes = new ArrayList<>();

        try {
            Conexao con = new Conexao();
            ResultSet rs = con.executaQuery("SELECT * FROM sugestao WHERE situacao = 'A' ORDER BY id");

            while (rs.next()) {
                Sugestao s = new Sugestao();
                s.setId(rs.getInt("id"));
                s.setSugestao(rs.getString("sugestao"));
                s.setSituacao(rs.getString("situacao"));
                listaSugestoes.add(s);
            }

            rs.close();
            con.encerra();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return listaSugestoes;
    }

    @Override
    public ArrayList<Object> todos() {
        ArrayList<Object> listaSugestoes = new ArrayList<>();

        try {
            Conexao con = new Conexao();
            ResultSet rs = con.executaQuery("SELECT * FROM sugestao ORDER BY id");

            while (rs.next()) {
                Sugestao s = new Sugestao();
                s.setId(rs.getInt("id"));
                s.setSugestao(rs.getString("sugestao"));
                s.setSituacao(rs.getString("situacao"));
                listaSugestoes.add(s);
            }

            rs.close();
            con.encerra();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return listaSugestoes;
    }

    @Override
    public ArrayList<Object> pesquisa(String criterio) {
        ArrayList<Object> listaSugestoes = new ArrayList<>();

        try {
            Conexao con = new Conexao();
            ResultSet rs = con.executaQuery("SELECT * FROM sugestao "
                    + "WHERE sugestao LIKE '%"+criterio+"%' "       
                    + "ORDER BY id");

            while (rs.next()) {
                Sugestao s = new Sugestao();
                s.setId(rs.getInt("id"));
                s.setSugestao(rs.getString("sugestao"));
                s.setSituacao(rs.getString("situacao"));
                listaSugestoes.add(s);
            }

            rs.close();
            con.encerra();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return listaSugestoes;
    }

    @Override
    public Object consultarId(String id) {
        Sugestao s = new Sugestao();
        
        try {
            int iId = Integer.parseInt(id);
            Conexao con = new Conexao();
            ResultSet rs = con.executaQuery("SELECT * FROM sugestao "
                    + "WHERE id = "+iId);

            if (rs.next()) {
                s.setId(rs.getInt("id"));
                s.setSugestao(rs.getString("sugestao"));
                s.setSituacao(rs.getString("situacao"));
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
    
    public void aprovar(String id) {
        try {
            int iId = Integer.parseInt(id);
            Conexao con = new Conexao();
            ResultSet rs = con.executaQuery("UPDATE sugestao SET "
                    + "situacao = 'Aprovada' "
                    + "WHERE id ="+iId);
            
            rs.close();
            con.encerra();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
}

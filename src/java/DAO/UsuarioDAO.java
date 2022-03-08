/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import apoio.Conexao;
import apoio.Formatacao;
import apoio.SHA1;
import entidade.Usuario;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Random;

/**
 *
 * @author Airan Iuri
 */
public class UsuarioDAO implements InterfaceDAO {

    @Override
    public void salvar(Object o) {
        Usuario u = (Usuario) o;
        
        try {
            int salt = new Random().nextInt();
            LocalDate data = java.time.LocalDate.now();
            String hash = SHA1.hash(u.getSenha()+salt);    
            String dataAjustada = Formatacao.ajustaDataDMA(data+"");
            Conexao con = new Conexao();
            ResultSet rs = con.executaQuery("INSERT INTO usuario VALUES ("
                    + "DEFAULT, "
                    + "'"+u.getNome()+"', "
                    + "'"+u.getLogin()+"', "
                    + "'"+hash+"', "
                    + "'"+dataAjustada+"', "
                    + "'"+u.getLogradouro()+"', "
                    + "'"+u.getBairro()+"', "
                    + "'"+u.getTelefone()+"', "
                    + "'"+u.getEmail()+"', "
                    + "'"+u.getTipo()+"', "
                    + "'A', "
                    + salt+"); ");
            
            rs.close();
            con.encerra();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void atualizar(Object o) {
        Usuario u = (Usuario) o;
        
        try {
            Conexao con = new Conexao();
            ResultSet rs = con.executaQuery("UPDATE usuario SET "
                    + "nome = '"+u.getNome()+"', "
                    + "login = '"+u.getLogin()+"', "
                    + "logradouro = '"+u.getLogradouro()+"', "
                    + "bairro = '"+u.getBairro()+"', "
                    + "telefone = '"+u.getTelefone()+"', "
                    + "email = '"+u.getEmail()+"', "
                    + "tipo = '"+u.getTipo()+"' "
                    + "WHERE id = "+u.getId()+";");
            
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
            ResultSet rs = con.executaQuery("UPDATE usuario SET "
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
        ArrayList<Object> listaUsuarios = new ArrayList<>();

        try {
            Conexao con = new Conexao();
            ResultSet rs = con.executaQuery("SELECT * FROM usuario WHERE situacao = 'A' ORDER BY id");

            while (rs.next()) {
                Usuario u = new Usuario();
                u.setId(rs.getInt("id"));
                u.setNome(rs.getString("nome"));
                u.setLogin(rs.getString("login"));
                u.setSenha(rs.getString("senha"));
                u.setDatacadastro(rs.getDate("datacadastro"));
                u.setLogradouro(rs.getString("logradouro"));
                u.setBairro(rs.getString("bairro"));
                u.setTelefone(rs.getString("telefone"));
                u.setEmail(rs.getString("email"));
                u.setTipo(rs.getString("tipo"));
                u.setSituacao(rs.getString("situacao"));
                u.setSalt(rs.getInt("salt"));
                listaUsuarios.add(u);
            }

            rs.close();
            con.encerra();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return listaUsuarios;
    }
    
    @Override
    public ArrayList<Object> todos() {
        ArrayList<Object> listaUsuarios = new ArrayList<>();

        try {
            Conexao con = new Conexao();
            ResultSet rs = con.executaQuery("SELECT * FROM usuario ORDER BY id");

            while (rs.next()) {
                Usuario u = new Usuario();
                u.setId(rs.getInt("id"));
                u.setNome(rs.getString("nome"));
                u.setLogin(rs.getString("login"));
                u.setSenha(rs.getString("senha"));
                u.setDatacadastro(rs.getDate("datacadastro"));
                u.setLogradouro(rs.getString("logradouro"));
                u.setBairro(rs.getString("bairro"));
                u.setTelefone(rs.getString("telefone"));
                u.setEmail(rs.getString("email"));
                u.setTipo(rs.getString("tipo"));
                u.setSituacao(rs.getString("situacao"));
                u.setSalt(rs.getInt("salt"));
                listaUsuarios.add(u);
            }

            rs.close();
            con.encerra();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return listaUsuarios;
    }
    
    @Override
    public ArrayList<Object> pesquisa(String criterio) {
        ArrayList<Object> listaUsuarios = new ArrayList<>();

        try {
            Conexao con = new Conexao();
            ResultSet rs = con.executaQuery("SELECT * FROM usuario "
                    + "WHERE (nome LIKE '%"+criterio+"%' "
                    + "OR login LIKE '%"+criterio+"' "
                    + "OR datacadastro LIKE '%"+Formatacao.ajustaDataDMA(criterio)+"' "
                    + "OR logradouro LIKE '%"+criterio+"' "
                    + "OR bairro LIKE '%"+criterio+"' "
                    + "OR email LIKE '%"+criterio+"' "
                    + "OR tipo LIKE '%"+criterio+"') "        
                    + "AND situacao = 'A' "
                    + "ORDER BY id");

            while (rs.next()) {
                Usuario u = new Usuario();
                u.setId(rs.getInt("id"));
                u.setNome(rs.getString("nome"));
                u.setLogin(rs.getString("login"));
                u.setSenha(rs.getString("senha"));
                u.setDatacadastro(rs.getDate("datacadastro"));
                u.setLogradouro(rs.getString("logradouro"));
                u.setBairro(rs.getString("bairro"));
                u.setTelefone(rs.getString("telefone"));
                u.setEmail(rs.getString("email"));
                u.setTipo(rs.getString("tipo"));
                u.setSituacao(rs.getString("situacao"));
                u.setSalt(rs.getInt("salt"));
                listaUsuarios.add(u);
            }

            rs.close();
            con.encerra();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return listaUsuarios;
    }

    @Override
    public Object consultarId(String id) {
        Usuario u = new Usuario();
        
        try {
            int iId = Integer.parseInt(id);
            Conexao con = new Conexao();
            ResultSet rs = con.executaQuery("SELECT * FROM usuario "
                    + "WHERE id = "+iId);

            if (rs.next()) {
                u.setId(rs.getInt("id"));
                u.setNome(rs.getString("nome"));
                u.setLogin(rs.getString("login"));
                u.setSenha(rs.getString("senha"));
                u.setDatacadastro(rs.getDate("datacadastro"));
                u.setLogradouro(rs.getString("logradouro"));
                u.setBairro(rs.getString("bairro"));
                u.setTelefone(rs.getString("telefone"));
                u.setEmail(rs.getString("email"));
                u.setTipo(rs.getString("tipo"));
                u.setSituacao(rs.getString("situacao"));
                u.setSalt(rs.getInt("salt"));
                con.encerra();
                return u;
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
    
    public int getIdPorLogin(String login) {
        int id = 0;
        
        try {
            Conexao con = new Conexao();
            ResultSet rs = con.executaQuery("SELECT id FROM usuario "
                    + "WHERE login = '"+login+"'; ");
            
            if (rs.next()) {
                id = rs.getInt("id");
            }
            
            rs.close();
            con.encerra();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return id;
    }
    
    public String getNomePorId(int id) {
        String nome = "";
        
        try {
            Conexao con = new Conexao();
            ResultSet rs = con.executaQuery("SELECT nome FROM usuario "
                    + "WHERE id = "+id);
            
            if (rs.next()) {
                nome = rs.getString("nome");
            }
            
            rs.close();
            con.encerra();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return nome;
    }
    
    public boolean autenticaUsuario(String login, String senha, int salt) {
        boolean autenticado = false;
        
        try {
            String hash = SHA1.hash(senha+salt);
            Conexao con = new Conexao();
            ResultSet rs = con.executaQuery("SELECT * FROM usuario "
                    + "WHERE situacao = 'A' AND login = '"+login+"' AND "
                    + "senha = '"+hash+"';");
            
            if (rs.next()) {
                autenticado = true;
            }
            
            rs.close();
            con.encerra();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return autenticado;
    }
    
    public int consultaSalt(String login) {
        int salt = 0;
        
        try {
            Conexao con = new Conexao();
            ResultSet rs = con.executaQuery("SELECT salt FROM usuario "
                    + "WHERE login = '"+login+"';");
            
            if (rs.next()) {
                salt = rs.getInt("salt");
            }
            
            rs.close();
            con.encerra();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return salt;
    }
    
    public boolean verificaSenha(Object o, String senha) {
        boolean ok = false;
        Usuario u = (Usuario) o;
        
        try {
            String hashnovo = SHA1.hash(senha+u.getSalt());
            Conexao con = new Conexao();
            ResultSet rs = con.executaQuery("SELECT senha FROM usuario "
                    + "WHERE id = "+u.getId()+";");
            
            if (rs.next()) {
                if (rs.getString("senha").equals(hashnovo)) {
                    ok = true;
                }
            }
            
            rs.close();
            con.encerra();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return ok;
    }
    
    public void atualizaSenha(Object o) {
        Usuario u = (Usuario) o;
        
        try {
            String hash = SHA1.hash(u.getSenha()+u.getSalt());
            Conexao con = new Conexao();
            ResultSet rs = con.executaQuery("UPDATE usuario SET "
                    + "senha = '"+hash+"' "
                    + "WHERE id ="+u.getId()+";");
            
            rs.close();
            con.encerra();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

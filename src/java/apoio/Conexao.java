/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package apoio;

import DAO.UsuarioDAO;
import entidade.Usuario;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Airan Iuri
 */
public class Conexao {
    private final String nomeDriver = "org.postgresql.Driver";
    private final String localBancoDados = "jdbc:postgresql://localhost:5432/servicemarket";
    private final String usuario = "postgres";
    private final String senha = "postgres";
    private Connection conexao = null;

    public Conexao() {
        conecta();
    }

    public void conecta() {
        try {
            Class.forName(nomeDriver).newInstance();
            conexao = DriverManager.getConnection(localBancoDados, usuario, senha);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public Connection getConexao(){
        try{
           Class.forName(nomeDriver).newInstance();
           conexao = DriverManager.getConnection(localBancoDados, usuario, senha);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return conexao;
    }
    
    public void encerra() {
        try {
            conexao.close();
        } catch (Exception e) {
            e.printStackTrace();
        }   
    }
    
    public ResultSet executaQuery(String sql) {
        ResultSet rs = null;
        try {
            Statement st = conexao.createStatement();
            rs = st.executeQuery(sql);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return rs;
    }
}

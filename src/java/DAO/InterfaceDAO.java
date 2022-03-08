/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import java.util.ArrayList;

/**
 *
 * @author Airan Iuri
 */
public interface InterfaceDAO {
    public void salvar(Object o);

    public void atualizar(Object o);

    public void desativar(String id);
    
    public ArrayList<Object> ativos();
    
    public ArrayList<Object> todos();
    
    public ArrayList<Object> pesquisa(String criterio);

    public Object consultarId(String id);
}

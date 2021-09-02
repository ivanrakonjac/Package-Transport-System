/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package student;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;
import rs.etf.sab.operations.CityOperations;

/**
 *
 * @author Ika
 */
public class ri170656_CityOperations implements CityOperations{

    @Override
    public int insertCity(String name, String zipCode) {
        
       int id = -1;
        
        Connection conn=DB.getInstance().getConnection();
        String query="insert into City(Name, ZipCode) values (?, ?)";
        try (PreparedStatement stmt=conn.prepareStatement(query, PreparedStatement.RETURN_GENERATED_KEYS);){
            stmt.setString(1, name);
            stmt.setInt(2, Integer.parseInt(zipCode));
            stmt.executeUpdate();
            ResultSet rs = stmt.getGeneratedKeys();
            if(rs.next()){
                id = rs.getInt(1);
            }
        } catch (SQLException ex) {
        }
        return id;
    }

    @Override
    public int deleteCity(String... names) {
        
        int numOfDeleted = 0;
        
        if(names.length == 0)
            return numOfDeleted;
        
        Connection conn=DB.getInstance().getConnection();
        String query="delete from City where Name=?";
        
        try (PreparedStatement stmt=conn.prepareStatement(query);){
            for (String name : names) {
                stmt.setString(1, name);
                numOfDeleted = numOfDeleted + stmt.executeUpdate();
            }

        } catch (SQLException ex) {
            
        }
        
        return numOfDeleted;      
    }

    @Override
    public boolean deleteCity(int CityID) {
        boolean success  = false;
        
        Connection conn=DB.getInstance().getConnection();
        String query="delete from City where IdCity=?";
        
        try (PreparedStatement stmt=conn.prepareStatement(query);){
            stmt.setInt(1, CityID);
            int tmp = stmt.executeUpdate();
            if(tmp == 1)
                success  = true;
        } catch (SQLException ex) {
            
        }
        return success ;
    }

    @Override
    public List<Integer> getAllCities() {
        
        List<Integer> cityList = new LinkedList<>();
        
        Connection conn=DB.getInstance().getConnection();
        String query="select IdCity from City";
        try (PreparedStatement stmt=(PreparedStatement) conn.prepareStatement(query);){            
            ResultSet rs = stmt.executeQuery();
            while(rs.next()){
                cityList.add(rs.getInt(1));
            }
        } catch (SQLException ex) {
        }
        
        return cityList;
    }
    
}

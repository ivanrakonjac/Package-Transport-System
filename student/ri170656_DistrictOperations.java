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
import rs.etf.sab.operations.DistrictOperations;

/**
 *
 * @author Ika
 */
public class ri170656_DistrictOperations implements DistrictOperations {

    @Override
    public int insertDistrict(String name, int IdCity, int xCord, int yCord) {
        
         int id = -1;
        
        Connection conn=DB.getInstance().getConnection();
        String query="insert into District(Name, xCord, yCord, IdCity) values (?, ?, ?, ?)";
        
        try (PreparedStatement stmt=conn.prepareStatement(query, PreparedStatement.RETURN_GENERATED_KEYS);){
            stmt.setString(1, name);
            stmt.setInt(2, xCord);
            stmt.setInt(3, yCord);
            stmt.setInt(4, IdCity);
            stmt.executeUpdate();
            ResultSet rs = stmt.getGeneratedKeys();
            if(rs.next()){
                id = rs.getInt(1);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return id;
    }

    @Override
    public int deleteDistricts(String... names) {
        
        int numOfDeleted = 0;
        
        if(names.length == 0)
            return numOfDeleted;
        
        Connection conn=DB.getInstance().getConnection();
        String query="delete from District where Name=?";
        
        try (PreparedStatement stmt=conn.prepareStatement(query);){
            for (String name : names) {
                stmt.setString(1, name);
                numOfDeleted = numOfDeleted + stmt.executeUpdate();
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        
        return numOfDeleted;    
    }

    @Override
    public boolean deleteDistrict(int IdDistrict) {
        boolean success = false;
        
        Connection conn=DB.getInstance().getConnection();
        String query="delete from District where IdDistrict=?";
        
        try (PreparedStatement stmt=conn.prepareStatement(query);){
            stmt.setInt(1, IdDistrict);
            int tmp = stmt.executeUpdate();
            if(tmp == 1){
                success = true;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return success;
    }

    @Override
    public int deleteAllDistrictsFromCity(String CityName) {
         int numOfDeleted = 0;
        
        Connection conn=DB.getInstance().getConnection();
        String query="delete\n" +
                    "from District\n" +
                    "where IdCity=(\n" +
                    "	select IdCity\n" +
                    "	from City\n" +
                    "	where Name=?\n" +
                    ")";
        try (PreparedStatement stmt=conn.prepareStatement(query);){
            stmt.setString(1, CityName);
            numOfDeleted = numOfDeleted + stmt.executeUpdate();

        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        
        return numOfDeleted;
    }

    @Override
    public List<Integer> getAllDistrictsFromCity(int CityID) {
        
        List<Integer> districtsList = new LinkedList<>();
        
        Connection conn=DB.getInstance().getConnection();
        String query="select IdDistrict from District where IdCity=?";
        
        try (PreparedStatement stmt=conn.prepareStatement(query);){  
            stmt.setInt(1, CityID);
            ResultSet rs = stmt.executeQuery();
            while(rs.next()){
                districtsList.add(rs.getInt(1));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        
        if(districtsList.size() > 0)
            return districtsList;
        else
            return null;
    }

    @Override
    public List<Integer> getAllDistricts() {
         List<Integer> districtsList = new LinkedList<>();
        
        Connection conn=DB.getInstance().getConnection();
        String query="select IdDistrict from District";
        
        try (PreparedStatement stmt=conn.prepareStatement(query);){            
            ResultSet rs = stmt.executeQuery();
            while(rs.next()){
                districtsList.add(rs.getInt(1));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        
        return districtsList;
    }
    
}

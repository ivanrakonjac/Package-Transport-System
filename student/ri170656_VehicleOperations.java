/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package student;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;
import rs.etf.sab.operations.VehicleOperations;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 *
 * @author Ika
 */
public class ri170656_VehicleOperations implements VehicleOperations{

    @Override
    public boolean insertVehicle(String PlateNumber, int FuelType, BigDecimal FuelConsumption) {
        boolean success  = false;
         
        if(FuelType < 0 || FuelType > 2){
            return false;
        }
     
        Connection conn=DB.getInstance().getConnection();
        String query="insert into Vehicle(PlateNumber, FuelType, FuelConsumption) values (?, ?, ?)";
        
        try (PreparedStatement stmt=conn.prepareStatement(query);){
            stmt.setString(1, PlateNumber);
            stmt.setInt(2, FuelType);
            stmt.setBigDecimal(3, FuelConsumption);
            
            int tmp = stmt.executeUpdate();
            if(tmp == 1){
                success  = true;   
            }
        
        } catch (SQLException ex) {}
        
        return success ;
    }

    @Override
    public int deleteVehicles(String... PlateNumbers) {
        int numOfDeletedVehicles = 0;
        
        if(PlateNumbers.length == 0){
            return numOfDeletedVehicles;
        }
            
        Connection conn=DB.getInstance().getConnection();
        String query="delete from Vehicle where PlateNumber=?";
        
        try (PreparedStatement stmt=conn.prepareStatement(query);){
         
            for (String licenseNum : PlateNumbers) {
                stmt.setString(1, licenseNum);
                numOfDeletedVehicles = numOfDeletedVehicles + stmt.executeUpdate();
            }

        } catch (SQLException ex) {}
        
        return numOfDeletedVehicles; 
    }

    @Override
    public List<String> getAllVehichles() {
        
        List<String> vehichlesList = new LinkedList<>();
        
        Connection conn=DB.getInstance().getConnection();
        String query="select PlateNumber from Vehicle";
        
        try (PreparedStatement stmt=conn.prepareStatement(query);){            
            ResultSet rs = stmt.executeQuery();
            while(rs.next()){
                vehichlesList.add(rs.getString(1));
            }
        } catch (SQLException ex) {}
        
        return vehichlesList;
    }

    @Override
    public boolean changeFuelType(String PlateNumber, int FuelType) {
        
        boolean success = false;
         
        if(FuelType<0 || FuelType>2){
            return false;
        }
           
        Connection conn=DB.getInstance().getConnection();
        String query="update Vehicle set FuelType=? where PlateNumber=?";
        try (PreparedStatement stmt=conn.prepareStatement(query);){
            
            stmt.setInt(1, FuelType);
            stmt.setString(2, PlateNumber);         
            
            int tmp = stmt.executeUpdate();
            if(tmp == 1){
                success = true;
            }
                
        } catch (SQLException ex) {}
        
        return success;
    }

    @Override
    public boolean changeConsumption(String PlateNumber, BigDecimal FuelConsumption) {
        
        boolean success = false;
                 
        Connection conn=DB.getInstance().getConnection();
        String query="update Vehicle set FuelConsumption=? where PlateNumber=?";
        
        try (PreparedStatement stmt=conn.prepareStatement(query);){
            
            stmt.setBigDecimal(1, FuelConsumption);
            stmt.setString(2, PlateNumber);         
            
            int tmp = stmt.executeUpdate();
            if(tmp == 1){
                success = true;
            }
                
        } catch (SQLException ex) {}
        
        return success;
    }
    
}

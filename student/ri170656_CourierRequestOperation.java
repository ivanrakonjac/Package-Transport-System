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
import rs.etf.sab.operations.CourierRequestOperation;
import java.sql.CallableStatement;
/**
 *
 * @author Ika
 */
public class ri170656_CourierRequestOperation implements CourierRequestOperation{

    @Override
    public boolean insertCourierRequest(String UserName, String PlateNumber) {
        
        boolean success  = false;
               
        Connection conn=DB.getInstance().getConnection();
        String query="insert into BecameCourierReq(UserName, PlateNumber) values (?, ?)";
        
        try (PreparedStatement stmt=conn.prepareStatement(query);){
            
            stmt.setString(1, UserName);
            stmt.setString(2, PlateNumber);
            
            int tmp = stmt.executeUpdate();
            if(tmp == 1){
                success  = true;
            }
                
        } catch (SQLException ex) {}
        
        return success ;
    }

    @Override
    public boolean deleteCourierRequest(String UserName) {
        
        boolean success = false;
        
        Connection conn=DB.getInstance().getConnection();
        String query="delete from BecameCourierReq where UserName=?";
        
        try (PreparedStatement stmt=conn.prepareStatement(query);){
            stmt.setString(1, UserName);
            
            int tmp = stmt.executeUpdate();
            if(tmp == 1){
                success = true;
            }
               
        } catch (SQLException ex) {}
        
        return success;
    }

    @Override
    public boolean changeVehicleInCourierRequest(String UserName, String PlateNumber) {
        
        boolean success = false;
        
        Connection conn=DB.getInstance().getConnection();
        String query="update BecameCourierReq set PlateNumber=? where UserName=?";
        
        try (PreparedStatement stmt=conn.prepareStatement(query);){
            
            stmt.setString(1, PlateNumber);
            stmt.setString(2, UserName);
            
            int tmp = stmt.executeUpdate();
            if(tmp == 1){
                success = true;
            }
                
        } catch (SQLException ex) {}
        
        return success;
    }

    @Override
    public List<String> getAllCourierRequests() {
        
        List<String> listOfCourierRequests = new LinkedList<>();
        
        Connection conn=DB.getInstance().getConnection();
        String query="select UserName from BecameCourierReq";
        
        try (PreparedStatement stmt=conn.prepareStatement(query);){            
            
            ResultSet rs = stmt.executeQuery();
            
            while(rs.next()){
                listOfCourierRequests.add(rs.getString(1));
            }
            
        } catch (SQLException ex) {}

        return listOfCourierRequests;
    }

    @Override
    public boolean grantRequest(String UserName) {

        boolean success = false;
        
        Connection conn=DB.getInstance().getConnection();
        String query="exec spGrantRequest ?";
        
        try (CallableStatement stmt=conn.prepareCall(query);){
            
            stmt.setString(1, UserName);
            int tmp = stmt.executeUpdate();
            
            if(tmp == 1){
                success = true;
            }    
                
        } catch (SQLException ex) {}
        
        return success;
    }
    
}

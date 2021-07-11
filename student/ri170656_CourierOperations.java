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
import rs.etf.sab.operations.CourierOperations;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 *
 * @author Ika
 */
public class ri170656_CourierOperations implements CourierOperations {

    @Override
    public boolean insertCourier(String CourierUserName, String PlateNumber) {
         boolean success  = false;
               
        Connection conn=DB.getInstance().getConnection();
        String query="insert into Courier(CourierUserName, PlateNumber) values (?, ?)";
        
        try (PreparedStatement stmt=conn.prepareStatement(query);){
            
            stmt.setString(1, CourierUserName);
            stmt.setString(2, PlateNumber);
            int tmp = stmt.executeUpdate();
            
            if(tmp == 1){
                success = true;
            }
                
        } catch (SQLException ex) {}
        
        return success ;
    }

    @Override
    public boolean deleteCourier(String CourierUserName) {
        
        boolean success  = false;
        
        Connection conn=DB.getInstance().getConnection();
        String query="delete from Courier where CourierUserName=?";
        
        try (PreparedStatement stmt=conn.prepareStatement(query);){
         
            stmt.setString(1, CourierUserName);
            int tmp = stmt.executeUpdate();
            
            if(tmp == 1){
                success  = true;
            }
                
        } catch (SQLException ex) {}
        
        return success ;
    }

    @Override
    public List<String> getCouriersWithStatus(int Status) {
        
        List<String> listOfCouriers = new LinkedList<>();
        
        Connection conn=DB.getInstance().getConnection();
        String query="select CourierUserName from Courier where Status=?";
        
        try (PreparedStatement stmt=conn.prepareStatement(query);){ 
            
            stmt.setInt(1, Status);
            ResultSet rs = stmt.executeQuery();
            while(rs.next()){
                listOfCouriers.add(rs.getString(1));
            }
            
        } catch (SQLException ex) {}
        
        return listOfCouriers;
    }

    @Override
    public List<String> getAllCouriers() {
        List<String> listOfCouriers = new LinkedList<>();
        
        Connection conn=DB.getInstance().getConnection();
        String query="select CourierUserName from Courier order by Profit DESC";
        
        try (PreparedStatement stmt=conn.prepareStatement(query);){     
            
            ResultSet rs = stmt.executeQuery();
            while(rs.next()){
                listOfCouriers.add(rs.getString(1));
            }
            
        } catch (SQLException ex) {}
        
        return listOfCouriers;
    }

    @Override
    public BigDecimal getAverageCourierProfit(int NumOfDeliveredPackgs) {
        
        BigDecimal averageCourierProfit = BigDecimal.ZERO;
        BigDecimal profitSum = BigDecimal.ZERO;
        BigDecimal profit = BigDecimal.ZERO;
        int courierCnt = 0;
        
        Connection conn=DB.getInstance().getConnection();
        String query="select NumOfDeliveredPackgs, Profit from Courier";
        
        try (PreparedStatement stmt=conn.prepareStatement(query);){ 
            
            ResultSet rs = stmt.executeQuery();
            while(rs.next()){
                
                int tmp = rs.getInt("NumOfDeliveredPackgs");
                profit = rs.getBigDecimal("Profit");
                
                if(tmp >= NumOfDeliveredPackgs){
                    profitSum = profitSum.add(profit);
                    courierCnt++;
                }
                
            }
            
            averageCourierProfit = profitSum.divide(BigDecimal.valueOf(courierCnt));
            
            return averageCourierProfit;
            
        } catch (SQLException ex) {}
        
        return averageCourierProfit;
    }
    
}

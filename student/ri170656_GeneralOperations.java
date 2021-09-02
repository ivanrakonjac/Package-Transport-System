/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package student;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import rs.etf.sab.operations.GeneralOperations;

/**
 *
 * @author Ika
 */
public class ri170656_GeneralOperations implements GeneralOperations{

    @Override
    public void eraseAll() {
        
        Connection conn=DB.getInstance().getConnection();
        String [] names = {"TransportOffer", "CourierRequest", "Package", "Admin", "Courier", "User", "Vehicle", "District", "City"}; 
       
        try {
            
            for(int i = 0; i < names.length; i++){
                String query="delete from [";
                String name = names[i];
                query += name;
                query += "]";
                PreparedStatement stmt=conn.prepareStatement(query);
                stmt.executeUpdate();
                stmt.close();
            }

        } catch (SQLException ex) {}
    }
    
}

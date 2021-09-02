/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package student;

import java.sql.CallableStatement;
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
        
        String query = "{call sp_emptyDB}";
        try (CallableStatement statement = conn.prepareCall(query)) {
            statement.execute();
        } catch (SQLException e) {
            // e.printStackTrace();
            System.err.println(e.getMessage());
        }
    }
    
}

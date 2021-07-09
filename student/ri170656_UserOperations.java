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
import rs.etf.sab.operations.UserOperations;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 *
 * @author Ika
 */
public class ri170656_UserOperations implements UserOperations{

    @Override
    public boolean insertUser(String UserName, String FirstName, String LastName, String Password) {
        
        Pattern firstLetterUppercasePattern = Pattern.compile("^([A-Z][a-zA-Z]*)");
        Pattern passwordPattern = Pattern.compile("^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$");
        
        Matcher matcher = firstLetterUppercasePattern.matcher(FirstName);
        boolean patternOK = matcher.find();
        
        if(!patternOK) {        
          System.out.println("FirstName has to start with capital letter");
          return false;
        }
        matcher = firstLetterUppercasePattern.matcher(LastName);
        patternOK = matcher.find();
        if(!patternOK) {        
          System.out.println("LastName has to start with capital letter.");
          return false;
        }
        
             
        matcher = passwordPattern.matcher(Password);
        patternOK = matcher.find();
        if(!patternOK) {        
          System.out.println("Password has to be longer than 8 characters. It should contain at least one number and one letter.");
          return false;
        }
        
        boolean success  = false;
        
        Connection conn=DB.getInstance().getConnection();
        String query="insert into [User] (UserName, FirstName, LastName, Password) values (?, ?, ?, ?)";

        try (PreparedStatement stmt=conn.prepareStatement(query);){
            
            stmt.setString(1, UserName);
            stmt.setString(2, FirstName);
            stmt.setString(3, LastName);
            stmt.setString(4, Password);
            
            int tmp = stmt.executeUpdate();
            
            if(tmp == 1){
                success = true;
            }
            
        } catch (SQLException ex) {}
        
        return success ;
    }

    @Override
    public int declareAdmin(String UserName) {
        final int SUCCESS = 0;
        final int ALREADY_ADMIN = 1;
        final int USER_DOES_NOT_EXISTS = 2;
        final int ERROR = -1;
        
        Connection conn=DB.getInstance().getConnection();
        String query="select Username from [User] where UserName=?";
        
        try (PreparedStatement prepStmtCheckUser=conn.prepareStatement(query);){  
            
            prepStmtCheckUser.setString(1, UserName);
            ResultSet rsCheckUser = prepStmtCheckUser.executeQuery();
            
            if(rsCheckUser.next()){ // isAdmin
                
                query="select AdminUsername from [Admin] where AdminUserName=?";
                
                PreparedStatement prepStmtIsAdmin=conn.prepareStatement(query);
                prepStmtIsAdmin.setString(1, UserName);
                ResultSet rsCheckIfAdmin = prepStmtIsAdmin.executeQuery();
                
                if(rsCheckIfAdmin.next()){
                    prepStmtIsAdmin.close();
                    return ALREADY_ADMIN;
                    
                }else{ // addAdmin
                    
                    prepStmtIsAdmin.close();
                    query = "insert into [Admin] values (?)";
                    PreparedStatement psAddAdmin=conn.prepareStatement(query);
                    psAddAdmin.setString(1, UserName);
                    int tmp = psAddAdmin.executeUpdate();
                    psAddAdmin.close();
                    
                    if(tmp == 1){
                        return SUCCESS;
                    }
                }
                
            }else{
                return USER_DOES_NOT_EXISTS; 
            }
        } catch (SQLException ex) {}
        
        return ERROR;
    }

    @Override
    public Integer getSentPackages(String... UserNames) {
        int sumOfSentPackages = 0;
        
        if(UserNames.length == 0)
            return null;
        
        Connection conn=DB.getInstance().getConnection();
        String query="select Username from [User] where UserName=?";
        
        try (PreparedStatement stmtCheckUser=conn.prepareStatement(query);){  
            for (String UserName : UserNames) {
                stmtCheckUser.setString(1, UserName);
                ResultSet rsCheckUser = stmtCheckUser.executeQuery();
                if(!rsCheckUser.next()){
                    return null;
                }
            }
        } catch (SQLException ex) {}

        
        query="select NumOfSentPackgs from [User] where UserName=?";
        
        try (PreparedStatement stmt=conn.prepareStatement(query);){
            for (String username : UserNames) {
                stmt.setString(1, username);
                ResultSet rs = stmt.executeQuery();
                while (rs.next()){
                    sumOfSentPackages =  sumOfSentPackages + rs.getInt(1);
                }
            }

        } catch (SQLException ex) {}
        
        return sumOfSentPackages;
    }

    @Override
    public int deleteUsers(String... UserNames) {
        int numOfDeletedUsers = 0;
        if(UserNames.length == 0)
            return 0;
        
        Connection conn=DB.getInstance().getConnection();
        String query="delete from [User] where UserName=?";
        
        try (PreparedStatement stmt=conn.prepareStatement(query);){
            for (String username : UserNames) {
                stmt.setString(1, username);
                numOfDeletedUsers = numOfDeletedUsers + stmt.executeUpdate();
            }

        } catch (SQLException ex) {}
        
        return numOfDeletedUsers;
    }

    @Override
    public List<String> getAllUsers() {
        List<String> usersList = new LinkedList<>();
        
        Connection conn=DB.getInstance().getConnection();
        String query="select UserName from [User]";
        
        try (PreparedStatement stmt=conn.prepareStatement(query);){            
            ResultSet rs = stmt.executeQuery();
            while(rs.next()){
                usersList.add(rs.getString(1));
            }
        } catch (SQLException ex) {}
        
        return usersList;
    }
    
}

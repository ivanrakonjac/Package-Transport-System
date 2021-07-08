package student;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
//import rs.etf.sab.*;



public class StudentMain {
    
    public static void ispisiGradove(){
        
        Connection connection = DB.getInstance().getConnection();
        
        try(
            Statement stmt = connection.createStatement();
            ResultSet rs = stmt.executeQuery("select * from City");
        )
        {
            ResultSetMetaData rsmd=rs.getMetaData();
            for(int i=1; i<=rsmd.getColumnCount(); i++){
                System.out.print(String.format("%-18s", rsmd.getColumnName(i)));
            }
            
            System.out.println();
            
            while(rs.next()){
                
                for(int i=1; i<=rsmd.getColumnCount(); i++){    
                    if(rsmd.getColumnType(i)==java.sql.Types.INTEGER)
                        System.out.print(String.format("%-18d", rs.getInt(i)));
                    else if(rsmd.getColumnType(i)==java.sql.Types.VARCHAR ||
                            rsmd.getColumnType(i)==java.sql.Types.CHAR)
                        System.out.print(String.format("%-18s", rs.getString(i)));
                }
                System.out.println();
                
                
                //System.out.println(rs.getString(2) + " " + rs.getString("Prezime"));
            }
            
        }catch (SQLException ex) {
            Logger.getLogger(StudentMain.class.getName()).log(Level.SEVERE, null, ex);
        }
    }  

    public static void main(String[] args) {
        
        ispisiGradove();
        
        /*CityOperations cityOperations = new ba170390_CityOperations(); 
        DistrictOperations districtOperations = new ba170390_DistrictOperations(); 
        CourierOperations courierOperations = new ba170390_CourierOperations(); 
        CourierRequestOperation courierRequestOperation = new ba170390_CourierRequestOperation();
        GeneralOperations generalOperations = new ba170390_GeneralOperations();
        UserOperations userOperations = new ba170390_UserOperations();
        VehicleOperations vehicleOperations = new ba170390_VehicleOperations();
        PackageOperations packageOperations = new ba170390_PackageOperations();

        TestHandler.createInstance(
                cityOperations,
                courierOperations,
                courierRequestOperation,
                districtOperations,
                generalOperations,
                userOperations,
                vehicleOperations,
                packageOperations);

        TestRunner.runTests();*/
    }
    
  
}

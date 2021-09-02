package student;

import static org.junit.Assert.*;
import java.math.BigDecimal;
import java.sql.Date;
import java.util.List;
import junit.framework.Assert;
import rs.etf.sab.tests.*;
import rs.etf.sab.operations.CityOperations;
import rs.etf.sab.operations.CourierOperations;
import rs.etf.sab.operations.CourierRequestOperation;
import rs.etf.sab.operations.DistrictOperations;
import rs.etf.sab.operations.GeneralOperations;
import rs.etf.sab.operations.PackageOperations;
import rs.etf.sab.operations.UserOperations;
import rs.etf.sab.operations.VehicleOperations;
import rs.etf.sab.tests.TestHandler;
import rs.etf.sab.tests.TestRunner;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

public class StudentMain {
    

    public static void main(String[] args) {
        
        CityOperations cityOperations = new ri170656_CityOperations(); 
        DistrictOperations districtOperations = new ri170656_DistrictOperations();
        UserOperations userOperations = new ri170656_UserOperations();
        CourierOperations courierOperations = new ri170656_CourierOperations(); 
        VehicleOperations vehicleOperations = new ri170656_VehicleOperations();
        CourierRequestOperation courierRequestOperation = new ri170656_CourierRequestOperation();
        PackageOperations packageOperations = new ri170656_PackageOperations();
        GeneralOperations generalOperations = new ri170656_GeneralOperations();
        
        TestHandler.createInstance(
                cityOperations,
                courierOperations,
                courierRequestOperation,
                districtOperations,
                generalOperations,
                userOperations,
                vehicleOperations,
                packageOperations);

        TestRunner.runTests();
               
    }
}

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
        
//        generalOperations.eraseAll();
//
//        String courierLastName = "Ckalja";
//        String courierFirstName = "Pero";
//        String courierUsername = "perkan";
//        String password = "sabi2018";
//        userOperations.insertUser(courierUsername, courierFirstName, courierLastName, password);
//        
//        String licencePlate = "BG323WE";
//        int fuelType = 0;
//        BigDecimal fuelConsumption = new BigDecimal(8.3D);
//        vehicleOperations.insertVehicle(licencePlate, fuelType, fuelConsumption);
//        
//        courierRequestOperation.insertCourierRequest(courierUsername, licencePlate);
//        courierRequestOperation.grantRequest(courierUsername);
//        
//        Assert.assertTrue(courierOperations.getAllCouriers().contains(courierUsername));
//        
//        
//        String senderUsername = "masa";
//        String senderFirstName = "Masana";
//        String senderLastName = "Leposava";
//        password = "lepasampasta1";
//        userOperations.insertUser(senderUsername, senderFirstName, senderLastName, password);
//
//        int cityId = cityOperations.insertCity("Novo Milosevo", "21234");
//        int cordXd1 = 10;
//        int cordYd1 = 2;
//        int districtIdOne = districtOperations.insertDistrict("Novo Milosevo", cityId, cordXd1, cordYd1);
//        int cordXd2 = 2;
//        int cordYd2 = 10;
//        int districtIdTwo = districtOperations.insertDistrict("Vojinovica", cityId, cordXd2, cordYd2);
//
//        int type1 = 0;
//        BigDecimal weight1 = new BigDecimal(123);
//        int packageId1 = packageOperations.insertPackage(districtIdOne, districtIdTwo, courierUsername, type1, weight1);
//
//        //BigDecimal packageOnePrice = new BigDecimal(5);
//        int offerId = packageOperations.insertTransportOffer(courierUsername, packageId1, new BigDecimal(5));
//        packageOperations.acceptAnOffer(offerId);
//        
//        int type2 = 1;
//        BigDecimal weight2 = new BigDecimal(321);
//        int packageId2 = packageOperations.insertPackage(districtIdTwo, districtIdOne, courierUsername, type2, weight2);
//        
//        //BigDecimal packageTwoPrice = Util.getPackagePrice(type2, weight2, Util.euclidean(cordXd1, cordYd1, cordXd2, cordYd2), new BigDecimal(5));
//        offerId = packageOperations.insertTransportOffer(courierUsername, packageId2, new BigDecimal(5));
//        packageOperations.acceptAnOffer(offerId);
//        
//        int type3 = 1;
//        BigDecimal weight3 = new BigDecimal(222);
//        int packageId3 = packageOperations.insertPackage(districtIdTwo, districtIdOne, courierUsername, type3, weight3);
//        
////        BigDecimal packageThreePrice = Util.getPackagePrice(type3, weight3, Util.euclidean(cordXd1, cordYd1, cordXd2, cordYd2), new BigDecimal(5));
//        offerId = packageOperations.insertTransportOffer(courierUsername, packageId3, new BigDecimal(5));
//        packageOperations.acceptAnOffer(offerId);
//        
//        Assert.assertEquals(1L, (long)packageOperations.getDeliveryStatus(packageId1));
//        Assert.assertEquals((long)packageId1, (long)packageOperations.driveNextPackage(courierUsername));
//        Assert.assertEquals(2L, (long)packageOperations.getDeliveryStatus(packageId2));
//        Assert.assertEquals((long)packageId2, (long)packageOperations.driveNextPackage(courierUsername));
//        Assert.assertEquals(3L, (long)packageOperations.getDeliveryStatus(packageId2));
//
//        Assert.assertEquals(2L, (long)packageOperations.getDeliveryStatus(packageId3));
//        Assert.assertEquals((long)packageId3, (long)packageOperations.driveNextPackage(courierUsername));
//        Assert.assertEquals(3L, (long)packageOperations.getDeliveryStatus(packageId3));
        

        
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

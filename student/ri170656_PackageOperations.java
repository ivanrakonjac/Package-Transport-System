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
import rs.etf.sab.operations.PackageOperations;
import java.sql.CallableStatement;
import java.sql.Date;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Ika
 */
public class ri170656_PackageOperations implements PackageOperations{
    
    private static HashMap<String, ri170656_Pair<Integer, Integer>> lastVisitedPlaces = new HashMap<>();
    
    public static class ri170656_Pair<T, X> implements Pair{
        private final T i;
        private final X bd;
        
        public ri170656_Pair(T ii, X bbdd){
            this.i = ii;
            this.bd = bbdd;
        }

        @Override
        public Object getFirstParam() {
            return i;
        }

        @Override
        public Object getSecondParam() {
            return bd;
        }
        
    }

    @Override
    public int insertPackage(int districtFrom, int districtTo, String userName, int packageType, BigDecimal weight) {
        int id = -1;
        
        if(packageType < 0 || packageType > 2){
            return -1;  
        }
        
        Connection conn=DB.getInstance().getConnection();
        String query="insert into Package(DistrictFrom, DistrictTo, UserUserName, Type, Weight) values (?, ?, ?, ?, ?)";
        
        try (PreparedStatement stmt=conn.prepareStatement(query, PreparedStatement.RETURN_GENERATED_KEYS);){
            
            stmt.setInt(1, districtFrom);
            stmt.setInt(2, districtTo);
            stmt.setString(3, userName);
            stmt.setInt(4, packageType);
            stmt.setBigDecimal(5, weight);
            stmt.executeUpdate();
            ResultSet rs = stmt.getGeneratedKeys();
            
            if(rs.next()){
                id = rs.getInt(1);
            }
            
        } catch (SQLException ex) {}
        
        return id;
    }

    @Override
    public int insertTransportOffer(String CourierUserName, int IdPackage, BigDecimal Share) {
        
        int id = -1; 
        int status = -1;
        
        Connection conn=DB.getInstance().getConnection();
        
        String queryCourierStatus=" select Status from Courier where CourierUserName=?";
        try (PreparedStatement stmt1=conn.prepareStatement(queryCourierStatus, PreparedStatement.RETURN_GENERATED_KEYS);){
            
            stmt1.setString(1, CourierUserName);
            ResultSet rs = stmt1.executeQuery();
            
            if(rs.next()){
                status = rs.getInt(1);
            }
            
        } catch (SQLException ex) {}
        
        if(status != 0){
            return -1;
        }
        
        String query="insert into TransportOffer(CourierUserName, IdPackage, Share) values (?, ?, ?)";
        try (PreparedStatement stmt=conn.prepareStatement(query, PreparedStatement.RETURN_GENERATED_KEYS);){
            
            stmt.setString(1, CourierUserName);
            stmt.setInt(2, IdPackage);
            stmt.setBigDecimal(3, Share);
            
            stmt.executeUpdate();
            ResultSet rs = stmt.getGeneratedKeys();
            
            if(rs.next()){
                id = rs.getInt(1);
            }
        } catch (SQLException ex) {}
        
        return id;
            
    }

    @Override
    public boolean acceptAnOffer(int IdOffer) {
        boolean success  = false;
        
        int idPackage = -1;
        String courier = "";
        BigDecimal price = BigDecimal.ZERO;
        BigDecimal share = BigDecimal.ZERO;
        
        Connection conn=DB.getInstance().getConnection();
        String getOffersQuery="select Share, CourierUserName, IdPackage from TransportOffer where IdOffer=?";
        String updateCourUserNameQuery="update Package set CourierUserName=?, AcceptReqTime=CURRENT_TIMESTAMP, DeliveryStatus=1, Price=? where IdPackage=?";
        
        try (PreparedStatement stmtGetOffers=conn.prepareStatement(getOffersQuery);
                PreparedStatement stmtUpdate=conn.prepareStatement(updateCourUserNameQuery);){
            
            stmtGetOffers.setInt(1, IdOffer);
            ResultSet rsGetOffer = stmtGetOffers.executeQuery();
            if(rsGetOffer.next()){
                courier = rsGetOffer.getString("CourierUserName");        
                share = rsGetOffer.getBigDecimal("Share");
                idPackage = rsGetOffer.getInt("IdPackage");
                price = calculatePackagePrice(idPackage, share);              
            }else{
                return false;
            }
                    
            stmtUpdate.setInt(3, idPackage);
            stmtUpdate.setString(1, courier);
            stmtUpdate.setBigDecimal(2, price);
            
            int tmp = stmtUpdate.executeUpdate();
            if(tmp == 1){
                success  = true;
            }
                
            //offers for this package will be deleted by trigger TR_TransportOffer_DeleteOffersForPackage

        } catch (SQLException ex) {}
        
        return success ;
    }

    @Override
    public List<Integer> getAllOffers() {
        List<Integer> listOfOffers = new LinkedList<>();
        
        Connection conn=DB.getInstance().getConnection();
        String query="select IdOffer from TransportOffer";
        
        try (PreparedStatement stmt=conn.prepareStatement(query);){
            
            ResultSet rs = stmt.executeQuery();
            while(rs.next()){
                listOfOffers.add(rs.getInt(1));
            }
            
        } catch (SQLException ex) {}
        
        return listOfOffers;
    }

    @Override
    public List<Pair<Integer, BigDecimal>> getAllOffersForPackage(int IdPackage) {
        
        List<Pair<Integer, BigDecimal>> listOfOffers = new LinkedList<>();
        
        Connection conn=DB.getInstance().getConnection();
        String query="select IdOffer, Share from TransportOffer where IdPackage=?";
        
        try (PreparedStatement stmt=conn.prepareStatement(query);){  
            
            stmt.setInt(1, IdPackage);
            
            ResultSet rs = stmt.executeQuery();
            while(rs.next()){
                int id = rs.getInt("IdOffer");
                BigDecimal pp = rs.getBigDecimal("Share");
                ri170656_Pair pair = new ri170656_Pair(id, pp);
                listOfOffers.add(pair);
            }
            
        } catch (SQLException ex) {}
        
        return listOfOffers;
    }

    @Override
    public boolean deletePackage(int IdPackage) {
        
        boolean success  = false;
        
        Connection conn=DB.getInstance().getConnection();
        String query="delete from [Package] where [IdPackage]=?";
        
        try (PreparedStatement stmt=conn.prepareStatement(query);){
            
            stmt.setInt(1, IdPackage);
            
            int tmp = stmt.executeUpdate();
            if(tmp == 1){
                success = true;
            } 
            
        } catch (SQLException ex) {}
        
        return success ;
    }

    @Override
    public boolean changeWeight(int IdPackage, BigDecimal newWeight) {
        
        boolean success  = false;
        
        Connection conn=DB.getInstance().getConnection();
        String query="update Package set Weight=? where IdPackage=?";
        
        try (PreparedStatement stmt=conn.prepareStatement(query);){
            
            stmt.setBigDecimal(1, newWeight);
            stmt.setInt(2, IdPackage);
            
            int tmp = stmt.executeUpdate();
            if(tmp == 1){
                success = true;
            }
                
        } catch (SQLException ex) {}
        
        return success ;
    }

    @Override
    public boolean changeType(int IdPackage, int newType) {
        
        boolean success  = false;
        
        if(newType < 0 || newType > 2){
            return false;
        }
            
        Connection conn=DB.getInstance().getConnection();
        String query="update Package set Type=? where IdPackage=?";
        
        try (PreparedStatement stmt=conn.prepareStatement(query);){
            
            stmt.setInt(1, newType);
            stmt.setInt(2, IdPackage);
            
            int tmp = stmt.executeUpdate();
            if(tmp == 1){
                success = true;
            }
                
        } catch (SQLException ex) {}
        
        return success ;
        
    }

    @Override
    public Integer getDeliveryStatus(int IdPackage) {
        
        Integer deliveryStatus  = -1;
            
        Connection conn=DB.getInstance().getConnection();
        String query="select DeliveryStatus from Package where IdPackage=?";
        
        try (PreparedStatement stmt=conn.prepareStatement(query);){
            
            stmt.setInt(1, IdPackage);
            ResultSet rs = stmt.executeQuery();
            
            if(rs.next()){
                deliveryStatus = rs.getInt(1);
                return deliveryStatus;
            }else{
                return null;
            }
                
        } catch (SQLException ex) {}
        
        return deliveryStatus ;
        
    }

    @Override
    public BigDecimal getPriceOfDelivery(int IdPackage) {
        
        BigDecimal priceOfDelivery = null;
        
        Connection conn=DB.getInstance().getConnection();
        String query="select Price from Package where IdPackage=?";
        
        try (PreparedStatement stmt=conn.prepareStatement(query);){  
            
            stmt.setInt(1, IdPackage);
            ResultSet rs = stmt.executeQuery();
            
            if(rs.next()){
                
                priceOfDelivery = rs.getBigDecimal(1);
                
                if(priceOfDelivery.compareTo(BigDecimal.ZERO)==0 ){
                    return null;
                }else{
                    return priceOfDelivery;
                }
                
            }else{
                return null;
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(ri170656_PackageOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return priceOfDelivery;
        
    }

    @Override
    public Date getAcceptanceTime(int IdPackage) {
        
        Date acceptanceTime = null;
        
        Connection conn=DB.getInstance().getConnection();
        String query="select AcceptReqTime from Package where IdPackage=?";
        
        try (PreparedStatement stmt=conn.prepareStatement(query);){    
            
            stmt.setInt(1, IdPackage);
            ResultSet rs = stmt.executeQuery();
            
            if(rs.next()){
                acceptanceTime = rs.getDate(1);
                return acceptanceTime;
            }else{
                return null;
            }
            
        } catch (SQLException ex) {}
        
        return acceptanceTime;
        
    }

    @Override
    public List<Integer> getAllPackagesWithSpecificType(int specificType) {
        
         List<Integer> packagesList = new LinkedList<>();
        
        Connection conn=DB.getInstance().getConnection();
        String query="select IdPackage from Package where Type=?";
        
        try (PreparedStatement stmt=conn.prepareStatement(query);){
            
            stmt.setInt(1, specificType);
            ResultSet rs = stmt.executeQuery();
            
            while(rs.next()){
                packagesList.add(rs.getInt(1));
            }
            
        } catch (SQLException ex) {}
        
        
        return packagesList;
        
    }

    @Override
    public List<Integer> getAllPackages() {
        
        List<Integer> packagesList = new LinkedList<>();
        
        Connection conn=DB.getInstance().getConnection();
        String query="select IdPackage from Package";
        
        try (PreparedStatement stmt=conn.prepareStatement(query);){
            
            ResultSet rs = stmt.executeQuery();
            
            while(rs.next()){
                packagesList.add(rs.getInt(1));
            }
            
        } catch (SQLException ex) {}

        return packagesList;
        
    }

    @Override
    public List<Integer> getDrive(String courierUserName) {
        
        List<Integer> list = new LinkedList<>();
        
        Connection conn=DB.getInstance().getConnection();
        String query="select IdPackage from Package where Status=2";
        
        try (PreparedStatement stmt=conn.prepareStatement(query);){
            
            ResultSet rs = stmt.executeQuery();
            
            while(rs.next()){
                list.add(rs.getInt(1));
            }
            
        } catch (SQLException ex) {}
        
        return list;
    }

    @Override
    public int driveNextPackage(String courierUserName) {
        final int NO_PACKAGES = -1;
        final int CAN_NOT_START = -2;
        
        int isDeliveryStarted = getCourierStatus(courierUserName);
               
        int firstPckgId = sortAndGetFirstPackagesId(courierUserName, isDeliveryStarted);
        
        /*
        * ako je firstPckgId==-1 => nema paketa
        * firstPckgId==-2 => ne moze se zapoceti voznja
        * firstPckgId>0 => ide dostava
        */
        if(firstPckgId > 0){ 
            
            deliverPackage(firstPckgId);
            updateCourierAfterDelivery(courierUserName, firstPckgId);
            return firstPckgId;
            
        }else if(firstPckgId == -1){
            
            stopDelivery(courierUserName);
            return NO_PACKAGES;
        
        }else if(firstPckgId == -2){ 
            
            return CAN_NOT_START;
            
        }
        
        return CAN_NOT_START;
    }
    
    private double euclideanDistance(final int x1, final int y1, final int x2, final int y2) {
        return Math.sqrt((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2));
    }
    
    private BigDecimal getPackagePrice(final int Type, final BigDecimal Weight, final double Distance, BigDecimal Share) {
        Share = Share.divide(new BigDecimal(100));
        switch (Type) {
            case 0 -> {
                return new BigDecimal(10.0 * Distance).multiply(Share.add(new BigDecimal(1)));
            }
            case 1 -> {
                return new BigDecimal((25.0 + Weight.doubleValue() * 100.0) * Distance).multiply(Share.add(new BigDecimal(1)));
            }
            case 2 -> {
                return new BigDecimal((75.0 + Weight.doubleValue() * 300.0) * Distance).multiply(Share.add(new BigDecimal(1)));
            }
            default -> {
                return null;
            }
        }
    }
    
    public double calculateDistance(int IdDistrictFrom, int IdDistrictTo){
        double distance = 0; 
        int x1, y1, x2, y2;
        
        Connection conn=DB.getInstance().getConnection();
        String queryDistFrom = "select * from District where IdDistrict=?";
        String queryDistTo = "select * from District where IdDistrict=?";
        
        try (PreparedStatement stmtFrom=conn.prepareStatement(queryDistFrom);
                PreparedStatement stmtTo=conn.prepareStatement(queryDistTo);){    
            
            stmtFrom.setInt(1, IdDistrictFrom);
            stmtTo.setInt(1, IdDistrictTo);
            
            ResultSet resFrom = stmtFrom.executeQuery();
            ResultSet resTo = stmtTo.executeQuery();
            
            if(resFrom.next()){
                x1 = resFrom.getInt("xCord");
                y1 = resFrom.getInt("yCord");
            }else{
                return -1;
            }
            if(resTo.next()){
                x2 = resTo.getInt("xCord");
                y2 = resTo.getInt("yCord");       
            }else{
                return -1;
            }
            
            distance = euclideanDistance(x1, y1, x2, y2);
            
        } catch (SQLException ex) {}
        
        return distance;
    }
    
    public BigDecimal calculatePackagePrice(int IdPackage, BigDecimal Share){
        
        BigDecimal packagePrice = BigDecimal.ZERO;
        
        Connection conn=DB.getInstance().getConnection();
        String query="select * from Package where IdPackage=?";
        
        try (PreparedStatement stmt=conn.prepareStatement(query);){  
            
            stmt.setInt(1, IdPackage);
            ResultSet rs = stmt.executeQuery();
            
            if(rs.next()){
                
                int type = rs.getInt("Type");
                BigDecimal weight = rs.getBigDecimal("Weight");
                int districtFromId = rs.getInt("DistrictFrom");
                int districtToId = rs.getInt("DistrictTo");
                
                final double distance = calculateDistance(districtFromId, districtToId);
                
                packagePrice = getPackagePrice(type, weight, distance, Share);
                
            }else{
                return null;
            }
            
        } catch (SQLException ex) {}
        
        return packagePrice;
    }
    
    public int getCourierStatus(String courierUserName){
        
        int courierStatus = -1;
        
        Connection conn=DB.getInstance().getConnection();
        String query="select Status from Courier where CourierUserName=?";
        
        try (PreparedStatement stmt=conn.prepareStatement(query);){
            
            stmt.setString(1, courierUserName);
            ResultSet rs = stmt.executeQuery();
            
            if(rs.next()){
                courierStatus = rs.getInt("Status");
            }else{
                return -1;
            }
            
        } catch (SQLException ex) {}

        return courierStatus;
    }
    
    public int sortAndGetFirstPackagesId(String courierUserName, int isDeliveryStarted){
        
        int firstPckgId = -1;
             
        Connection conn=DB.getInstance().getConnection();
        
        if(isDeliveryStarted == 0){      
            
            //pokusavam da zapocnem voznju, true->voznja pocinje; false->nije moguce
            if(!startDeliveryForCourier(courierUserName)){
                return -2;
            }
            
            //ako je voznja pocela status ide u 2
            String changePackageStatusQuery=    
                    "ALTER TABLE Package DISABLE TRIGGER [TR_TransportOffer_DeleteAllOffersForPackage]\n" +
                    "update Package set DeliveryStatus=2 where CourierUserName=?\n" +
                    "ALTER TABLE Package ENABLE TRIGGER [TR_TransportOffer_DeleteAllOffersForPackage]";
  
            try (PreparedStatement stmt1=conn.prepareStatement(changePackageStatusQuery);){
                stmt1.setString(1, courierUserName);
                stmt1.executeUpdate();          
            } catch (SQLException ex) {}
            
        }
        
        
        String getPckgsQuery="select IdPackage from Package where DeliveryStatus=2 and CourierUserName=? order by AcceptReqTime asc";
        
        try (PreparedStatement stmt=conn.prepareStatement(getPckgsQuery);){
            
            stmt.setString(1, courierUserName);
            ResultSet rs = stmt.executeQuery();
            
            if(rs.next()){
                firstPckgId = rs.getInt(1);
            }else{
                return -1;
            }
            
        } catch (SQLException ex) {}
        
        return firstPckgId;
    }
    
    public boolean startDeliveryForCourier(String courierUserName){
        
        boolean success = false;
        
        Connection conn=DB.getInstance().getConnection();
        
        //gledam da neko slucajno nije uzeo kola
        String courierLicencePlate = getCourierVehicle(courierUserName);
        int vehicleTaken = 0;
        
        String vehicleTakenCheckQuery="select count(CourierUserName) as VehicleTaken from Courier where Status=1 and PlateNumber=?";
        
        try (PreparedStatement stmt=conn.prepareStatement(vehicleTakenCheckQuery);){
            
            stmt.setString(1, courierLicencePlate);
            ResultSet rs = stmt.executeQuery();
            
            if(rs.next()){
                vehicleTaken = rs.getInt("VehicleTaken");
            }else{
                return false;
            }
            
        } catch (SQLException ex) {}
           
        if(vehicleTaken > 0){
            success = false;
            return success;
        }
        
        String startDeliveryQuery="update Courier set Status=1, Profit=? where CourierUserName=?";
        
        try (PreparedStatement stmt1=conn.prepareStatement(startDeliveryQuery);){
            
            stmt1.setBigDecimal(1, BigDecimal.ZERO);
            stmt1.setString(2, courierUserName);
            stmt1.executeUpdate();     
            
            success = true;
            
            lastVisitedPlaces.put(courierUserName, new ri170656_Pair<>(-1, -1));
            
            return success;
        
        } catch (SQLException ex) {}
        
        
        
        return success;
    }
    
    public String getCourierVehicle(String courierUserName){
        
        String plateNumber = "";
        
        Connection conn=DB.getInstance().getConnection();
        
        String query="select PlateNumber from Courier where CourierUsername=?";
        
        try (PreparedStatement stmt=conn.prepareStatement(query);){
            
            stmt.setString(1, courierUserName);
            ResultSet rs = stmt.executeQuery();
            
            if(rs.next()){
                plateNumber = rs.getString("PlateNumber");
            }else{
                return "";
            }
            
        } catch (SQLException ex) {}
        
        return plateNumber;
    }
    
    public void deliverPackage(int idPackage){
        
       Connection conn=DB.getInstance().getConnection();
       String query1="update Package set DeliveryStatus=3 where IdPackage=?";
       
       try (PreparedStatement stmt1=conn.prepareStatement(query1);){
           
           stmt1.setInt(1, idPackage);
           stmt1.executeUpdate(); 
           
       } catch (SQLException ex) {}
    }
    
    public void updateCourierAfterDelivery(String courierUserName, int idPackage){
          
        BigDecimal profit = calculateProfitForPackage(courierUserName, idPackage);  

        Connection conn=DB.getInstance().getConnection();
        String query="update Courier\n" +
                    "set NumOfDeliveredPackgs=NumOfDeliveredPackgs+1, Profit=Profit+?\n" +
                    "where CourierUserName=?";
        
        try (PreparedStatement stmt=conn.prepareStatement(query);){
            
            stmt.setBigDecimal(1, profit);
            stmt.setString(2, courierUserName);
            stmt.executeUpdate();  
            
        } catch (SQLException ex) {}
    }
    
    //gledam cenu isporuke pa odbijem koliko ga kosta voznja
    public BigDecimal calculateProfitForPackage(String courierUserName, int idPackage){ 
        
        int xStart = -1, yStart = -1;
        int xMiddle = -1, yMiddle = -1;
        int xEnd = -1, yEnd = -1;
        
        ri170656_Pair<Integer, Integer> xyCords = lastVisitedPlaces.get(courierUserName);
        
        if((int)xyCords.getFirstParam() == -1 && (int)xyCords.getSecondParam() == -1){
            //tek krenuo, start->districtFrom, end->districtTo
            xStart = (int)getDistrictCords(idPackage, "from").getFirstParam();
            yStart = (int)getDistrictCords(idPackage, "from").getSecondParam();
            xEnd = (int)getDistrictCords(idPackage, "to").getFirstParam();
            yEnd = (int)getDistrictCords(idPackage, "to").getSecondParam();
            
        }else{
            //bio negde, start-> iz hashmap-e, end-> mesto from, pa mesto to
            xStart = (int)xyCords.getFirstParam();
            yStart = (int)xyCords.getSecondParam();
            xMiddle = (int)getDistrictCords(idPackage, "from").getFirstParam();
            yMiddle = (int)getDistrictCords(idPackage, "from").getSecondParam();
            xEnd = (int)getDistrictCords(idPackage, "to").getFirstParam();
            yEnd = (int)getDistrictCords(idPackage, "to").getSecondParam();          
        }
        
        //mesto TO je poslednje mesto koje je obisao, pa ga dodajemo
        lastVisitedPlaces.put(courierUserName, new ri170656_Pair<Integer, Integer>(xEnd, yEnd));
        
        double distance = 0;
        if(xMiddle== -1 && yMiddle == -1){
            //nema middle, samo od start do end
            distance += euclideanDistance(xStart, yStart, xEnd, yEnd);
        }else{
            distance += euclideanDistance(xStart, yStart, xMiddle, yMiddle);
            distance += euclideanDistance(xMiddle, yMiddle, xEnd, yEnd);
        }
        
        //treba nam cena paketa
        BigDecimal packagePrice = BigDecimal.ZERO;
        Connection conn=DB.getInstance().getConnection();
        
        String getPackagePriceQuery="select Price from Package where IdPackage=?";
        try (PreparedStatement stmt=conn.prepareStatement(getPackagePriceQuery);){
            
            stmt.setInt(1, idPackage);
            ResultSet rs = stmt.executeQuery();
            
            if(rs.next()){
                packagePrice = rs.getBigDecimal("Price");
            }else{
                return null;
            }
            
        } catch (SQLException ex) {}
        
      
        String plateNumber = getCourierVehicle(courierUserName);
        

        BigDecimal fuelConsumption = BigDecimal.ZERO;
        int fuelType = -1;
        
        String query1="select FuelConsumption, FuelType from Vehicle where PlateNumber=?";
        try (PreparedStatement stmt1=conn.prepareStatement(query1);){
            
            stmt1.setString(1, plateNumber);
            ResultSet rs1 = stmt1.executeQuery();     
            
            if(rs1.next()){
                fuelConsumption = rs1.getBigDecimal("FuelConsumption");
                fuelType = rs1.getInt("FuelType"); 
            }else{
                return null;
            }
            
        } catch (SQLException ex) {}
        
        int fuelPricePerL = getFuelPricePerL(fuelType);
        
        BigDecimal fuelCharge = ((BigDecimal.valueOf(distance)).multiply(fuelConsumption)).multiply(BigDecimal.valueOf(fuelPricePerL));
         BigDecimal profit = packagePrice.subtract(fuelCharge);
         
        return profit;
    }
    
    public ri170656_Pair<Integer, Integer> getDistrictCords(int idPackage, String direction){
        
        ri170656_Pair<Integer, Integer> districtCords = null;
        
        int IdDistrict = -1;
        String directionColumn = "";
        int xCord = -1, yCord = -1;
        
        switch(direction){
            case "from" -> directionColumn = "DistrictFrom";
            case "to" -> directionColumn = "DistrictTo";
        }
        
        Connection conn=DB.getInstance().getConnection();
        String getDistrictsQuery="select DistrictFrom, DistrictTo from Package where IdPackage=?";
        
        try (PreparedStatement stmt=conn.prepareStatement(getDistrictsQuery);){
            
            stmt.setInt(1, idPackage);
            ResultSet rs = stmt.executeQuery();
            if(rs.next()){
                IdDistrict = rs.getInt(directionColumn);
            }else{
                return null;
            }
            
        } catch (SQLException ex) {}
        
        String getCordsQuery="select xCord, yCord from District where IdDistrict=?";
        try (PreparedStatement stmt1=conn.prepareStatement(getCordsQuery);){
            
            stmt1.setInt(1, IdDistrict);
            ResultSet rs1 = stmt1.executeQuery();    
            if(rs1.next()){
                
                xCord = rs1.getInt("xCord");
                yCord = rs1.getInt("yCord");
                
                districtCords = new ri170656_Pair<>(xCord, yCord);
                
                return districtCords;
            }
            
        } catch (SQLException ex) {}
        
        return districtCords;
    }
    
    public int getFuelPricePerL(int fuelType){
        int fuelPrice = 0;
        
        switch(fuelType){
            case 0 -> fuelPrice = 15;
            case 1 -> fuelPrice = 32;
            case 2 -> fuelPrice = 36;
        }
        
        return fuelPrice;
    }
    
    public void stopDelivery(String courierUserName){
        
        Connection conn = DB.getInstance().getConnection();
        
        String stopDeliveryQuery=   "update Courier\n" +
                                    "set Status=0\n" +
                                    "where CourierUserName=?";
        
        try (PreparedStatement stmt1=conn.prepareStatement(stopDeliveryQuery);){
            
            stmt1.setString(1, courierUserName);
            stmt1.executeUpdate();          
        
        } catch (SQLException ex) {}
        
    }
    
}

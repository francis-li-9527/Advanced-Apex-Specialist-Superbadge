@isTest
private class OrderTests {
  
    @testSetup static void SetupTestData(){
        TestDataFactory.InsertTestData(1);
    }

    @isTest private static void OrderUpdate_UnitTest() {
        Test.startTest();
        
        Order o = [SELECT Id, Status FROM Order LIMIT 1];
        Product2 p = [SELECT Id, Family, Name, Quantity_Ordered__c, Quantity_Remaining__c FROM Product2 LIMIT 1];
        
        o.status = Constants.ACTIVATED_ORDER_STATUS;
        update o;
        
        Product2 p2 =  [SELECT Id, Family, Name, Quantity_Ordered__c, Quantity_Remaining__c FROM Product2 LIMIT 1];      
        
        TestDataFactory.VerifyQuantityOrdered(p, p2, Constants.DEFAULT_ROWS);
        
        Test.stopTest();
    }
    
    
}

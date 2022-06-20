@isTest (seeAllData=true)
private class Product2Tests {

    /**
     * @name product2Extension_UnitTest
     * @description UnitTest for product2Extension
    **/
    static TestMethod void Product2Extension_UnitTest(){
        Test.startTest();
        
        PageReference pageRef = Page.product2New;
        Test.setCurrentPage(pageRef);
        Product2 p = new Product2(name = 'Test', isActive=true);
        ApexPages.StandardController stdCon = new ApexPages.StandardController(p);
        Product2Extension ext = new Product2Extension(stdCon);
    ext.addRows(); 
        //System.assertEquals(Constants.DEFAULT_ROWS*2, ext.productsToInsert.size());
        System.assert(ext.productsToInsert.size() == Constants.DEFAULT_ROWS*2);

        for (Integer i=0; i<5; i++) {
            Product2Extension.ProductWrapper wrapper = ext.productsToInsert[i];
            Product2 pro = new Product2();
            pro.Name = 'Test Product' + i;
            pro.IsActive = true;
            pro.Initial_Inventory__c = 20;
            pro.Family = Constants.PRODUCT_FAMILY[0].getValue();
            wrapper.productRecord = pro;
            
            PriceBookEntry pbe = new PriceBookEntry();
            pbe.IsActive = true;
            pbe.UnitPrice = 10;
            wrapper.pricebookEntryRecord =pbe;
            
        }
        
        ext.save();
        ext.GetFamilyOptions();
        ext.GetInventory();
        Test.stopTest();
        
        List<Product2> createdProducts = [
            SELECT
            Id
            FROM
            Product2
            where  IsActive= true  and Name = 'Test Product1'
        ];
        System.assertEquals(1, createdProducts.size());
    }

}

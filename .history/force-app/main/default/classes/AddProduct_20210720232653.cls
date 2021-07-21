/**
 * @description       : 
 * @author            : robert
 * @group             : dcit-hf
 * @last modified on  : 07-20-2021
 * @last modified by  : robert
 * Modifications Log 
 * Ver   Date         Author   Modification
 * 1.0   07-20-2021   robert   Initial Version
**/
public with sharing class AddProduct2 {
    
    public class CustomProduct {
        @AuraEnabled
        public String ProductName { get; set; }
        @AuraEnabled
        public String ProductCode { get; set; }
        @AuraEnabled
        public String Description { get; set; }
        @AuraEnabled
        public String Family { get; set; }
        @AuraEnabled
        public String PID { get; set; }
        @AuraEnabled
        public Double Quantity { get; set; }
        @AuraEnabled
        public Integer SalesPrice { get; set; }

        /**
         * @description: 内部类构造方法
         */
        public CustomProduct(String ProductName, String ProductCode, String Description, String Family, String PID, Integer SalesPrice) {
            try {
                this.ProductName = ProductName;
                this.ProductCode = ProductCode;
                this.Description = Description;
                this.Family = Family;
                this.PID = PID;
                this.Quantity = null;
                this.SalesPrice = SalesPrice;
            } catch (Exception e) {
                throw new AuraHandledException(e.getMessage());
            }
        }
    }


    
    @AuraEnabled
    public static List<CustomProduct> getAllPricebookEntry(String defaultId) {
        //  存储封装的自定义价格手册
        List<CustomProduct> myProducts = new List<CustomProduct>();
        for (PricebookEntry p : [
                SELECT Id, Name,
                        Product2.Id,
                        Product2.Name,
                        Product2.ProductCode,
                        Product2.Description,
                        Product2.Family,
                        UnitPrice
                FROM PricebookEntry
                WHERE Pricebook2Id = :defaultId
        ]) {
            myProducts.add(new CustomProduct(p.Product2.Name, p.Product2.ProductCode, p.Product2.Description, p.Product2.Family, p.Product2.Id, (Integer) p.UnitPrice));
        }
        return myProducts;
    }

    
    @AuraEnabled
    public static List<CustomProduct> searchProduct(String BookId, String condition) {
        //  存储封装的自定义介个手册
        condition = '%' + condition + '%';
        List<CustomProduct> myProducts = new List<CustomProduct>();
        for (PricebookEntry p : [
                SELECT Id, Name,
                        Product2.Id,
                        Product2.Name,
                        Product2.ProductCode,
                        Product2.Description,
                        Product2.Family,
                        UnitPrice
                FROM PricebookEntry
                WHERE Pricebook2Id = :BookId
                AND (Product2.Name LIKE :condition OR Product2.ProductCode LIKE :condition)
        ]) {
            myProducts.add(new CustomProduct(p.Product2.Name, p.Product2.ProductCode, p.Product2.Description, p.Product2.Family, p.Product2.Id, (Integer) p.UnitPrice));
        }
        return myProducts;
    }

    /**
         * @author Frank
         * @date 2021/07/07 14:24
         * @description 获取默认价格手册
         * @Parameters 无
         * @return 价格手册
         */
    @AuraEnabled
    public static List<Pricebook2> getPricebook2s() {
        List<Pricebook2> pricebook2s = [SELECT Id, Name FROM Pricebook2];
        return pricebook2s;
    }

    
    @AuraEnabled
    public static List<CustomProduct> selectPricebook2s(String BookId) {
        List<CustomProduct> myProducts = new List<CustomProduct>();
        for (PricebookEntry p : [
                SELECT Id, Name,
                        Product2.Id,
                        Product2.Name,
                        Product2.ProductCode,
                        Product2.Description,
                        Product2.Family,
                        UnitPrice
                FROM PricebookEntry
                WHERE Pricebook2Id = :BookId
        ]) {
            myProducts.add(new CustomProduct(p.Product2.Name, p.Product2.ProductCode, p.Product2.Description, p.Product2.Family, p.Product2.Id, (Integer) p.UnitPrice));
        }
        return myProducts;
    }

    /**
     * @author Frank
     * @date 2021/07/07 14:24
     * @description 插入产品
     * @Parameters 业务机会产品
     * @return 无
     */
    @AuraEnabled
    public static void insertProduct(List<OpportunityLineItem> opportunityLineItems) {
        insert opportunityLineItems;
    }
}
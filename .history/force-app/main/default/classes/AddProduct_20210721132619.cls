/**
 * @description       : 
 * @author            : robert
 * @group             : dcit-hf
 * @last modified on  : 07-21-2021
 * @last modified by  : robert
 * Modifications Log 
 * Ver   Date         Author   Modification
 * 1.0   07-20-2021   robert   Initial Version
**/
public with sharing class AddProduct {
        
    // @AuraEnabled
    // public static List<CustomProduct> getAllPricebookEntry(String defaultId) {
    //     //  存储价格手册
    //     List<CustomProduct> myProducts = new List<CustomProduct>();
    //     for (PricebookEntry p : [
    //             SELECT Id, Name,
    //                     Product2.Id,
    //                     Product2.Name,
    //                     Product2.ProductCode,
    //                     Product2.Description,
    //                     Product2.Family,
    //                     UnitPrice
    //             FROM PricebookEntry
    //             WHERE Pricebook2Id = :defaultId
    //     ]) {
    //         myProducts.add(new CustomProduct(p.Product2.Name, p.Product2.ProductCode, p.Product2.Description, p.Product2.Family, p.Product2.Id, (Integer) p.UnitPrice));
    //     }
    //     return myProducts;
    // }

    //模糊查询
    @AuraEnabled
    public static List<CustomProduct> searchProduct(String condition) {
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
                WHERE Pricebook2Id = '01s5g00000HtuvPAAR'
                AND (Product2.Name LIKE :condition OR Product2.ProductCode LIKE :condition)
        ]) {
            myProducts.add(new CustomProduct(p.Product2.Name, p.Product2.ProductCode, p.Product2.Description, p.Product2.Family, p.Product2.Id, (Integer) p.UnitPrice));
        }
        System.debug(myProducts);
        return myProducts;
    }

    //加载价格手册
    @AuraEnabled
    public static List<CustomProduct> loadPriceBook() {
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
                WHERE Pricebook2Id = '01s5g00000HtuvPAAR'
        ]) {
            myProducts.add(new CustomProduct(p.Product2.Name, p.Product2.ProductCode, p.Product2.Description, p.Product2.Family, p.Product2.Id, (Integer) p.UnitPrice));
        }
        return myProducts;
    }

    //插入业务机会产品
    @AuraEnabled
    public static void insertProduct(List<OpportunityLineItem> opportunityLineItems) {
        System.debug(opportunityLineItems);
        insert opportunityLineItems;
    }

    //创建一个内部类
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
}
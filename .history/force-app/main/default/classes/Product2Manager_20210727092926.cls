/**
 * @description       : 
 * @author            : robert
 * @group             : dcit-hf
 * @last modified on  : 07-27-2021
 * @last modified by  : robert
**/
@RestResource(urlMapping='/Product2s/*')
global with sharing class Product2Manager {
    @HttpGet
    global static Product2 getProduct2ById() {
        RestRequest request = RestContext.request;
        // 从URL的末尾抓取Product2的Id
        String product2Id = request.requestURI.substring(
            request.requestURI.lastIndexOf('/')+1);
        Product2 result = [SELECT Name,ProductCode,IsActive,Description
                        FROM Product2
                        WHERE Id =: product2Id];
        return result;
    }

    @HttpPost
    global static List<MessageReturn> createProduct2(){
        RestRequest request = RestContext.request;
        String body = request.requestBody.toString();
        System.debug(body);
        List<Product2> products = (List<Product2>)JSON.deserialize(body, List<Product2>.class);
        List<MessageReturn> mesReturn = new List<MessageReturn>();
        System.debug(products);
        Database.SaveResult[] saveResult =  Database.insert(products, false);
        for (Database.SaveResult item : saveResult){
            System.debug(item);
            mesReturn.add(new MessageReturn('1234567', '000', 'success'));
        }

        return mesReturn;
                             
    }

    @HttpDelete
    global static void deleteProduct2() {
        RestRequest request = RestContext.request;
        String product2Id = request.requestURI.substring(
            request.requestURI.lastIndexOf('/')+1);
        Product2 thisProduct2 = [SELECT Id FROM Product2 WHERE Id =: product2Id];
        delete thisProduct2;
    }

    @HttpPut
    global static ID upsertProduct2(String productName, String ProductCode, Boolean isActive, String description, String id){
        Product2 thisProduct2 = new Product2(Id = id,
                                 Name = productName, 
                                 ProductCode = productCode, 
                                 IsActive = isActive, 
                                 Description = description);
        upsert thisProduct2;
        return thisProduct2.Id;
    }

    @HttpPatch
    global static ID updateProduct2Fields() {
        RestRequest request = RestContext.request;
        String product2Id = request.requestURI.substring(
            request.requestURI.lastIndexOf('/')+1);
        Product2 thisProduct2 = [SELECT Id FROM Product2 WHERE Id =: product2Id];
        Map<String, Object> params = (Map<String, Object>)JSON.deserializeUntyped(request.requestBody.toString());
        for (String fieldName : params.keySet()){
            thisProduct2.put(fieldName, params.get(fieldName));
        }
        update thisProduct2;
        return thisProduct2.Id;
    }

    public class MessageReturn {
        public String ProductCode { get; set;}
        public String Status {get; set;}
        public String Message {get; set;}

        public MessageReturn(String ProductCode, String Status, String Message){
            try {
                this.ProductCode = ProductCode;
                this.Status = Status;
                this.Message = Message;
            } catch (Exception e) {
                throw new AuraHandledException(e.getMessage());
            }
        }
    }
}
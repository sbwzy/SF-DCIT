/**
 * @description       : 
 * @author            : robert
 * @group             : dcit-hf
 * @last modified on  : 07-26-2021
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
    global static Product2 createProduct2(String productName, String productCode, Boolean isActive, String description){
        Product2 thisProduct2 = new Product2(Name = productName, 
                                 ProductCode = productCode, 
                                 IsActive = isActive, 
                                 Description = description);
        insert thisProduct2;
        return thisProduct2;
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
}
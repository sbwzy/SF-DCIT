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
        List<Product2> products = (List<Product2>)JSON.deserialize(body, List<Product2>.class);
        List<MessageReturn> mesReturn = new List<MessageReturn>();
        List<Product2> oldList = [SELECT Id,ProductCode FROM Product2];
        System.debug(products);

        //查重
        Map<String,Schema.SObjectType> allSObjectTypeDescribes = Schema.getGlobalDescribe();
		Schema.SObjectType studentType = allSObjectTypeDescribes.get(objectApiName);
        Set<String> fields = studentType.getDescribe().fields.getMap().keySet();//对象的所有字段API
        
        //移除掉系统默认字段 Id、编号、时间不能有
        for(String str :fields)if(!str.contains('__c'))fields.remove(str);
        
        Map<String,sObject> newMap = new Map<String,sObject>();
       

        Database.SaveResult[] saveResult =  Database.insert(products, false);
        System.debug(saveResult);
        for (Database.SaveResult item : saveResult){
            System.debug(item.id);
            Product2 pCode = [SELECT Id,ProductCode FROM Product2 WHERE Id =: item.Id];
            mesReturn.add(new MessageReturn(pCode.ProductCode, '000', 'success'));
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

    global class MessageReturn {
        global String ProductCode { get; set;}
        global String Status {get; set;}
        global String Message {get; set;}

        global MessageReturn(String ProductCode, String Status, String Message){
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
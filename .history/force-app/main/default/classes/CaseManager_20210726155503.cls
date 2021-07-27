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
        // 从URL的末尾抓取Product2Id
        String Product2Id = request.requestURI.substring(
            request.requestURI.lastIndexOf('/')+1);
        Product2 result = [SELECT CaseNumber,Subject,status,Origin,Priority
                        FROM Product2
                        WHERE Id =: Product2Id];
        return result;
    }

    @HttpPost
    global static ID createProduct2(String subject, String status, String origin, String priority){
        Product2 thisProduct2 = new Product2(Subject = subject, 
                                 Status = status, 
                                 Origin = origin, 
                                 Priority = priority);
        insert thisProduct2;
        return thisCase.Id;
    }

    @HttpDelete
    global static void deleteCase() {
        RestRequest request = RestContext.request;
        String casedId = request.requestURI.substring(
            request.requestURI.lastIndexOf('/')+1);
        Product2 thisCase = [SELECT Id FROM CASE WHERE Id =: casedId];
        delete thisCase;
    }

    @HttpPut
    global static ID upsertCase(String subject, String status, String origin, String priority, String id){
        Product2 thisCase = new Product2(Id = id,
                                 Subject = subject, 
                                 Status = status, 
                                 Origin = origin, 
                                 Priority = priority);
        upsert thisCase;
        return thisCase.Id;
    }

    @HttpPatch
    global static ID updateCaseFields() {
        RestRequest request = RestContext.request;
        String caseId = request.requestURI.substring(
            request.requestURI.lastIndexOf('/')+1);
        Product2 thisCase = [SELECT Id FROM Product2 WHERE Id =: caseId];
        Map<String, Object> params = (Map<String, Object>)JSON.deserializeUntyped(request.requestBody.toString());
        for (String fieldName : params.keySet()){
            thisCase.put(fieldName, params.get(fieldName));
        }
        update thisCase;
        return thisCase.Id;
    }
}
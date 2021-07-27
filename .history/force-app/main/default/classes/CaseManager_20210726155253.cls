/**
 * @description       : 
 * @author            : robert
 * @group             : dcit-hf
 * @last modified on  : 07-26-2021
 * @last modified by  : robert
**/
@RestResource(urlMapping='/Cases/*')
global with sharing class CaseManager {
    @HttpGet
    global static Product2 getCaseById() {
        RestRequest request = RestContext.request;
        // 从URL的末尾抓取casedId
        String caseId = request.requestURI.substring(
            request.requestURI.lastIndexOf('/')+1);
        Product2 result = [SELECT CaseNumber,Subject,status,Origin,Priority
                        FROM Product2
                        WHERE Id =: caseId];
        return result;
    }

    @HttpPost
    global static ID createCase(String subject, String status, String origin, String priority){
        Product2 thisCase = new Product2(Subject = subject, 
                                 Status = status, 
                                 Origin = origin, 
                                 Priority = priority);
        insert thisCase;
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
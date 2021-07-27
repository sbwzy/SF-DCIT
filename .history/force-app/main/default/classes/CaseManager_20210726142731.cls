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
    global static Case getCaseById() {
        RestRequest request = RestContext.requrest;
        // 从URL的末尾抓取casedId
        String casedId = request.requestURL.substring(
            request.requestURL.lastIndexOf('/')+1);
        Case result = [SELECT CaseNumber,Subject,status,Origin,Priority]
    }
}
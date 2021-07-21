/**
 * @description       : 
 * @author            : robert
 * @group             : dcit-hf
 * @last modified on  : 07-20-2021
 * @last modified by  : robert
 * Modifications Log 
 * Ver   Date         Author   Modification
 * 1.0   07-15-2021   robert   Initial Version
**/
public with sharing class AccountDetailsCtrl {
    //获取所有的客户
    @AuraEnabled
    public static List<Account> getAllAccount(){
        try {
            return [SELECT Id,AccountNumber,Name,AccountSource FROM Account limit 50000];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    //客户名模糊搜索
    @AuraEnabled
    public static List<Account> nameSearch(String accName){
        System.debug('7777');
        System.debug(accName);
        String aName = '%'+accName+'%';
        try {
            String sql = 'SELECT Id,AccountNumber,Name,AccountSource FROM Account WHERE Name LIKE :aName';
            System.debug('sql: ' + sql);
            return [SELECT Id,AccountNumber,Name,AccountSource FROM Account WHERE Name LIKE :aName];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    //客户来源模糊搜索
    @AuraEnabled
    public static List<Account> sourceSearch(String accSource){
        System.debug(accSource);
        String aSource = '%'+accSource+'%';
        try {
            return [SELECT Id,AccountNumber,Name,AccountSource FROM Account WHERE AccountSource LIKE :aSource];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    //获取客户下的所有联系人
    @AuraEnabled
    public static List<Contact> getAllContacts(String accountId){
        try {
            return [SELECT Id,Name,Phone,Title FROM Contact WHERE AccountId =: accountId];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    //添加客户联系人
    @AuraEnabled
    public static Contact addContact(String accountId, String firstName, String lastName, String contactPhone, String contactTitle){
        try {
            Contact ctt = new Contact(AccountId=accountId, FirstName=firstName, LastName=lastName, Phone=contactPhone, Title=contactTitle);
            insert ctt;
            return ctt;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    
    //删除客户
    @AuraEnabled
    public static List<Account> deleteAccount(list<Account> deleteAcc){
        try {
            system.debug(deleteAcc)
            delete deleteAcc;
            return [SELECT Id,AccountNumber,Name,AccountSource FROM Account limit 50000];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}
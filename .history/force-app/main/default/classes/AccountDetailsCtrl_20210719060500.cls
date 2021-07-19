/**
 * @description       : 
 * @author            : robert
 * @group             : dcit-hf
 * @last modified on  : 07-19-2021
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

    //获取客户下的所有联系人
    @AuraEnabled
    public static List<Contact> getAllContacts(row){
        try {
            return [SELECT  FROM Account]
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}

/**
 * @description       : 
 * @author            : robert
 * @group             : dcit-hf
 * @last modified on  : 07-15-2021
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
            // List<AccountWrapper> accList = new list<AccountWrapper>();
            // for(Account acc:[SELECT AccountNumber,Name,AccountSource FROM Account]){
            //     AccountWrapper wrapper = new AccountWrapper(acc.AccountNumber, acc.Name, acc.AccountSource);
            //     accList.add(wrapper);
            // }
            return [SELECT Id,AccountNumber,Name,AccountSource FROM Account limit 50000];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}
/**
 * @description       : 
 * @author            : robert
 * @group             : dcit-hf
 * @last modified on  : 07-02-2021
 * @last modified by  : robert
 * Modifications Log 
 * Ver   Date         Author   Modification
 * 1.0   07-01-2021   robert   Initial Version
**/
public with sharing class getName {
    //新建客户
    @AuraEnabled
    public static Account createAccount(String accountName){
        try {
            Account acc = new Account(Name=accountName);
            insert acc;
            return acc;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    //获取所有客户
    @AuraEnabled
    public static List<AccountWrapper> getAllAccount(){
        try {
            List<AccountWrapper> accList = new List<AccountWrapper>();
            for (Account acc : [SELECT id,Name FROM Account order by createddate desc limit]){
                AccountWrapper wrapper = new AccountWrappper(acc.Name, acc.Id);
                accList.add(wrapper);
            }
            return accList;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}
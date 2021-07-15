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
    public static List<AccountWrapper> getAllAccount(){
        try {
            List<AccountWrapper> accList = new list<AccountWrapper>();
            for(Account acc:[SELECT AccountNumber,id,Name FROM Account order by createdate desc limit 5]){
                AccountWrapper wrapper = new AccountWrapper(acc.Name, acc.Id);
                accList.add(wrapper);
            }
            return accList;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}

/**
 * @description       : 更新客户站点为空的客户的站点为'www.salesforce.com'
 * @author            : robert
 * @group             : dcit-hf
 * @last modified on  : 07-22-2021
 * @last modified by  : robert
 * Modifications Log 
 * Ver   Date         Author   Modification
 * 1.0   07-22-2021   robert   Initial Version
**/
global class UpdateSite implements Database.Batchable<SObject>, Database.Stateful, Schedulable{
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT Id,Site FROM Account Order By Name desc');
    }
    
    global void execute (Database.BatchableContext BC, List<Account> scope){
        for (Account acc : scope){
            if(''.equals(acc.Site)){
                acc.Site = 'www.salesforce.com';
            }
        }
        update scope;
    }

    global void finish (Database.BatchableContext BC){
        // do something
    }

    global void execute(SchedulableContext SC){
        Id updateSiteId = Database.executeBatch(new UpdateSIte());
    }
}

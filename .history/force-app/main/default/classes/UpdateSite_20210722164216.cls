/**
 * @description       : 
 * @author            : robert
 * @group             : dcit-hf
 * @last modified on  : 07-22-2021
 * @last modified by  : robert
 * Modifications Log 
 * Ver   Date         Author   Modification
 * 1.0   07-22-2021   robert   Initial Version
**/
global class UpdateSite implements Database.Batchable<SObject>, Database.Stateful {
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT Id,Site FROM Account Order By Name desc');
    }

    global void excute (Database.BatchableContext BC, List<Account> scope){
        for (Account acc : scope){
            if(acc.Site === null){
                acc.Site = 'www.salesforce.com';
            }
        }
        update scope;
    }

    global void finish (Database.BatchableContext BC){
        // do something
    }
}

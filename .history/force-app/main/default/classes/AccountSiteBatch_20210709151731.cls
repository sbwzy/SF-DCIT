/**
 * @description       : 
 * @author            : robert
 * @group             : dcit-hf
 * @last modified on  : 07-09-2021
 * @last modified by  : robert
 * Modifications Log 
 * Ver   Date         Author   Modification
 * 1.0   07-09-2021   robert   Initial Version
**/
global class AccountSiteBatch implements Database.Batachable<sObject>, Database.Statedul, Schedulable{
    global void execute(SchedulableContext sc){
        global Database.QueryLocator start(Database.BatchableContext bc){
            return Database.getQueryLocator('SELECT Id,Name,Site FROM Account WHERE Account.Site=null');
        }

        global void execute(Database.BatchableContext BC, List<Sobject> scope){
            Account.Site = 'www.salesforce.com';
        }

        global void finish(Database.BatchableContext BC){

        }
    }
}

System.Schedulable('AccountSiteBatchSchedule', '0 0 0 * * ?', new Database.executeBatech(new AccountSiteBatch()));
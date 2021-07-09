/**
 * @description       : 批处理测试
 * @author            : robert
 * @group             : dcit-hf
 * @last modified on  : 07-09-2021
 * @last modified by  : robert
 * Modifications Log 
 * Ver   Date         Author   Modification
 * 1.0   07-09-2021   robert   Initial Version
**/
global class SobjectBatch implements Database.Batchable<sObject>, Database.Statedul{
    global Database.QueryLocator start (DataBase.BatchableContext bc){
        return Database.getQueryLocator('SELECT Id,Name FROM PRODUCT2 Order By Name desc');
    }

    global void execute(Database.BatchableContext BC, List<Sobject> scope){
        System.debug('数据量：' + scope.size());
    }

    global void finish(Database.BatchableContext BC){

    }
}

Database.executeBatch(new SobjectBatch());
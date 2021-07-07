/**
 * @description       : 
 * @author            : robert
 * @group             : dcit-hf
 * @last modified on  : 06-30-2021
 * @last modified by  : robert
 * Modifications Log 
 * Ver   Date         Author   Modification
 * 1.0   06-30-2021   robert   Initial Version
**/
public class MemberTask{
    public void themembertask(List<Member__c> listTask, List<Member__c> oldListTask){
        //保存需要添加任务的会员
        List<Member__c> member = new List<Member__c>();
        //创建任务集合
        List<Task> taskList = new List<task>();
        //取出会员
        for (Member__c item:oldListTask){
            if (item.BuyedGoods = 'true'){
                Task task = new Task();
                task.WhatId = item.Account__c;
                task.Subject = '您有新的会员任务需要跟进';
                task.ActivityDate = Date.today() + 3;
                taskList.add(task);
            }
        }
        insert(taskList);
    }
}
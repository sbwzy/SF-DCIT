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
trigger MemberTaskTrigger on Member__c (after insert,after update,after delete,after undelete)
{
    if(trigger.isAfter){
        MemberTask memberTask=new MemberTask();
        if(trigger.isInsert){
            memberTask.thememberTask(trigger.new);
        }
        if(trigger.isUpdate){
            memberTask.thememberTask(trigger.new,trigger.old);
        }
        if(trigger.isDelete){
            memberTask.thememberTask(trigger.old);
        }
        if(trigger.isUndelete){
            memberTask.thememberTask(trigger.new);
        }
    }
}
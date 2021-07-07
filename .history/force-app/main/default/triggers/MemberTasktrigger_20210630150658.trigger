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
        MemberTask MemberTask=new Cbl_MemberTask();
        if(trigger.isInsert){
            MemberTask.MemberTask(trigger.new);
        }
        if(trigger.isUpdate){
            MemberTask.MemberTask(trigger.new,trigger.old);
        }
        if(trigger.isDelete){
            MemberTask.MemberTask(trigger.old);
        }
        if(trigger.isUndelete){
            MemberTask.MemberTask(trigger.new);
        }
    }
}
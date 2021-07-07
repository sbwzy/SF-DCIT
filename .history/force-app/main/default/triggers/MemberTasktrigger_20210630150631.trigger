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
        MemberTask memberCount=new Cbl_MemberCount();
        if(trigger.isInsert){
            memberCount.memberCount(trigger.new);
        }
        if(trigger.isUpdate){
            memberCount.memberCount(trigger.new,trigger.old);
        }
        if(trigger.isDelete){
            memberCount.memberCount(trigger.old);
        }
        if(trigger.isUndelete){
            memberCount.memberCount(trigger.new);
        }
    }
}
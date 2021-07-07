trigger MemberTrigger on Member__c (after insert,after update,after delete,after undelete)
{
    if(trigger.isAfter){
        Cbl_MemberCount memberCount=new Cbl_MemberCount();
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
trigger OpportunityDetailsTrigger on OpportunityLineItem (after insert,after update,after delete,after undelete)
{
    if(trigger.isAfter){
        Cbl_OpportunityDetails opportunityDetails=new Cbl_OpportunityDetails();
        if(trigger.isInsert){
            opportunityDetails.opportunityDetails(trigger.new);
        }
        if(trigger.isUpdate){
            opportunityDetails.opportunityDetails(trigger.new,trigger.old);
        }
        if(trigger.isDelete){
            opportunityDetails.opportunityDetails(trigger.old);
        }
        if(trigger.isUndelete){
            opportunityDetails.opportunityDetails(trigger.new);
        }
    }
}
/**
 * @description       : 
 * @author            : robert
 * @group             : dcit-hf
 * @last modified on  : 07-02-2021
 * @last modified by  : robert
 * Modifications Log 
 * Ver   Date         Author   Modification
 * 1.0   07-02-2021   robert   Initial Version
**/
trigger SFDCAmountTrigger on SOBJECT (after insert,after update,after delete,after undelete) {
    if (Trigger.isAfter){
        Cbl_SFDCAmount SFDCAmount = new Cbl_SFDCAmount();
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
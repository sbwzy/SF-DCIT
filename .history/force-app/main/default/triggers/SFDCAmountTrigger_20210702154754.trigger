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
trigger SFDCAmountTrigger on OpportunityLineItem (after insert,after update,after delete,after undelete) {
    if (trigger.isAfter){
        Cbl_SFDCAmount SFDCAmount = new Cbl_SFDCAmount();
        if(trigger.isInsert){
            SFDCAmount.SFDCAmount(trigger.new);
        }
        if(trigger.isUpdate){
            SFDCAmount.SFDCAmount(trigger.new,trigger.old);
        }
        if(trigger.isDelete){
            SFDCAmount.SFDCAmount(trigger.old);
        }
        if(trigger.isUndelete){
            SFDCAmount.SFDCAmount(trigger.new);
        }
    }
}
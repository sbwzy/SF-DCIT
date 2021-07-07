trigger OpportunityTtigger on Opportunity (before insert, before update,after insert, after update, before delete, after delete) {
    if(Trigger.isAfter){
        if(Trigger.isUpdate){
            Set<Id> opportunityIdSet = new Set<Id>();
            for(Opportunity item:Trigger.new){
                if(item.Status__c != Trigger.oldMap.get(item.Id).Status__c && item.Status__c=='审批通过'){
                    opportunityIdSet.add(item.id);
                }
            }
            List<OpportunityLineItem> oppItemList = [SELECT Status__c,id FROM OpportunityLineItem Where OpportunityId IN: opportunityIdSet];
            for (OpportunityLineItem item:oppItemList){
                    item.Status__c = '审批通过';
                }
            update oppItemList;
        }
    }
}
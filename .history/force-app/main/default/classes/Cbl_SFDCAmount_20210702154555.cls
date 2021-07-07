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
public with sharing class Cbl_SFDCAmount {
    public void SFDCAmount(List<OpportunityLineItem> list_Item){
        set<ID> set_ID = new set<ID>();
        List<ID> list_id = new List<id>();
        //遍历得到的集合，set去重得到操作过的 业务机会 的ID
        for (OpportunityLineItem objItem:list_Item){
            set_ID.add(objItem.OpportunityId);
        }
        //存储业务机会产品
        List<OpportunityLineItem> oppLitem = new List<OpportunityLineItem>();
        //获取业务机会产品
        for (OpportunityLineItem opportunityLitem:[SELECT Id,Name,Product2Id,OpportunityId,Quantity,Product2.SFDCAmount__c FROM OpportunityLineItem WHERE OpportunityId in: set_ID]){
            oppLitem.add(opportunityLitem);
        }
        //存储业务机会
        List<Opportunity> opp = new List<Opportunity>();
        Double SFDCTotalPrice=0;
        for (Opportunity item:[SELECT Id,Name,SFDCAmount__c FROM Opportunity WHERE Id IN:set_ID]){
            for (OpportunityLineItem LineItem:oppLitem){
                SFDCTotalPrice += (LineItem.Product2.SFDCAmount__c * LineItem.Quantity);
            }
            item.SFDCAmount__c = SFDCTotalPrice;
            opp.add(item);
        }
        update(opp);
    }
    public void SFDCAmount(List<OpportunityLineItem> list_Item, List<OpportunityLineItem> oldlist_Item){
        Cbl_SFDCAmount SFDCAmount = new Cbl_SFDCAmount();
        SFDCAmount.SFDCAmount(list_Item);
        SFDCAmount.SFDCAmount(oldlist_Item);
    }
}
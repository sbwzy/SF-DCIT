/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 07-06-2021
 * @last modified by  : robert
 * Modifications Log 
 * Ver   Date         Author                               Modification
 * 1.0   06-30-2021   ChangeMeIn@UserSettingsUnder.SFDoc   Initial Version
**/
public class Cbl_OpportunityDetails{
    public void opportunityDetails(List<OpportunityLineItem> list_Item){
        set<ID> set_ID = new set<ID>();
        List<ID> list_id = new List<id>();
        //遍历得到的集合，set去重得到操作过的 业务机会 的ID
        for (OpportunityLineItem objItem:list_Item){
            set_ID.add(objItem.OpportunityId);
        }
        //存储业务机会产品
        List<OpportunityLineItem> oppLitem = new List<OpportunityLineItem>();
        //获取业务机会产品
        for (OpportunityLineItem opportunityLitem:[SELECT Id,Name,Quantity,Product2Id,OpportunityId,TotalPrice,Product2.ProductLevel__c FROM OpportunityLineItem WHERE OpportunityId in: set_ID]){
            oppLitem.add(opportunityLitem);
        }
        //存储业务机会
        List<Opportunity> opp = new List<Opportunity>();
        Double strategicProductPrice=0, strategicProductQuantity=0;
        Double newProductPrice=0, newProductQuantity=0;

        //累加判断 商机等级
        for (Opportunity item:[SELECT Id,Name,opportunityLevel__c FROM Opportunity WHERE Id IN:set_ID]){
            //累加得金额与数量
            for(OpportunityLineItem Lineitem:oppLitem){
                if(Lineitem.Product2.ProductLevel__c == '战略产品'){
                    strategicProductPrice += Lineitem.TotalPrice;
                    strategicProductQuantity += Lineitem.Quantity;
                }
                else if(Lineitem.Product2.ProductLevel__c == '新产品'){
                    newProductPrice += Lineitem.TotalPrice;
                    newProductQuantity += Lineitem.Quantity;
                }
            }
            //按条件更新 商机等级 字段
            if (strategicProductPrice > 5000000 || strategicProductQuantity > 100000){
                item.opportunityLevel__c = 'A';
            }
            else if ((strategicProductPrice + newProductPrice) > 8000000 || (strategicProductQuantity + newProductQuantity) > 200000){
                item.opportunityLevel__c = 'B';
            }
            else{
                item.opportunityLevel__c = 'C';
            }
            
            opp.add(item);
        }
		//更新数据
        update(opp);
    }
    public void opportunityDetails(List<OpportunityLineItem> list_Item, List<OpportunityLineItem> oldlist_Item){
        Cbl_OpportunityDetails opportunityDetails = new Cbl_OpportunityDetails();
        opportunityDetails.opportunityDetails(list_Item);
        opportunityDetails.opportunityDetails(oldlist_Item);
    }
}
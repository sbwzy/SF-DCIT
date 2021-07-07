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
public class MemberTask{
    public void membertask(List<Member__c> listTask){
        set<ID> setID = new set<ID>();
        for (Member__c memb:listTask){
            setID.add(memb.Buyedgoods__c);
        }
        listID.addAll(setID);
        //查询是否勾选上了 是否已购商品
        for (Member__c member:[SELECT Buyedgoods__c FROM Member__c Where Member__c.Buyedgoods__c IN:listID]){
            if (member.BuyedGoods = 'true'){
                Task task = new Task();
                Account.task = 
            }
        }
    }
}
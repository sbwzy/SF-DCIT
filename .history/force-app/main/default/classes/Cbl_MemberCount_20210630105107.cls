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
public class Cbl_MemberCount{
    public void memberCount(List<Member__c> list_member){
        set<ID> set_ID = new set<ID>();
        List<ID> list_id = new List<id>();
        
        for(Member__c item:List_Member){
            set_ID.add(item.account__c);
        }
        list_id.addAll(set_ID);
        list<AggregateResult> memberNum = [select count(id) from Member__c WHERE Member__c.account__c IN:list_id];
        
        List<Account> list_update = new List<Account>();
        for (Integer i = 0; i < memberNum.size(); i++){
            Account account = new Account();
            account.menNum__c = (Decimal)memberNum[i].get('expr0');
            account.id = list_id.get(i);
            list_update.add(account);
        }
        update(list_update);
    }
    
    public void memberCount(List<Member__c> list_Member,list<Member__c> oldlist_Member){
        Cbl_MemberCount memberCount = new Cbl_MemberCount();
        memberCount.memberCount(list_Member);
        memberCount.memberCount(oldlist_Member);
    }
}
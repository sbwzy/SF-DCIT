/**
 * @description       : 
 * @author            : robert
 * @group             : dcit-hf
 * @last modified on  : 07-05-2021
 * @last modified by  : robert
 * Modifications Log 
 * Ver   Date         Author   Modification
 * 1.0   07-05-2021   robert   Initial Version
**/
@isTest
public class Cbl_MemberCountTest {
    static testMethod void testCbl_MemberCount(){
        Test.startTest();
        Member__c member = new Member__c();
        member.Name='nameOne';
        insert member;
        Member__c member1 = new Member__c();
        member1.Name = 'nameTwo';
        insert member1;
        Test.stopTest();

        List<Member__c> memlist = [SELECT Id,Account__c FROM Member__c WHERE Account__c =: member.id];
        System.assertEquals(2,memList.size());
    }
}
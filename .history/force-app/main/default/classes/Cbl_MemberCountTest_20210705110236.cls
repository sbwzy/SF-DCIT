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
    static testMethod void setData(){
        Member__c member = new Member__c(Name='nameOne');
        insert member;
    }

    static testMethod void testCbl_MemberCount(){
        Cbl_MemberCount.setData();
        Test.startTest();
        
    }
}
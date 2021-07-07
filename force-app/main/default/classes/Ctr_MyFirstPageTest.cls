@isTest
public class Ctr_MyFirstPageTest{
    static testMethod void testCtr_MyFirstPage(){
        Ctr_MyFirstPage ctr = new Ctr_MyFirstPage();
    }

    static testMethod void testgetAccountList(){
        Ctr_MyFirstPageTest.setData();
        List<Account> acclist = Ctr_MyFirstPage.getAccountList();
        System.assertEquals(1,accList.size());
    }

    static testMethod void setData(){
        Account account = new Account(Name='test2');
        insert account;
    }
}
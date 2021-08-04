 /**********************************************************************
 * 
 *
 *@author:zero
 *@createdate:2019-12-10
 *@description:批量给客户发送电子邮件
 *
 *
*************************************************************************/
public class sendEmail {
    
    //查询所有客户
    /*@AuraEnabled
       public static List<Account> GetAll(){
      List<Account> acc = new List<Account>();
      acc = [SELECT Name,Company_Address__c,CompanyEmail__c from Account];
      return acc;
    }*/

   @AuraEnabled 
    public static List<accountListWrapper> fetchAccountWrapper(){     
        List<accountListWrapper> lstaccountListWrapper = new List<accountListWrapper>();
        // query account records and create 'accountListWrapper' class instance for each record. 
        for(Account acc : [Select id,Name,Type,Company_Address__c
                           From Account
                           Limit 1000]){
                               // by default checkbox should be false 
                               lstaccountListWrapper.add(new accountListWrapper(false,acc));
                           } 
        // return the 'lstaccountListWrapper' list 
        return lstaccountListWrapper; 
    }
    
    /* 封装类 */  
    public class accountListWrapper {
        @AuraEnabled public boolean isChecked {get;set;}
        @AuraEnabled public  account objAccount{get;set;}
        public accountListWrapper(boolean isChecked, account objAccount){
            this.isChecked = isChecked;
            this.objAccount = objAccount;
        }
    }
    

	
}

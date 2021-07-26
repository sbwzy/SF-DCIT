/**
 * @description       : 
 * @author            : robert
 * @group             : dcit-hf
 * @last modified on  : 07-26-2021
 * @last modified by  : robert
**/
public abstract class ContactTriggerHandler extends TriggerHandler{
    
    public void PhoneIsNULL(List<Contact> newItems) {
        for (Contact contact : newItems) {
            if (contact.Phone == null || contact.Phone == '') {
                contact.addError('联系人电话不允许为空，请填写联系人电话后再进行保存！');
            }
        }
    }
    
    Account account = new Account();
    //before insert事件处理方法
    public virtual void beforeInsert(List<Contact> newItems){
        Contatc contactNew = newItems.get(0);
        if(contactNew.Phone === null){

        }else{
            AccId = contactNew.AccountId;
            List<Account> accountList = [SELECT Id,Phone FROM Account WHERE Account.Id =: AccId];
            if(accountList.size() > 0){
                account = accountList.get(0);
            }else{
                account.Id = AccId;
            }
            account.Phone = contactNew.Phone;
            upsert account;
        }     
    }
    
    //before update事件处理方法
    public virtual void beforeUpdate(Map<Id, Contact> newItems, Map<Id, Contact> oldItems){
        
    }		

    //是否执行当前触发器的逻辑
    public virtual Boolean isExcute(){return true;}//是否执行当前触发器的逻辑

    public void run(){  
        if(!this.isExcute()){
            return;
        }
        if(Trigger.isBefore && Trigger.isInsert) {
            this.beforeInsert(trigger.new);
        } else if(Trigger.isBefore && Trigger.isUpdate) {
            this.beforeUpdate(trigger.newMap,trigger.oldMap);
        }
    }
}
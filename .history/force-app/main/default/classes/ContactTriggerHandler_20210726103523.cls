/**
 * @description       : 
 * @author            : robert
 * @group             : dcit-hf
 * @last modified on  : 07-26-2021
 * @last modified by  : robert
**/
public abstract class ContactTriggerHandler
{
    //before insert事件处理方法
    public virtual void beforeInsert(List<Contact> newItems){
        Contatc contactNew = newItems.get(0);
        if(contactNew.Phone === null){

        }else{
            AccID = contactNew.AccountId;
            List<Account> accountList = [SELECT Id,Phone FROM Account WHERE Account.Id =: AccId];
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
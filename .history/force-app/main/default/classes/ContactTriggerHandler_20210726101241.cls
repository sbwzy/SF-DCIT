/**
 * @description       : 
 * @author            : robert
 * @group             : dcit-hf
 * @last modified on  : 07-26-2021
 * @last modified by  : robert
**/
public abstract class ContactTriggerHandler
{
    List<Contact> contactListNew = trigger.new;
    List<Contact> contactListOld = trigger.old;
    Contact contactNew = contactListNew.get(0);
    Account 
    //before insert事件处理方法
    public virtual void beforeInsert(List<SObject> newItems){
        
    }
    
    //before update事件处理方法
    public virtual void beforeUpdate(Map<Id, SObject> newItems, Map<Id, SObject> oldItems){
        
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
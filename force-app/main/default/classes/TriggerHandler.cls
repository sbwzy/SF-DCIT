/**
 * @description       : 
 * @author            : robert
 * @group             : dcit-hf
 * @last modified on  : 07-26-2021
 * @last modified by  : robert
**/
public abstract class TriggerHandler
{

    public virtual void beforeInsert(List<SObject> newItems){}		//before insert事件处理方法
    public virtual void beforeUpdate(Map<Id, SObject> newItems, Map<Id, SObject> oldItems){}		//before update事件处理方法
    public virtual void beforeDelete(Map<Id, SObject> oldItems){}		//before delete事件处理方法
    public virtual void afterInsert(Map<Id, SObject> newItems){}			//after insert事件处理方法
    public virtual void afterUpdate(Map<Id, SObject> newItems, Map<Id, SObject> oldItems){}			//after update事件处理方法
    public virtual void afterDelete(Map<Id, SObject> oldItems){}			//after delete事件处理方法		
    public virtual void afterUndelete(Map<Id, SObject> newItems){}		//after undelete事件处理方法   
    public virtual Boolean isExcute(){return true;}//是否执行当前触发器的逻辑

    public void run(){  
        if(!this.isExcute()){
            return;
        }
        if(Trigger.isBefore && Trigger.isInsert) {
            this.beforeInsert(trigger.new);
        } else if(Trigger.isBefore && Trigger.isUpdate) {
            this.beforeUpdate(trigger.newMap,trigger.oldMap);
        } else if(Trigger.isBefore && Trigger.isDelete) {
            this.beforeDelete(trigger.oldMap);
        } else if(Trigger.isAfter && Trigger.isInsert) {
            this.afterInsert(trigger.newMap);
        } else if(Trigger.isAfter && Trigger.isUpdate) {
            this.afterUpdate(trigger.newMap,trigger.oldMap);
        } else if(Trigger.isAfter && Trigger.isDelete) {
            this.afterDelete(trigger.oldMap);
        } else if(Trigger.isAfter && Trigger.isUndelete) {
            this.afterUndelete(trigger.newMap);
        }
    }
}
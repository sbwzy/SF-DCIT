/**
 * @description       : 
 * @author            : robert
 * @group             : dcit-hf
 * @last modified on  : 07-26-2021
 * @last modified by  : robert
**/
public abstract class ContactTriggerHandler extends TriggerHandler{
    
    public void PhoneIsNULL(List<SObject> newItems) {
        // 查询操作的联系人
        List<Contact> contacts = (List<Contact>) newItems;

        // 遍历同时设置错误提示
        for (Contact contact : contacts) {
            if (contact.Phone == null || contact.Phone == '') {
                contact.addError('联系人电话不允许为空，请填写联系人电话后再进行保存！');
            }
        }
    }
    
    /**
 * Created by Frank on 2021/7/12.
 */
/**
 * @author Frank
 * @date 2021/07/12 15:26
 * @description: 继承自TriggerHandler 重写触发器
 * @version 1.0
 */

/**
 * @author Frank
 * @date 2021/07/12 15:26
 * @description: 继承TriggerHandler 重写触发器
 * @param {}
 * @return {}
 * @version 1.0
 */

public with sharing class ContactTriggerHandler extends TriggerHandler {
    public Override Boolean isExcute() {
        return true;
    }

    public void PhoneIsNULL(List<SObject> newItems) {
        // 查询操作的联系人
        List<Contact> contacts = (List<Contact>) newItems;

        // 遍历同时设置错误提示
        for (Contact contact : contacts) {
            if (contact.Phone == null || contact.Phone == '') {
                contact.addError('联系人电话不允许为空，请填写联系人电话后再进行保存！');
            }
        }
    }

    public void UpdatePhone(List<SObject> newItems) {
        // Map   键: 客户Id    值: 联系人电话
        Map<Id, String> con = new Map<Id, String>();
        // 联系人列表
        List<Contact> contacts = (List<Contact>) newItems;

        // 循环取值赋值存储到Map
        for (Contact contact : contacts) {
            con.put(contact.AccountId, contact.Phone);
        }

        // 查询操作过的相关客户
        List<Account> accounts = [SELECT Id, Phone FROM Account WHERE Id in:con.keySet()];

        // 更新联系人对应的客户电话
        for (Account account : accounts) {
            account.Phone = con.get(account.Id);
        }
        update accounts;
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
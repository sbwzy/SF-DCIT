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


    /**
 * @author Frank
 * @date 2021/07/12 15:26
 * @description: 电话为空给予提示
 * @param {操作过的联系人}
 * @return {无}
 * @version 1.0
 */
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
 * @author Frank
 * @date 2021/07/12 15:26
 * @description: 更新联系人对应客户电话
 * @param {操作过的联系人}
 * @return {}
 * @version 1.0
 */
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

    // 插入前
    public Override void beforeInsert(List<SObject> newItems) {
        PhoneIsNULL(newItems);
    }
    // 修改前
    public Override void beforeUpdate(Map<Id, SObject> newItems, Map<Id, SObject> oldItems) {
        PhoneIsNULL(newItems.values());
    }
    // 插入后
    public Override void afterInsert(Map<Id, SObject> newItems) {
        UpdatePhone(newItems.values());
    }
    // 修改后
    public Override void afterUpdate(Map<Id, SObject> newItems, Map<Id, SObject> oldItems) {
        UpdatePhone(newItems.values());
    }
}
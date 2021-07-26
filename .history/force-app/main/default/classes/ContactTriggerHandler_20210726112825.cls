/**
 * @description       : 
 * @author            : robert
 * @group             : dcit-hf
 * @last modified on  : 07-26-2021
 * @last modified by  : robert
**/
public with sharing class ContactTriggerHandler extends TriggerHandler {
    public Override Boolean isExcute() {
        return true;
    }

    public void PhoneIsNULL(List<SObject> newItems) {
        List<Contact> contacts = (List<Contact>) newItems;
        for (Contact contact : contacts) {
            if (contact.Phone == null || contact.Phone == '') {
                contact.addError('联系人电话不允许为空，请填写联系人电话后再进行保存！');
            }
        }
    }

    public void UpdatePhone(List<SObject> newItems) {
        // Key为客户Id
        Map<Id, String> con = new Map<Id, String>();
        List<Contact> contacts = (List<Contact>) newItems;
        for (Contact contact : contacts) {
            //赋值到map中
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
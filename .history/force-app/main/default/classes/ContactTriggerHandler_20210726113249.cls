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

    public void NoPhone(List<SObject> newItems) {
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
        List<Account> accounts = [SELECT Id, Phone FROM Account WHERE Id in:con.keySet()];
        for (Account account : accounts) {
            //更新电话
            account.Phone = con.get(account.Id);
        }
        update accounts;
    }

    //重写触发条件的触发效果
    public Override void beforeInsert(List<SObject> newItems) {
        NoPhone(newItems);
    }
    public Override void beforeUpdate(Map<Id, SObject> newItems, Map<Id, SObject> oldItems) {
        NoPhone(newItems.values());
    }
    public Override void afterInsert(Map<Id, SObject> newItems) {
        UpdatePhone(newItems.values());
    }
    public Override void afterUpdate(Map<Id, SObject> newItems, Map<Id, SObject> oldItems) {
        UpdatePhone(newItems.values());
    }
}
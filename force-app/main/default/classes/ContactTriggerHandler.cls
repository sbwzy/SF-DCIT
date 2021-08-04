/**
 * @description       : 
 * @author            : robert
 * @group             : dcit-hf
 * @last modified on  : 07-26-2021
 * @last modified by  : robert
**/
public with sharing class ContactTriggerHandler extends TriggerHandler {
    public void NoPhone(List<SObject> newItems) {
        List<Contact> contacts = (List<Contact>) newItems;
        for (Contact contact : contacts) {
            if (contact.Phone == null || contact.Phone == '') {
                contact.addError('联系人电话不允许为空，请填写联系人电话后再进行保存！');
            }
        }
    }

    public void UpdateAccountPhone(List<SObject> newItems) {
        // Key为客户Id
        Map<Id, String> contac = new Map<Id, String>();
        List<Contact> contacts = (List<Contact>) newItems;
        for (Contact contact : contacts) {
            //赋值到map中
            contac.put(contact.AccountId, contact.Phone);
        }
        List<Account> accounts = [SELECT Id, Phone FROM Account WHERE Id in:contac.keySet()];
        for (Account account : accounts) {
            //更新电话
            account.Phone = contac.get(account.Id);
        }
        update accounts;
    }

    //默认执行该触发器
    public Override Boolean isExcute() {
        return true;
    }

    //重写触发条件的触发效果
    public Override void beforeInsert(List<SObject> newItems) {
        NoPhone(newItems);
    }
    public Override void beforeUpdate(Map<Id, SObject> newItems, Map<Id, SObject> oldItems) {
        NoPhone(newItems.values());
    }
    public Override void afterInsert(Map<Id, SObject> newItems) {
        UpdateAccountPhone(newItems.values());
    }
    public Override void afterUpdate(Map<Id, SObject> newItems, Map<Id, SObject> oldItems) {
        UpdateAccountPhone(newItems.values());
    }
}
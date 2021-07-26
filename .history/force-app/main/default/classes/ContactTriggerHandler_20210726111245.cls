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
    
}
({
    doInitA : function(component, event, helper) {
        component.set('v.columns', [
            {label: '姓名', fieldName: 'Name', type: 'text'},
            {label: '手机号', fieldName: 'Phone', type: 'Phone'},
            {label: '电子邮件', fieldName: 'Email', type: 'email'}
        ]);
        //获取传入的contactList
        var value = event.getParam("contactList");
        component.set('v.contactList', value);
        var contact = component.get("v.contactList");
        console.log(contact);
    }
})
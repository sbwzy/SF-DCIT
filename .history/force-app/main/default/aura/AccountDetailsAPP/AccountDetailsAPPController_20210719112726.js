({
    doInit: function (cmp, event, helper) {
       cmp.set('v.columns', [
            {label: '客户编号', fieldName: 'AccountNumber', type: 'text'},
            {label: '客户名称', fieldName: 'URL', type: 'url', typeAttributes: {label: {fieldName: 'Name'}, target: '_blank', tooltip: '点击查看客户详细信息'}},
            {label: '客户来源', fieldName: 'AccountSource', type: 'text'},
            {label: '查看联系人', type: 'button', initialWidth: 280, typeAttributes:{label: '查看联系人列表', name: 'view_contacts', title: '点击查看联系人列表'}}
        ]);

        helper.fetchData(cmp);
    },
   
    updateSelectedText: function (cmp, event) {
        var selectedRows = event.getParam('selectedRows');
        cmp.set('v.selectedRowsCount', selectedRows.length);
    },

    viewContacts: function (cmp, event, helper){
        var action = event.getParam('action');
        var row = event.getParam('row');
        if (action.name === 'view_contacts'){
            helper.viewContacts(row);
        }
    },
   
    openModel: function(component, event, helper) {
        component.set("v.isOpen", true);
    },
   
    closeModel: function(component, event, helper) {
        component.set("v.isOpen", false);
    },

    openContactModel: function(component, event, helper) {
        component.set("v.isOpen", true);
    },
   
    closeContactModel: function(component, event, helper) {
        component.set("v.isOpen", false);
    },

    handleRowAction: function (cmp, event, helper) {
        console.log('1');
       
        console.log('2');
        var row = event.getParam('row');
        console.log('3');
       
        cmp.set("v.isOpen", true);
        cmp.set('v.contactsColumns', [
            {label: '联系人姓名', fieldName: 'Name', type: 'text'},
            {label: '联系人电话', fielddName: 'Phone', type: 'Phone'},
            {label: '职位', fieldName: 'Title', type: 'text'}
        ]);
        console.log('a');
        helper.viewContacts(row, cmp);
    },

    handleClick : function(cmp, event, helper){
        var accountName = cmp.get('v.accountName');
        var contactName = cmp.get('v.contactName');
        var contactPhone = cmp.get('v.contactPhone');
        var contactTitle = cmp.get('v.contactTitle');
        if(contactName != null){
            helper.addContact();
        }
        else{
            alter('请输入联系人的姓名');
        }
    }
});
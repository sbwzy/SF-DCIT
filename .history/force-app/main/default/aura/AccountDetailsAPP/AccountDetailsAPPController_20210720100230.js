({
    //页面初始化显示客户信息
    doInit: function (cmp, event, helper) {
       cmp.set('v.columns', [
            {label: '客户编号', fieldName: 'AccountNumber', type: 'text'},
            {label: '客户名称', fieldName: 'URL', type: 'url', typeAttributes: {label: {fieldName: 'Name'}, target: '_blank', tooltip: '点击查看客户详细信息'}},
            {label: '客户来源', fieldName: 'AccountSource', type: 'text'},
            {label: '查看联系人', type: 'button', initialWidth: 280, typeAttributes:{label: '查看联系人列表', name: 'view_contacts', title: '点击查看联系人列表'}}
        ]);

        helper.fetchData(cmp);
    },
   
    //客户名模糊搜索
    accountNameSearch: function(cmp, event, helper){
        console.log('222');
        helper.nameSearch();
    },

    //客户来源模糊搜索
    accountSourceSearch: function(cmp, event, helper){
        helper.sourceSearch();
    },

    updateSelectedText: function (cmp, event) {
        var selectedRows = event.getParam('selectedRows');
        cmp.set('v.selectedRowsCount', selectedRows.length);
    },

    //按钮 ‘查看联系人列表’ 的响应事件
    viewContacts: function (cmp, event, helper){
        var action = event.getParam('action');
        var row = event.getParam('row');
        if (action.name === 'view_contacts'){
            helper.viewContacts(row);
        }
    },
    
    //按钮‘添加联系人列表’的响应事件
    addContacts : function(cmp, evevt,helper){
        console.log('1');
        var action = event.getParam('action');
        if(action.name === 'add_contacts'){
            cmp.set("v.isContactOpen", true);
            console.log('2');
        }
    },

    openModel: function(component, event, helper) {
        component.set("v.isOpen", true);
    },
   
    closeModel: function(component, event, helper) {
        component.set("v.isOpen", false);
    },

    openContactModel: function(component, event, helper) {
        component.set("v.isContactOpen", true);
    },
   
    closeContactModel: function(component, event, helper) {
        component.set("v.isContactOpen", false);
    },

    //弹出模态框展示客户联系人信息
    handleRowAction: function (cmp, event, helper) {
        var row = event.getParam('row');  
        cmp.set("v.isOpen", true);
        cmp.set('v.contactsColumns', [
            {label: '联系人姓名', fieldName: 'Name', type: 'text'},
            {label: '联系人电话', fielddName: 'Phone', type: 'Phone'},
            {label: '职位', fieldName: 'Title', type: 'text'}
        ]);
        helper.viewContacts(row, cmp);
    },

    //添加客户联系人事件
    handleClick : function(cmp, event, helper){
        var accountId = cmp.get('v.accountId');
        var lastName = cmp.get('v.lastName');
        var firdtName = cmp.get('v.firstName');
        var contactPhone = cmp.get('v.contactPhone');
        var contactTitle = cmp.get('v.contactTitle');
        if(contactLastName != null){
            helper.addContact(cmp);
        }
        else{
            alter('请输入联系人的姓名');
        }
    }
});
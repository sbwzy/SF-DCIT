({
    doInit: function (cmp, event, helper) {
       cmp.set('v.columns', [
            {label: '客户编号', fieldName: 'AccountNumber', type: 'text'},
            {label: '客户名称', fieldName: 'URL', type: 'url', typeAttributes: {label: {fieldName: 'Name'}, target: '_blank', tooltip: '点击查看客户详细信息'}},
            {label: '客户来源', fieldName: 'AccountSource', type: 'text'},
            {label: '查看联系人', type: 'button', onclick: "{! c.openModel }", initialWidth: 280, typeAttributes:{label: '查看联系人列表', name: 'view_contacts', title: '点击查看联系人列表'}}
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
        // for Display Model,set the "isOpen" attribute to "true"
        component.set("v.isOpen", true);
    },
   
    closeModel: function(component, event, helper) {
        // for Hide/Close Model,set the "isOpen" attribute to "Fasle"  
        component.set("v.isOpen", false);
    },
   
    likenClose: function(component, event, helper) {
        // Display alert message on the click on the "Like and Close" button from Model Footer 
        // and set set the "isOpen" attribute to "False for close the model Box.
        alert('thanks for like Us :)');
        component.set("v.isOpen", false);
    }
});
({
    doInit: function (cmp, event, helper) {
       cmp.set('v.columns', [
            {label: '客户编号', fieldName: 'AccountNumber', type: 'text'},
            {label: '客户名称', fieldName: 'Name', type: 'url', typeAttributes: {label: {fieldName: 'Id'}, target: '_blank', tooltip: '点击查看客户详细信息'}},
            {label: '客户来源', fieldName: 'AccountSource', type: 'text'},
            {label: '查看联系人', fieldName: 'viewContacts', type: 'url', typeAttributes:{}}
        ]);

        helper.fetchData(cmp);
    },

    updateSelectedText: function (cmp, event) {
        var selectedRows = event.getParam('selectedRows');
        cmp.set('v.selectedRowsCount', selectedRows.length);
    }
});
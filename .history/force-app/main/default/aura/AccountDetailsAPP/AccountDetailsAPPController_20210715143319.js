({
    doInit: function (cmp, event, helper) {
        // var fetchData = {
        //     accountNumber: "AccountNumber",
        //     accountName: "Name",
        //     accountSource: "AccountSource",
        //     viewContacts: "ViewContacts",
        // };


        cmp.set('v.columns', [
            {label: '客户编号', fieldName: 'accountNumber', type: 'text'},
            {label: '客户名称', fieldName: 'accountName', type: 'url'},
            {label: '客户来源', fieldName: 'accountSource', type: 'text'},
            {label: '查看联系人', fieldName: 'viewContacts', type: 'url'}
        ]);

        helper.fetchData(cmp);
    },

    updateSelectedText: function (cmp, event) {
        var selectedRows = event.getParam('selectedRows');
        cmp.set('v.selectedRowsCount', selectedRows.length);
    }
});
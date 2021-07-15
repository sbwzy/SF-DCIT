({
    init: function (cmp, event, helper) {
        var fetchData = {
            accountNumber: "AccountNumber",
            accountName: "Name",
            accountSource: "AccountSource",
            viewContacts: "ViewContacts",
        };


        cmp.set('v.columns', [
            {label: '客户编号', fieldName: 'accountNumber', type: 'text'},
            {label: '客户名称', fieldName: 'accountName', type: 'url'},
            {label: 'Opportunity name', fieldName: 'opportunityName', type: 'text'},
            {label: 'Account name', fieldName: 'accountName', type: 'text'},
            {
                label: 'Close date',
                fieldName: 'closeDate',
                type: 'date',
                typeAttributes: {
                    weekday: 'short',
                    year: 'numeric',
                    month: 'short',
                    day: 'numeric',
                    hour: '2-digit',
                    minute: '2-digit'
                }
            },
            {label: 'Confidence', fieldName: 'confidence', type: 'percent'},
            {label: 'Amount', fieldName: 'amount', type: 'currency', typeAttributes: { currencyCode: 'EUR'}},
            {label: 'Contact Email', fieldName: 'contact', type: 'email'},
            {label: 'Contact Phone', fieldName: 'phone', type: 'phone'},
            {label: 'Website', fieldName: 'website', type: 'url', typeAttributes: { target: '_parent'}},
            {label: 'Address', fieldName: 'address', type: 'location'}
        ]);

        helper.fetchData(cmp, fetchData, 100);
    },

    updateSelectedText: function (cmp, event) {
        var selectedRows = event.getParam('selectedRows');
        cmp.set('v.selectedRowsCount', selectedRows.length);
    }
});
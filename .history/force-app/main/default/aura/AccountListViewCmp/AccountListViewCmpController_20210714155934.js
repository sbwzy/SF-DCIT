({
    handleChange : function(component, event, helper) {
        var accountList = component.get('v.accountList');
        if (accountName != null){
            helper.showAccount();
        }
    }
})
({
    handleChange : function(component, event, helper) {
        var accountList = component.get('v.accountList');
        if (accountList != null){
            helper.showAccount();
        }
    }
})
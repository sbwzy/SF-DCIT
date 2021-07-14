({
    handleChange : function(component, event, helper) {
        var accountName = component.get(v.accountList);
        if (accountName != null){
            helper.showAccount()
        }
    }
})
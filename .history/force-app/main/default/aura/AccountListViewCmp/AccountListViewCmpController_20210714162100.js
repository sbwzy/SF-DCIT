({
    handleChange : function(component, event, helper) {
        var accountId = component.get('v.accountId');
        var handleChange = event.LoadAllContact(accountId);
        alter(handleChange);
    }
})
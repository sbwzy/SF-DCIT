({
    handleChange : function(component, event, helper) {
        var accountId = component.getParam('v.accountId');
        var handleChange = event.LoadAllContact(accountId);
        alter(handleChange);
    }
})
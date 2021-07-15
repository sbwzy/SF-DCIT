({
    handleChange : function(component, event, helper) {
        var changeValue = component.getParam('v.accountId');
        alter(changeValue);
    }
})
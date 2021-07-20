({
    handleChange : function(component, event, helper) {
        var changeValue = component.getParam('v.accountId');
        alter(changeValue);
        if(component.get('v.accountId') != null || component.get('v.accountId') == ''){
            accountId = component.get('v.accountId');
            helper.showAccount();
        }else{
            alter('未选中ID');
        }
    }
})
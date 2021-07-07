({
    handleClick : function(component, event, helper){
        var accountName = component.get('v.accountName');
        console.log('accountName=====>' + accountName);
        helper.saveAccount(component);
    }
})
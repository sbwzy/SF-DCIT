({
    handleClick : function(component, event, helper){
        var accountName = component.get('v.accountName');
        if(accountName != null){
            console.log('accountName=====>' + accountName);
            helper.saveAccount(component);
        }
        else{
            alert('请输入一个值');
        }
    }      
})
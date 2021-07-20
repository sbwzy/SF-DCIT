({
    handleChange : function(component, event, helper) {
        console.log('4');
        var accountId;
        if(component.get('v.accountId') != null || component.get('v.accountId') == ''){
            accountId = component.get('v.accountId');
            console.log('5');
            helper.showContact(component);
            console.log('6');
        }else{
            alert('没有获取到客户ID');
        }
    }
})
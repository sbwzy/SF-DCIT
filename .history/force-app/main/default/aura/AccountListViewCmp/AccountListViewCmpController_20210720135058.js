({
    handleChange : function(component, event, helper) {
        var accountId;
        if(component.get('v.accountId') != null || component.get('v.accountId') == ''){
            accountId = component.get('v.accountId');
            console.log('您选中的客户ID为: ' + accountId);
            helper.click(component);
        }else{
            alert('没有获取到客户ID');
        }
    }
})
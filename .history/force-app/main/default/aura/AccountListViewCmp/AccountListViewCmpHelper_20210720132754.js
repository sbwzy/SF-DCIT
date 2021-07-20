({
    getAllAccount: function (component, event, helper) {
        var action = component.get("c.getAllAccounts");
        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var result = response.getReturnValue();
                console.log(JSON.stringify(response.getReturnValue()));
                component.set('v.accountList', result);
            } else if(state == "INCOMPLETE"){
                //do something
            }
            else if(state == "ERROR"){
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message){
                        console.log("Error message:" + errors[0].message);
                    }
                    else {
                        console.log("Unknow error");
                    }
                }
            }
        });
        $A.enqueueAction(action);
    },
    
    click : function(component) {
        var action = component.get("c.getAllContact");
        action.setParams({accountId: component.get("v.accountId")});
        // 2. 设置Apex函数执行完成后的功能
        action.setCallback(this, function (response) {
            // 得到Apex的结果状态
            var state = response.getState();

            if (state === "SUCCESS") {
                // 得到Apex的结果，结果可以是基本类型，也可以是sObject或集合类型等
                var result = response.getReturnValue();
                // console.log(JSON.stringify(response.getReturnValue()));
                component.set('v.contactList', result);

                var messageEvent = $A.get("e.c:returnContactList");
                messageEvent.setParam('contactList', result);
                messageEvent.fire();
            } else {
                // 错误处理
                // Do nothing
            }
        });
        // 3. 开始调用Apex函数
        $A.enqueueAction(action);
    }
})
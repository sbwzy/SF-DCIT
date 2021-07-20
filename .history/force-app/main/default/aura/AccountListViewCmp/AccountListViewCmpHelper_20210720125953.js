({
    getAllAccount: function (component, event, helper) {
        var action = component.get("c.getAllAccounts");
        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var result = response.getReturnValue();
                console.log(JSON.stringify(response.getReturnValue()));
                component.set('v.accountList', result);
            } else {
                // 错误处理
                // Do nothing
            }
        });
        // 3. 开始调用Apex函数
        $A.enqueueAction(action);
    },
    
    showAccount : function(component) {
        var action = component.get("c.getAllAccount");
        action.setParams({accountId: component.get("v.accountId")});

        action.setCallback(this, function (response){
            var state = response.getState();
            if (state == "SUCCESS"){
                var results = response.getReturnValue();
                component.set('v.accountList', results);
                
                var compEvent = component.getEvent('LoadAllAContactEvt');
                compEvent.fire();
            }
            else if(state == "INCOMPLETE"){
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
    }
})
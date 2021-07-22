({
    saveAccount : function(component) {
        var action = component.get("c.createAccount");
        action.setParams({accountName:component.get("v.accountName")});

        action.setCallback(this, function (response){
            var state = response.getState();
            if (state == "SUCCESS"){
                console.log("From Server:" + JSON.stringify(response.getReturnValue()));
                //触发事件，重新加载所有客户
                var compEvent = component.getEvent('LoadAllAccount');
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
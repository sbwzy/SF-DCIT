({
    showAccount : function(component) {
        var action = component.get("v.accountList");
        var handleChange = 

        action.setCallback(this, function (response){
            var state = response.getState();
            if (state == "SUCCESS"){
                console.log("From Server:" + JSON.stringify(response.getReturnValue()));

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
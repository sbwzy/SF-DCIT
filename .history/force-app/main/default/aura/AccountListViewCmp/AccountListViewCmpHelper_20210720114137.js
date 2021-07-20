({
    showAccount : function(component) {
        var action = component.get("v.accountList");
        

        action.setCallback(this, function (response){
            var state = response.getState();
            if (state == "SUCCESS"){

                var compEvent = component.getEvent('LoadAllAContactEvt');
                var results = response.getReturnValue();
                component.set('v.data', results);
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
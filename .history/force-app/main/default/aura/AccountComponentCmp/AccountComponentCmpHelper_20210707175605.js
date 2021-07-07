({
    initAccountList : function(component) {
        var action = component.get("c.getAllAccount");
        action.setCallback(this, function (response){
            var state = response.getState();
            if (state === "SUCCESS"){
                component.set('v.accountList', response.getReturnValue());
            }
            else if (state === "INCOMPLETE"){
                //代码桩
            }
            else if (state === "ERROR"){
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message){
                        console.log("Error message:" + errors[0].message);
                    }
                }else {
                    console.log("Unknow error");
                }
            }
        });
        $A.enqueueAction(action);
    }
})
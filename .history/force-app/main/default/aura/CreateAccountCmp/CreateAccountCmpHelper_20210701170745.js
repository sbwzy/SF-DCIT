({
    saveAccount : function(component) {
        var action = component.get("c.createAccount");
        action.setParams({accountName:component.get("v.accountName")});

        action.setCallback(this, function (response){
            var state = response.getState();
            if (state == "SUCCESS"){
                console.log("From Server:" + JSON.stringify(response.getReturnValue()));

                //var compEvent = component.getEvent('LoadAllAccount');
                //compEvent.fire();
            }
            else if(state == "INCOMPLETE"){
                //do something
            }
            else if(state == "ERROR"){
                //do something
            }
        })
    }
})
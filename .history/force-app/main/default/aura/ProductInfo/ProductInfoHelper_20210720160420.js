({
    findProduct2 : function(component) {
	    // var action = component.get("c.findProductByName");
	    // var param = component.get('v.findProduct');
	    action.setParam('proName',param);
	    action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
            	console.log("From server: " + JSON.stringify(response.getReturnValue()) );
                component.set("v.proList", response.getReturnValue());
                
            }
            else if (state === "INCOMPLETE") {
                // do something
            }
            else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " +
                            errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
      });
        $A.enqueueAction(action); 
    
    },
     insertObj : function(component) {
        // var action = component.get("c.insertStatus");
        var param = component.get('v.proList');
        action.setParam('status',param);
        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var compEvent = component.getEvent("refreshEvent");
                compEvent.fire();
               
                
            }
            else if (state === "INCOMPLETE") {
                // do something
            }
            else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " +
                            errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
      });
        $A.enqueueAction(action); 
    
    },
    inserthelper : function(component) {
        // var action = component.get("c.insertAll");
        var param = component.get('v.proList');
        console.log(JSON.stringify(param));
        action.setParam('setStatus',param);
        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var compEvent = component.getEvent("refreshEvent");
                compEvent.fire();
               
                
            }
            else if (state === "INCOMPLETE") {
                // do something
            }
            else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
      });
        $A.enqueueAction(action);
    }
})
({    
    showContact : function(component) {
        console.log('a');
        var action = component.get("c.getAllContacts");
        action.setParams({accountId: component.get("v.accountId")});
        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                console.log("b");
                var result = response.getReturnValue();
                component.set('v.contactList', result);
                //利用EVEVT传出客户的联系人数据
                var messageEvent = $A.get("e.c:returnContactList");
                messageEvent.setParam('contactList', result);
                messageEvent.fire();
            } else {
                // Do nothing
            }
        });
        $A.enqueueAction(action);
    }
})
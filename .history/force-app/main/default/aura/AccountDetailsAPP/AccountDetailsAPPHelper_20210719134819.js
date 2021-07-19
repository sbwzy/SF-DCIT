({
    //展示所有客户
    fetchData: function (cmp,numberOfRecords) {       
        var action = cmp.get('c.getAllAccount');
        action.setCallback(this, function (response){
            var state = response.getState();
            if (state == "SUCCESS"){
                console.log(response.getReturnValue());
                //获取链接前的动态头
                let domain = window.location.host;
                var results = response.getReturnValue();
                results.forEach(ele=>{
                    ele.URL = domain+'/lightning/r/Account/' + ele.Id + '/view';
                });
                cmp.set('v.data', results);
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
    },

    //显示当前客户的联系人
    viewContacts: function (row, cmp){
        console.log('6');
        console.log(JSON.parse(JSON.stringify(row)).Id);//取到当前客户的ID
        var action = cmp.get('c.getAllContacts');
        action.setParam("accountId", JSON.parse(JSON.stringify(row)).Id);
        console.log('7');
        action.setCallback(this, function (response){
            var state = response.getState();
            console.log('8');
            if (state == "SUCCESS"){
                console.log(response.getReturnValue());
                var results = response.getReturnValue();
                cmp.set('v.contactData', results);
                console.log('9');
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

    //添加客户联系人响应事件
    addContact : function(cmp) {
        var action = cmp.get("c.addContact");
        action.setParam(accountName:cmp.get("v.accountName"), contactName:cmp.get("v.contactName"), contactPhone:cmp.get("v.contactPhone"), contactTitle:cmp.get("v.contactTitle")});

        action.setCallback(this, function (response){
            var state = response.getState();
            if (state == "SUCCESS"){
                console.log("From Server:" + JSON.stringify(response.getReturnValue()));

                var compEvent = component.getEvent('LoadAllContact');
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
    }，

    //弹出添加联系人模态框
    
});
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

    //客户名模糊搜索
    nameSearch: function(cmp){
        var action = cmp.get('c.nameSearch');
        console.log('333');
        action.setParams({'accName':cmp.get("v.accountNameSearch")});
        console.log('1111');
        console.log(cmp.get("v.accountNameSearch"));
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

    //客户来源模糊搜索
    sourceSearch: function(cmp){
        var action = cmp.get('c.sourceSearch');
        action.setParam({'accSource':cmp.get("v.accountSourceSearch")});
        console.log(cmp.get("v.accountSourceSearch"));
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
        console.log(JSON.parse(JSON.stringify(row)).Id);//取到当前客户的ID
        var action = cmp.get('c.getAllContacts');
        action.setParam("accountId", JSON.parse(JSON.stringify(row)).Id);
        action.setCallback(this, function (response){
            var state = response.getState();
            if (state == "SUCCESS"){
                console.log(response.getReturnValue());
                var results = response.getReturnValue();
                cmp.set('v.contactData', results);
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

    //添加客户联系人响应事件
    addContact : function(cmp) {
        console.log('11');
        var action = cmp.get("c.addContact");
        action.setParam({accountId:cmp.get("v.accountId"), firstName:cmp.get("v.firstName"), lastName:cmp.get("v.lastName"), contactPhone:cmp.get("v.contactPhone"), contactTitle:cmp.get("v.contactTitle")});
        console.log('1');
        action.setCallback(this, function (response){
            var state = response.getState();
            if (state == "SUCCESS"){
                console.log('2');
                console.log("From Server:" + JSON.stringify(response.getReturnValue()));

                var compEvent = cmp.getEvent('LoadAllContact');
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
});
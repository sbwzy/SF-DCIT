({
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

    viewContacts: function (row){
        var action = cmp.get('c.getAllContacts');
        console.log('1');
        console.log(row.Id);
        console.log('2');
        $A.enqueueAction(action);
    }
});
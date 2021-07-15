({
    fetchData: function (cmp,numberOfRecords) {       
        var action = cmp.get('c.getAllAccount');
        action.setCallback(this, function (response){
            var state = response.getState();
            if (state == "SUCCESS"){
                console.log(response.getReturnValue());
                let domain = window.location.host;
                var results = response.getReturnValue();
                results.forEach(ele=>{
                    ele.AccountUrl = domain+'/lightning/r/Account/' + ele.id + '/view';
                });
                var URL = 'https://decaicom3-dev-ed.lightning.force.com/lightning/r/Account/' + {results.id} + '/view';
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
    }
});
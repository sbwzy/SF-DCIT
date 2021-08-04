({
    /* doInitHelper funcation to fetch all records, and set attributes value on cmp load */
    doInitHelper : function(cmp,event){ 
        var action = cmp.get("c.fetchAccountWrapper");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS"){
                var oRes = response.getReturnValue();
                if(oRes.length > 0){
                    cmp.set('v.listOfAllAccounts', oRes);
                    var pageSize = cmp.get("v.pageSize");
                    var totalRecordsList = oRes;
                    var totalLength = totalRecordsList.length ;
                    cmp.set("v.totalRecordsCount", totalLength);
                    cmp.set("v.startPage",0);
                    cmp.set("v.endPage",pageSize-1);
                    
                    var PaginationLst = [];
                    for(var i=0; i < pageSize; i++){
                        if(cmp.get("v.listOfAllAccounts").length > i){
                            PaginationLst.push(oRes[i]);    
                        } 
                    }
                    cmp.set('v.PaginationList', PaginationLst);
                    cmp.set("v.selectedCount" , 0);
                    //use Math.ceil() to Round a number upward to its nearest integer
                    cmp.set("v.totalPagesCount", Math.ceil(totalLength / pageSize));    
                }else{
                    // if there is no records then display message
                    cmp.set("v.bNoRecordsFound" , true);
                } 
            }
            else{
                alert('Error...');
            }
        });
        $A.enqueueAction(action);  
    },
    // navigate to next pagination record set   
    next : function(cmp,event,sObjectList,end,start,pageSize){
        var Paginationlist = [];
        var counter = 0;
        for(var i = end + 1; i < end + pageSize + 1; i++){
            if(sObjectList.length > i){ 
                if(cmp.find("selectAllId").get("v.value")){
                    Paginationlist.push(sObjectList[i]);
                }else{
                    Paginationlist.push(sObjectList[i]);  
                }
            }
            counter ++ ;
        }
        start = start + counter;
        end = end + counter;
        cmp.set("v.startPage",start);
        cmp.set("v.endPage",end);
        cmp.set('v.PaginationList', Paginationlist);
    },
   // navigate to previous pagination record set   
    previous : function(cmp,event,sObjectList,end,start,pageSize){
        var Paginationlist = [];
        var counter = 0;
        for(var i= start-pageSize; i < start ; i++){
            if(i > -1){
                if(cmp.find("selectAllId").get("v.value")){
                    Paginationlist.push(sObjectList[i]);
                }else{
                    Paginationlist.push(sObjectList[i]); 
                }
                counter ++;
            }else{
                start++;
            }
        }
        start = start - counter;
        end = end - counter;
        cmp.set("v.startPage",start);
        cmp.set("v.endPage",end);
        cmp.set('v.PaginationList', Paginationlist);
    },
})

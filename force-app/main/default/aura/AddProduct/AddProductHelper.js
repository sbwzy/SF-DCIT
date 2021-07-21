 ({
    // 初始化
    onLoad: function (cmp) {
        var action = cmp.get("c.getAllPricebookEntry");
        action.setParams({defaultId: cmp.get('v.defaultId')});
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var result = response.getReturnValue();
                cmp.set('v.data', result);
                console.log(result);
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

    // 加载产品
    onLoadPricebook2: function (cmp) {
        var action = cmp.get("c.getPricebook2s");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var result = response.getReturnValue();
                cmp.set('v.Pricebook2List', result);
                console.log(result);
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

    // 搜索产品
    searchProduct: function (cmp) {
        var action = cmp.get('c.searchProduct');
        action.setParams({condition: cmp.get('v.condition'), BookId: cmp.get('v.BookId')});
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var result = response.getReturnValue();
                console.log(result);
                if (result.length === 0){
                    cmp.set('v.isBookNULL', true);
                    cmp.set('v.condition', null);
                    return 0;
                }
                cmp.set('v.data', []);
                cmp.set('v.data', result);
                console.log('查询结果: ');
                console.log(result);
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

    // 新建产品
    insertProduct: function (cmp) {
        var action = cmp.get('c.insertProduct');
        action.setParams({opportunityLineItems: cmp.get('v.opportunityLineItems')});
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                cmp.set("v.isOpen", true);
                cmp.set('v.productList', []);
                this.onLoad(cmp);
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

    // 选择产品
    selectBook: function (cmp) {
        var action = cmp.get("c.selectPricebook2s");
        action.setParams({BookId: cmp.get('v.BookId')});
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var result = response.getReturnValue();
                cmp.set('v.data', result);
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
});
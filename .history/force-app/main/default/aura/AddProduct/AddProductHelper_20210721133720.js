 ({
    // 初始化页面并加载价格手册
    loadPrice: function (cmp) {
        var action = cmp.get("c.loadPriceBook");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var result = response.getReturnValue();
                cmp.set('v.data', result);
            }
            else if (state === "INCOMPLETE") {
                // 代码桩
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
    },

    // 搜索产品
    searchProduct: function (cmp) {
        var action = cmp.get('c.searchProduct');
        action.setParams({condition: cmp.get('v.condition')});
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
                // 代码桩
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
    },

    // 插入产品
    insertProduct: function (cmp) {
        var action = cmp.get('c.insertProduct');
        action.setParams({opportunityLineItems: cmp.get('v.opportunityLineItems')});
        console.log(cmp.get('v.opportunityLineItems'));
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                cmp.set("v.isOpen", true);
                cmp.set('v.productList', []);
                //重载页面
                this.loadPrice(cmp);
            }
            else if (state === "INCOMPLETE") {
                // 代码桩
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
});
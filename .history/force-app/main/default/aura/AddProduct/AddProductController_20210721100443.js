({
    // 初始化加载
    init: function (cmp, event, helper) {
        cmp.set('v.columns', [
            {label: 'Product Name', fieldName: 'ProductName', type: 'text'},
            {label: 'Product Code', fieldName: 'ProductCode', type: 'text'},
            {label: 'Description', fieldName: 'Description', type: 'text'},
            {label: 'Family', fieldName: 'Family', type: 'text'},
        ]);

        cmp.set('v.columnsChoose', [
            {label: 'Product Name', fieldName: 'ProductName', type: 'text', editable: true},
            {label: 'Quantity', fieldName: 'Quantity', type: 'text', editable: true},
            {label: 'SalesPrice', fieldName: 'SalesPrice', type: 'text',  editable: true},
            {
                label: '删除',
                type: 'button',
                initialWidth: 135,
                initialHeight: 100,
                iconName: "utility:delete",
                variant: "base",
                typeAttributes: {label: '删除', name: 'view_details', title: 'del'}
            }
        ]);

        console.log('子组件: ' + cmp.get('v.recordId'));
        helper.onLoad(cmp);
        helper.onLoadPricebook2(cmp);
    },

    // 搜索产品
    search1: function (cmp, event, helper) {
        helper.searchProduct(cmp);
    },

    // 选中产品
    getSelect: function (cmp, event, helper) {
        const selectedRows = event.getParam('selectedRows');
        const productList = cmp.get('v.productList');
        productList.push(selectedRows[0]);
        cmp.set('v.productList', productList);
        cmp.set('v.onSelect', []);

        // 全部产品
        let myArray = [];
        myArray = cmp.get('v.data');

        let index;
        for (let i = 0; i < myArray.length; i++) {
            if (myArray[i].PID === selectedRows[0].PID) {
                index = i;
            }
        }
        // 删除选择的产品
        myArray.splice(index, 1);
        cmp.set('v.data', myArray);
    },

    // 保存产品
    saveProduct: function (cmp, event, helper) {
        let productList = cmp.get('v.productList')
        let Id = cmp.get('v.recordId');
        let ll = productList.length;
        if (ll===0){
            cmp.set('v.isBookNULL', true);
            return 0;
        }
        const opportunityLineItems = [];
        for (let i = 0; i < ll; i++) {
            if (productList[i].Quantity == null || productList[i].Quantity === ''){
                cmp.set("v.isError", true);
                return 0;
            }else {
                let opportunityLineItem = {};
                opportunityLineItem.UnitPrice = productList[i].SalesPrice;
                opportunityLineItem.Product2Id = productList[i].PID;
                opportunityLineItem.Quantity = productList[i].Quantity;
                opportunityLineItem.OpportunityId = Id;
                opportunityLineItems.push(opportunityLineItem);
            }
        }
        cmp.set('v.opportunityLineItems', opportunityLineItems);
        helper.insertProduct(cmp);
    },

    //关闭模态框
    closeModel: function (component, event, helper) {
        component.set("v.isOpen", false);
        component.set("v.isError", false);
        component.set("v.isBook", false);
        component.set('v.isBookNULL', false);
    },

    searchBook: function (cmp, event, helper) {
        cmp.set("v.isBook", true);
    },

    // 产出产品
    delProduct: function (cmp, event, helper) {
        const index = event.getSource().get('v.name');
        console.log(index);
        const productList = cmp.get('v.productList');
        const myArray = cmp.get('v.data');
        myArray.push(productList[index]);
        cmp.set('v.data', myArray);
        productList.splice(index, 1);
        cmp.set('v.productList', productList);
    },

    // 切换价格手册
    changeBook: function (cmp, event, helper){
        cmp.set('v.productList', []);
        helper.loadPrice(cmp);
    },
})
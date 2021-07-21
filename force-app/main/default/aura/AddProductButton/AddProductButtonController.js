({
    doInit: function (component) {
        const evt = $A.get("e.force:navigateToComponent");
        evt.setParams({
            componentDef: 'c:AddProduct',
            componentAttributes: {
                recordId: component.get('v.recordId')
            }
        });
        evt.fire();
    }
})
({
    retrieval : function(component, event, helper) {
      helper.findProduct2(component);
    },
     
   onCheck1: function(component, event, helper) {
      var bool=component.get('v.myBool');
      if (bool === true) {
      var proList=component.get('v.proList');
      for (var i = proList.length - 1; i >= 0; i--) {
         proList[i].myBool__c=true;
      }
      component.set('v.proList',list );
      }
      if (bool === false) {
         var list=component.get('v.proList');
         for (var i = list.length - 1; i >= 0; i--) {
         list[i].myBool__c=false;
         }
         component.set('v.proList',list );
      }
      helper.inserthelper(component);

   },

   onCheck2: function(component, event, helper) {
      helper.insertObj(component);
   }
})
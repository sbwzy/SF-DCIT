({
    fetchData: function (cmp, fetchData, numberOfRecords) {
        var dataPromise = component.get("c.getAllAccount");
        dataPromise.then(function(results) {
            cmp.set('v.data', results);
        });
    }
});
({
    fetchData: function (cmp, fetchData, numberOfRecords) {
        var dataPromise,
            latitude,
            longitude,
            fakerLib = this.mockdataLibrary.getFakerLib();

        fetchData.address = {type : function () {
            return {
                latitude : fakerLib.address.latitude(),
                longitude : fakerLib.address.longitude()
            };
        }};

        fetchData.confidence =  { type : function () {
            return Math.random(100);
        }};

        dataPromise = component.get("c.createAccount");
        dataPromise.then(function(results) {
            cmp.set('v.data', results);
        });
    }
});
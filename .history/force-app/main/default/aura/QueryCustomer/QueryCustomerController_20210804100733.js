({
    doInit: function(cmp, event, helper) {
        helper.doInitHelper(cmp, event);
    },
 
    /* javaScript function for pagination */
    navigation: function(cmp, event, helper) {
        var sObjectList = cmp.get("v.listOfAllAccounts");
        var end = cmp.get("v.endPage");
        var start = cmp.get("v.startPage");
        var pageSize = cmp.get("v.pageSize");
        var whichBtn = event.getSource().get("v.name");
        // check if whichBtn value is 'next' then call 'next' helper method
        if (whichBtn === 'next') {
            cmp.set("v.currentPage", cmp.get("v.currentPage") + 1);
            helper.next(cmp, event, sObjectList, end, start, pageSize);
        }
        // check if whichBtn value is 'previous' then call 'previous' helper method
        else if (whichBtn === 'previous') {
            cmp.set("v.currentPage", cmp.get("v.currentPage") - 1);
            helper.previous(cmp, event, sObjectList, end, start, pageSize);
        }
    },
 
    selectAllCheckbox: function(cmp, event, helper) {
        var selectedHeaderCheck = event.getSource().get("v.value");
        var updatedAllRecords = [];
        var updatedPaginationList = [];
        var listOfAllAccounts = cmp.get("v.listOfAllAccounts");
        var PaginationList = cmp.get("v.PaginationList");
        // play a for loop on all records list 
        for (var i = 0; i < listOfAllAccounts.length; i++) {
            // check if header checkbox is 'true' then update all checkbox with true and update selected records count
            // else update all records with false and set selectedCount with 0  
            if (selectedHeaderCheck === true) {
                listOfAllAccounts[i].isChecked = true;
                cmp.set("v.selectedCount", listOfAllAccounts.length);
            } else {
                listOfAllAccounts[i].isChecked = false;
                cmp.set("v.selectedCount", 0);
            }
            updatedAllRecords.push(listOfAllAccounts[i]);
        }
        // update the checkbox for 'PaginationList' based on header checbox 
        for (var i = 0; i < PaginationList.length; i++) {
            if (selectedHeaderCheck === true) {
                PaginationList[i].isChecked = true;
            } else {
                PaginationList[i].isChecked = false;
            }
            updatedPaginationList.push(PaginationList[i]);
        }
        cmp.set("v.listOfAllAccounts", updatedAllRecords);
        cmp.set("v.PaginationList", updatedPaginationList);
    },
 
    checkboxSelect: function(cmp, event, helper) {
        // on each checkbox selection update the selected record count 
        var selectedRec = event.getSource().get("v.value");
        var getSelectedNumber = cmp.get("v.selectedCount");
        if (selectedRec === true) {
            getSelectedNumber++;
        } else {
            getSelectedNumber--;
            cmp.find("selectAllId").set("v.value", false);
        }
        cmp.set("v.selectedCount", getSelectedNumber);
        // if all checkboxes are checked then set header checkbox with true   
        if (getSelectedNumber === cmp.get("v.totalRecordsCount")) {
            cmp.find("selectAllId").set("v.value", true);
        }
    },
 
    getSelectedRecords: function(cmp, event, helper) {
        var allRecords = cmp.get("v.listOfAllAccounts");
        var selectedRecords = [];
        for (var i = 0; i < allRecords.length; i++) {
            if (allRecords[i].isChecked) {
                selectedRecords.push(allRecords[i].objAccount);
            }
        }
        alert(JSON.stringify(selectedRecords));
    }
})

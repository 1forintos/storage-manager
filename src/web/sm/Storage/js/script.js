$(document).ready(function() {	
	var tableToFill = $('#table-stored_items').DataTable({
        "columnDefs": [ {
            "targets": -2,
            "data": null,
            "defaultContent": '<button class="button-edit btn btn-default glyphicon glyphicon-pencil" data-toggle="modal" data-target="#popup-edit"></button>'
        }, {
            "targets": -1,
            "data": null,
            "defaultContent": '<button class="button-remove btn btn-default glyphicon glyphicon-remove"></button>'
        }
    ]});

	selectedStoredItemId = null;
    $('#table-stored_items tbody').on( 'click', '.button-edit', function () {
        var data = tableToFill.row( $(this).parents('tr') ).data();
        $('#text-name').text(data[2]);
        $('#text-quantity_unit').text(data[4]);
        $('#input-quantity').val(data[3]);
        selectedStoredItemId = data[0];
    });
    $('#table-stored_items tbody').on( 'click', '.button-remove', function () {
        var data = tableToFill.row( $(this).parents('tr') ).data();        
        removeStoredItem(data[0]);
    } );
    $('#table-stored_items tbody').on( 'click', '.button-remove', function () {
        var data = tableToFill.row( $(this).parents('tr') ).data();
    } );
    $('#popup-button-save').click(function() {
    	submitChanges();
    });

	fillTable(tableToFill, 'stored_items');
});

function removeStoredItem(storedItemId) {
	$.ajax({
		type: "POST",
		url: "/sm/db/db_methods.php",
		data: {
			method: "deleteStoredItem",
			data: storedItemId
		},
		success: function(result) {
			console.log(result);
			if(result.indexOf("success") > -1) {
				alert("Success!");
				location.reload();
			} else {
				var resultObj = $.parseJSON(result);
				if('error' in resultObj) {
					alert("Failed to remove item: " + resultObj.error);
				} else {
					console.log("What the heck happened??");
				}
			} 
		}
	});
}

function submitChanges() {	
	var itemQuantity = $('#input-quantity').val().trim();
		
	if(itemQuantity == null || itemQuantity == '') {
		$('#input-quantity').addClass("danger");
		alert("Quantity has to be 0 or a positive number.");
		return;
	} else {
		$('#input-quantity').removeClass("danger");
	}
		
	var itemData = {};
	itemData.storedItemId = selectedStoredItemId;
	itemData.quantity = itemQuantity	

	$.ajax({
		type: "POST",
		url: "/sm/db/db_methods.php",
		data: {
			method: "updateStoredItem",
			data: itemData
		},
		success: function(result) {
			console.log(result);
			if(result.indexOf("success") > -1) {
				alert("Success!");
				location.reload();
			} else {
				var resultObj = $.parseJSON(result);
				if('error' in resultObj) {
					alert("Failed to submit item changes: " + resultObj.error);
				} else {
					console.log("What the heck happened??");
				}
			} 
		}
	});
}

function fillTable(tableToFill, dataType) {
	tableToFill.clear();
	$.ajax({
		type: "POST",
		url: "/sm/db/db_methods.php",
		data: {
			method: "loadTableData",
			data: dataType
		},
		success: function(data) {
			var results = $.parseJSON(data);
			if('status' in results) {
				if(results.status == "success") {
					for(var i in results.data) {
						addRowToTable(tableToFill, results.data[i]);
					}
				}
			}
		}
	});
}


function addRowToTable(table, rowData) {	
	var dataArray = [];
	for(var key in rowData) {
		dataArray.push(rowData[key]);	
	}	
	table.row.add(dataArray).draw().node();
}

function submitItemType() {
	var itemName = $('#input-name').val().trim();
	var itemNotes = $('#input-notes').val().trim();
	var itemQuantityUnit = $('#input-quantity_unit').val().trim();
	var inputsOk = true;
	if(itemName == null || itemName == '') {
		$('#input-name').addClass("danger");
		inputsOk = false;
	} else {
		$('#input-name').removeClass("danger");
	}	
	if(itemQuantityUnit == null || itemQuantityUnit == '') {
		$('#input-quantity_unit').addClass("danger");
		inputsOk = false;
	} else {
		$('#input-quantity_unit').removeClass("danger");
	}
	if(!inputsOk) {
		alert("Both Name and Quantity Unit of the item have to be provided.");
		return;
	}
	
	var itemData = {};
	itemData.name = itemName;
	itemData.notes = itemNotes;
	itemData.quantityUnit = itemQuantityUnit;	

	$.ajax({
		type: "POST",
		url: "/sm/db/db_methods.php",
		data: {
			method: "insertItemType",
			data: itemData
		},
		success: function(result) {
			if(result.indexOf("success") > -1) {
				alert("Success!");
				location.reload();
			} else {
				var resultObj = $.parseJSON(result);
				if('error' in resultObj) {
					alert("Failed to submit item type: " + resultObj.error);
				} else {
					console.log("What the heck happened??");
				}
			} 
		}
	});
}
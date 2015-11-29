$(document).ready(function() {	
	newItemsCounter = 0;

  	$('#button-add-item_type').button();
  	$('#button-add-item_type').click(function() {
  		addNewItemType();
  	});

  	$('.button-remove').button();
  	$('.button-remove').click(function() {
  		alert("yay");
  	});

	loadItemTypes();
});

function addNewItemType() {
	newItemsCounter++;
	var clone = $('.input-container-item_type').last().clone();
	clone.appendTo($('#itemTypes-input-container'));
	clone.attr("id", "intput-item_type-" + newItemsCounter);
	clone.find('.bootstrap-select').remove();
	clone.find('select').selectpicker();
	clone.selectpicker({
	    style: 'btn-default',
	    size: "4"
  	});
	clone.change(function () {
	    $(this).val($(this).val());
		$(this).selectpicker('refresh')
	});
	clone.find('.button-remove').click(function() {
  		$(this).parent().parent().remove();
  	});
	clone.show();
}

function loadItemTypes() {
	$.ajax({
		type: "POST",
		url: "/sm/db/db_methods.php",
		data: {
			method: "loadItemTypes"
		},
		success: function(results) {
			rows = jQuery.parseJSON(results);
			itemTypesSelect = $('.select-item_type');
			for(var i in rows) {
				newOption = document.createElement("option");				
				newOption.innerHTML = rows[i].name;
				newOption.setAttribute("value", rows[i].item_type_id);
				newOption.setAttribute("quantity_unit", rows[i].quantity_unit);
				itemTypesSelect.append(newOption);
				itemTypesSelect.selectpicker('refresh');	
			}		
		}
	});
}
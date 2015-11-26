$(document).ready(function() {
		
});

function logout() {
   $.ajax({
		type: "POST",
		url: "main.php",
		data: {value: "logout"}	
	});
}
$(document).ready(function() {
	
});

function navigateHome() {
	$.ajax({
		type: "POST",
		url: "/sm/header/server_script.php",
		data: {
			value: "navigate",
			where: "home"
		},
		success: function(url) {
			window.location.href = url;
		}
	});
}

function logout() {
   $.ajax({
		type: "POST",
		url: "/sm/header/server_script.php",
		data: {value: "logout"}	
	});
}
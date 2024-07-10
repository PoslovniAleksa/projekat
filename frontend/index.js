document.addEventListener("DOMContentLoaded", function() {
		for (let i = 0; i < 30; i++) {
			document.getElementById("content").innerHTML += "News info " + (i+1) + " .";
			document.getElementById("content").innerHTML += "<br>";
		}
});


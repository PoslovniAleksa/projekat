document.addEventListener("DOMContentLoaded", function() {
		
	let text = '{"article" : "good article"}';
	let obj = JSON.parse(text);
	loadContent(obj);
	
	var search_bar = document.getElementById("search");
	search_bar.addEventListener('keydown', function(event) {
		if (event.key === 'Enter') {
			alert(search_bar.value);
		}
	});
});

function loadContent(obj) {
	for (let i = 0; i < 30; i++) {
		var entry = document.createElement('li');
		
		var title = document.createElement('div');
			var titleText = document.createElement('span');
			titleText.className = "titleText";
			titleText.appendChild(document.createTextNode(obj.article + " ."));
			titleText.setAttribute("link", (i+1) + obj.article);
			title.appendChild(titleText);
			
			titleText.addEventListener('click', (function(currentI) {
				return function() {
					alert(this.getAttribute("link"));
				};
			})(i));
		entry.appendChild(title);
		
		var info = document.createElement('div');
			var infoText = document.createElement('span');
			infoText.appendChild(document.createTextNode("info"));
			infoText.style.color = "gray";
			infoText.style.fontSize = "12px";

		info.appendChild(infoText);
		entry.appendChild(info);
		
		document.getElementById("content").appendChild(entry);
	
	}
}

function loadNext () {
	alert("works");
}

document.addEventListener("DOMContentLoaded", async function() {
		
	const apiResponse = await fetch('http://localhost:8000/news'); //http GET 
    const data = await apiResponse.json();	
	
	//let text = '{"article" : "good article"}';
	//let obj = JSON.parse(data);
	loadContent(data);
	
	var search_bar = document.getElementById("search");
	search_bar.addEventListener('keydown', function(event) {
		if (event.key === 'Enter') {
			alert(search_bar.value);
		}
	});
});

function loadContent(obj) {
	for (let i = 0; i < obj.length; i++) {
		var entry = document.createElement('li');
		
		var title = document.createElement('div');
			var titleText = document.createElement('span');
			titleText.className = "titleText";
			titleText.appendChild(document.createTextNode(obj[i].name));
			//titleText.appendChild(document.createTextNode(" ("));
			titleText.setAttribute("link", (i+1) + obj[i].name);
			title.appendChild(titleText);
			
			titleText.addEventListener('click', (function(currentI) {
				return function() {
					alert(this.getAttribute("link"));
				};
			})(i));
		entry.appendChild(title);
		
		var info = document.createElement('div');
			var infoText = document.createElement('span');
			var timestamp = obj[i].date;
			infoText.appendChild(document.createTextNode("by " + obj[i].author + " " + calculateTimeAgo(timestamp)));
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

function calculateTimeAgo(timestamp) {
    const date = new Date(timestamp);
    const now = new Date();
    const timeDifference = now - date;
    
    // Calculate time difference in hours
    const hoursDifference = timeDifference / (1000 * 60 * 60);

    if (hoursDifference < 1) {
        // Calculate and return time difference in minutes
        const minutesDifference = Math.floor(timeDifference / (1000 * 60));
        return `${minutesDifference} minute${minutesDifference !== 1 ? 's' : ''} ago`;
    } else if (hoursDifference > 72) {
        // Calculate and return time difference in days
        const daysDifference = Math.floor(hoursDifference / 24);
        return `${daysDifference} day${daysDifference !== 1 ? 's' : ''} ago`;
    } else {
        // Return time difference in hours
        return `${Math.floor(hoursDifference)} hour${Math.floor(hoursDifference) !== 1 ? 's' : ''} ago`;
    }
}

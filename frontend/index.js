let page_start_idx = 1;
let page_number = 1;
let user_name = "";

export function changeUsername (new_username) {
	//document.getElementById("login").innerHTML = "Hello " + new_username;
	localStorage.setItem("username", new_username);
	//alert("new username " + user_name); 
}

export function getUsername () {
	return user_name;
}

function login(username, password) {
	const loginUrl = 'http://localhost:8000/login';  // Replace with your actual login endpoint
  
	// Form data to send in the POST request body
	const formData = new URLSearchParams();
	formData.append('username', username);
	formData.append('password', password);
	formData.append('grant_type', '');  // Adjust as needed based on your server requirements
	formData.append('scope', '');
	formData.append('client_id', '');
	formData.append('client_secret', '');
  
	const options = {
	  method: 'POST',
	  headers: {
		'Content-Type': 'application/x-www-form-urlencoded',
		'Accept': 'application/json'
	  },
	  body: formData
	};
  
	return fetch(loginUrl, options)
	  .then(response => {
		if (!response.ok) {
		  throw new Error(`HTTP error! Status: ${response.status}`);
		}
		return response.json();
	  })
	  .then(data => {
		// Assuming the response contains a token or user information
		console.log('Login successful:', data);
		// Handle successful login, e.g., store token in session storage
		sessionStorage.setItem('accessToken', data.access_token);
		// Optionally return data or perform other actions
		return data;
	  })
	  .catch(error => {
		console.error('Login failed:', error);
		// Handle fetch errors or server errors
		// Example: show error message to user or retry login
		throw error;  // Propagate the error for further handling if needed
	  });
  }
  

document.addEventListener("DOMContentLoaded", async function() {
	const apiResponse = await fetch('http://localhost:8000/news'); //http GET 
    const data = await apiResponse.json();	

	if(localStorage.getItem("username") != null && localStorage.getItem("username") != "") {
		document.getElementById("login-button").innerHTML = "Hello " + localStorage.getItem("username");
		document.getElementById("login-button").removeAttribute('href');
		var button = document.createElement("button");
		button.textContent = "Logout";
		document.getElementById("login").appendChild(button);
		
		button.addEventListener("click", function() {
			localStorage.setItem("username", "");
			localStorage.setItem("access_token", "");
			location.reload();
		});
	}
	loadContent(data);
	
	var search_bar = document.getElementById("search");
	search_bar.addEventListener('keydown', async function(event) {
		if (event.key === 'Enter') {
			clearContent();
			page_start_idx = 1;
			if (search_bar.value === "") {
				apiSearchResponse = await fetch('http://localhost:8000/news');
			} else {
				apiSearchResponse = await fetch('http://localhost:8000/search/' + search_bar.value);
			}
			
			searchData = await apiSearchResponse.json();
			loadContent(searchData);
		}
	});
	
	more_news_link.addEventListener('click', async function(){
		loadNext();
	});
});

function loadContent(obj) {
	for (let i = 0; i < obj.length; i++) {
		var entry = document.createElement('li');
		entry.setAttribute('value', page_start_idx);
		page_start_idx++;
		
		var title = document.createElement('div');
			var titleText = document.createElement('span');
			titleText.className = "titleText";
			titleText.appendChild(document.createTextNode(obj[i].name));
			titleText.setAttribute("link", obj[i].website_link);
			title.appendChild(titleText);
			
			titleText.addEventListener('click', (function(currentI) {
				return function() {
					window.location.href = this.getAttribute("link");
				};
			})(i));
		entry.appendChild(title);
		
		var info = document.createElement('div');
			var infoText = document.createElement('span');
			var timestamp = obj[i].date;
			var comments = document.createElement('a');
			comments.href = '#';
			localStorage.setItem("selectedNewsId" + i, obj[i].id);
			localStorage.setItem("selectedNewsTitle" + i, obj[i].name);
			localStorage.setItem("selectedNewsAuthor" + i, obj[i].author);
			localStorage.setItem("selectedNewsWeblink" + i, obj[i].website_link);
			//comments.setAttribute('href', "http://localhost:8080/index.html");
			comments.innerHTML = "comments";
			infoText.appendChild(document.createTextNode("by " + obj[i].author + " " + calculateTimeAgo(timestamp) + " | "));
			infoText.appendChild(comments);
			infoText.style.color = "gray";
			infoText.style.fontSize = "12px";
			comments.addEventListener('click', (function(currentI) {
				return function() {
					localStorage.setItem("selectedNewsId", localStorage.getItem("selectedNewsId" + i));
					localStorage.setItem("selectedNewsTitle", localStorage.getItem("selectedNewsTitle" + i));
					localStorage.setItem("selectedNewsAuthor", localStorage.getItem("selectedNewsAuthor" + i));
					localStorage.setItem("selectedNewsWeblink", localStorage.getItem("selectedNewsWeblink" + i));
					window.location.href = ("http://localhost:8080/comments.html");
				};
			})(i));

		info.appendChild(infoText);
		entry.appendChild(info);
		
		document.getElementById("content").appendChild(entry);
	
	}
}

async function loadNext () {
	clearContent();
	page_number++;
	let apiLoadResponse = await fetch('http://localhost:8000/news/?page=' + page_number);
	let loadData = await apiLoadResponse.json();
	loadContent(loadData);
}

function clearContent() {
	document.getElementById("content").innerHTML = "";
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

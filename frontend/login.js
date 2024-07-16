import { changeUsername, getUsername } from "./index.js"

document.addEventListener("DOMContentLoaded", async function() {
		
	const register_button = document.getElementById("register_button");
	const login_button = document.getElementById("login_button");

	
	login_button.addEventListener("click", async function() {
		event.preventDefault();
		let username = document.getElementById('login_username').value;
		let password = document.getElementById('login_password').value;
		
		const payload = new URLSearchParams({
            "grant_type": "",
            "username": username,
            "password": password,
            "scope": "",
            "client_id": "",
            "client_secret": ""
        });

        try {
            const response = await fetch('http://localhost:8000/login', {
                method: 'POST',
                headers: {
					'accept' : 'application/json',
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: payload.toString()  // Convert the payload to URL-encoded format
            });
			

            if (response.ok) {
                const responseData = await response.json();
				changeUsername(username);
				localStorage.setItem("access_token", responseData["access_token"]);
                document.location.href = 'http://localhost:8080/index.html';
                // Handle successful login here
            } else {
                const errorData = await response.json();
                alert('Login failed: ' + errorData.detail);
                // Handle login error here
            }
        } catch (error) {
            console.error('Error during login:', error);
            alert('An error occurred during login ' + error);
        }
    });
	

	register_button.addEventListener("click", async function(event) {
        event.preventDefault(); // Prevent form submission

        const username = document.getElementById('register_username').value;
        const password = document.getElementById('register_password').value;

        const payload = {
            username: username,
            password: password
        };

        try {
			console.log(JSON.stringify(payload));
            const response = await fetch('http://localhost:8000/register', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(payload)
            });
			

            if (response.ok) {
                const responseData = await response.json();
                alert('Registration successful! New id: ' + responseData["id"]);
                // Handle successful registration here
            } else {
                const errorData = await response.json();
				alert(errorData);
                alert('Registration failed: ' + errorData.message);
                // Handle registration error here
            }
        } catch (error) {
			alert(error);
            console.error('Error during registration:', error);
            alert('An error occurred during registration');
        }
    });
});

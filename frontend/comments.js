// Function to fetch comments from API
async function fetchComments() {

    const newsId = localStorage.getItem('selectedNewsId')
    const apiUrl = 'http://localhost:8000/comments/' + 1; // Replace with your actual API endpoint
  
    try {
      const response = await fetch(apiUrl);
      if (!response.ok) {
        throw new Error('Network response was not ok');
      }
      const comments = await response.json();
      return comments;
    } catch (error) {
      console.error('Error fetching comments:', error);
      return []; // Return an empty array or handle error as needed
    }
  }
  
  // Function to display comments on the webpage
  async function displayComments() {
    try {
      const comments = await fetchComments();
      const commentsList = document.getElementById('commentsList');
      commentsList.innerHTML = ''

      comments.forEach(comment => {
        const li = document.createElement('li');
        li.className = 'comment';
  
        const strong = document.createElement('strong');
        strong.textContent = comment.username + ': '; // Display username as strong text
  
        const p1 = document.createElement('p');
        p1.textContent = comment.comment_text; // Display comment text
  
        const p2 = document.createElement('p');
        const commentDate = new Date(comment.comment_date).toLocaleString(); // Format comment date
        p2.textContent = `Commented on: ${commentDate}`;
  
        li.appendChild(strong);
        li.appendChild(p1);
        li.appendChild(p2);
  
        commentsList.appendChild(li);
      });

      // Display selected post title
      const title = localStorage.getItem('selectedNewsTitle')
      const author = localStorage.getItem('selectedNewsAuthor')
      const weblink = localStorage.getItem('selectedNewsWeblink')
      
      const titleElement = document.getElementById('NewsTitle')
      const authorElement = document.getElementById('Author')
      const weblinkElement = document.getElementById('weblink')

      titleElement.textContent = title;
      authorElement.textContent = author;
      weblinkElement.textContent = weblink;

    } catch (error) {
      console.error('Error displaying comments:', error);
      // Handle error, e.g., display error message to user
    }
  }
  
  // Call displayComments function when the DOM content is loaded
  document.addEventListener('DOMContentLoaded', function() {
    displayComments();
  });
  
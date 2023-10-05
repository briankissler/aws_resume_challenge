// main.js
const counterElement = document.getElementById('visitCount');

// api url
const api_url = 'https://p8jjp250fi.execute-api.us-east-1.amazonaws.com/Test';



// Send a POST request to the API endpoint
function loadHITS() {

  fetch(api_url)
  .then((res) => res.json())
  .then((data) => {
      console.log(data['hitCount']);
      document.getElementById('visitCount').innerHTML = data['hitCount'];
  });
  
}

  
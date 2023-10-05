/*!
* Start Bootstrap - Resume v7.0.6 (https://startbootstrap.com/theme/resume)
* Copyright 2013-2023 Start Bootstrap
* Licensed under MIT (https://github.com/StartBootstrap/startbootstrap-resume/blob/master/LICENSE)
*/
//
// Scripts
// 

/* function isLocalStorageSupported(){
    if (typeof Storage !== "undefined")
      //local storage is supported
      return true;
    else{
      //local storage is not supported
      return false;
    }
  }
  
  function doesVariableExist(x){
    if (localStorage[x]) {
      return true;
    }else{
      return false;
    }
  }
  
  function createStorageVariable(x, value){
    localStorage[x] = valueå
    return localStorage[x]
  }
  
  if (isLocalStorageSupported){
    if(doesVariableExist('test')){
      localStorage.test = Number(localStorage.test) + 1
    }else{
      localStorage.test = 1
    }
    console.log(localStorage.test)
  }
  // localStorage.clear()
  if (typeof Storage !== "undefined") {
    //Local storage is supported
    if (localStorage.visitcount) {
      // variable exists for this site they've been here before so do things
      document.getElementById("visitCount1").innerHTML = localStorage.visitcount;

      localStorage.visitcount = Number(localStorage.visitcount) + 1; //update variable for existing users
    } else {
      // variable not found they haven't been here before
      localStorage.visitcount = 1; //set initial value of variable for this site and then do things for first time
      document.getElementById("visitCount1").innerHTML = 0;
    }
  } else {
    // their browser doesn't support local storage so let them know or just do nothing
    alert(
      "Sorry, your browser does not support web storage.  Changes will not be saved"
    );
    document.getElementById("visitCount1").innerHTML =
      "Sorry, your browser does not support web storage...";
  } */


/* function websiteVisits(response) {
    document.querySelector("#visits").textContent = 1000;
}
 */
window.addEventListener('DOMContentLoaded', event => {

    // Activate Bootstrap scrollspy on the main nav element
    const sideNav = document.body.querySelector('#sideNav');
    if (sideNav) {
        new bootstrap.ScrollSpy(document.body, {
            target: '#sideNav',
            rootMargin: '0px 0px -40%',
        });
    };

    // Collapse responsive navbar when toggler is visible
    const navbarToggler = document.body.querySelector('.navbar-toggler');
    const responsiveNavItems = [].slice.call(
        document.querySelectorAll('#navbarResponsive .nav-link')
    );
    responsiveNavItems.map(function (responsiveNavItem) {
        responsiveNavItem.addEventListener('click', () => {
            if (window.getComputedStyle(navbarToggler).display !== 'none') {
                navbarToggler.click();
            }
        });
    });

});

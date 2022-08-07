/* global $*/
$(document).on('turbolinks:load', function() {
console.log(1)
	$(function () {
    const buttons = document.querySelectorAll(".btn")
    for(const button of buttons) {
      button.addEventListener("click", function() {
        const currentDiv = button.closest("div");
        currentDiv.style.display = "none";
        const id = button.getAttribute("href");
        const nextDiv = document.querySelector(id);
        nextDiv.classList.add("fit");
    		nextDiv.style.display = "block";
		  })
		}
	});

  $(function() {
    $('.flash').fadeOut(3500);
  });

  $(function(){
    ScrollReveal().reveal('.box', {
      duration: 2000,
      scale: 4,
      reset: false
    });
  });
});
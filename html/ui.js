$(function() {
  window.addEventListener('message', function(event) {
       
    if (event.data.type == "openAll"){
      $('.general').css('display', 'block');
    } else if (event.data.type == "closeAll"){
      $('.general').css('display', 'none');
    }
  });

	document.onkeyup = function(data){
    if (data.which == 27){
        $.post('http://esx_job_center/closeAll', JSON.stringify({}));
    }
  }
});

var slideIndex = 1;
showSlides(slideIndex);

function plusSlides(n) {
  showSlides(slideIndex += n);
}

function currentSlide(n) {
  showSlides(slideIndex = n);
}

function showSlides(n) {
  var i;
  var slides = document.getElementsByClassName("mySlides");
  var dots = document.getElementsByClassName("dot");
  if (n > slides.length) {slideIndex = 1}    
  if (n < 1) {slideIndex = slides.length}
  for (i = 0; i < slides.length; i++) {
      slides[i].style.display = "none";  
  }
  for (i = 0; i < dots.length; i++) {
      dots[i].className = dots[i].className.replace(" active", "");
  }
  slides[slideIndex-1].style.display = "block";  
  dots[slideIndex-1].className += " active";
}

$('.slideshow-container').on('click', 'btn', function() {
  var type = $(this).attr('job');
  var label = $(this).attr('label');
  $.post('http://esx_job_center/setJob', JSON.stringify({
    job: type,
    label: label
  }));
})
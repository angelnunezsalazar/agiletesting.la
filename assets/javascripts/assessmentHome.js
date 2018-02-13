
$(document).ready(function() {
  // Smooth scrolling
  $(function() {
    $('a[href*="#"]:not([href="#"])').click(function() {
      if (location.pathname.replace(/^\//,'') == this.pathname.replace(/^\//,'') && location.hostname == this.hostname) {
        var target = $(this.hash);
        target = target.length ? target : $('[name=' + this.hash.slice(1) +']');

        if (target.length) {
          $('html, body').animate({scrollTop: target.offset().top}, 1000, 'easeInOutExpo');
          return false;
        }
      }
    });
  });

  //Scroll Top link
  $(window).scroll(function(){
    if ($(this).scrollTop() > 100) {
      $('.scrolltop').fadeIn();
    } else {
      $('.scrolltop').fadeOut();
    }
  });
  $('.scrolltop, #logo a').click(function(){
    $("html, body").animate({
      scrollTop: 0
    }, 1000, 'easeInOutExpo');
    return false;
  });

  //Analytics
  var analyticsIsEnabled= window.location.hostname!="localhost";
  if(analyticsIsEnabled)
  {
    window.dataLayer = window.dataLayer || [];
    function gtag(){dataLayer.push(arguments);}
    gtag('js', new Date());
    gtag('config', 'UA-11277405-2');

    $(document).ready(function () {
      gtag('event', '0. Ingresa al Home', {
        'event_category': 'Home Buttons'
      });

      $('#comienza-ahora').click(function (e) { 
        e.preventDefault();
        gtag('event', '1. Ir a Agile Testing (Comienza Ahora)', {
          'event_category': 'Home Buttons'
        });
      });
      $('#assessment-que-es').click(function (e) { 
        e.preventDefault();
        gtag('event', '2. Ir a Assessment Que Es', {
          'event_category': 'Home Buttons'
        });
      });
      $('#evalua-tu-madurez').click(function (e) { 
        e.preventDefault();
        gtag('event', '3. Ir a Formulario Inicio', {
          'event_category': 'Home Buttons'
        });
      });
    });
  }

  //Form Validation
  $("#assessment-form" ).validate( {
    errorElement: "small",
    errorPlacement: function ( error, element ) {
      error.addClass( "form-text" );
      error.insertAfter( element );
    },
    highlight: function ( element, errorClass, validClass ) {
      $( element ).parents( ".form-group" ).addClass( "has-error" ).removeClass( "has-success" );
    },
    unhighlight: function (element, errorClass, validClass) {
      $( element ).parents( ".form-group" ).addClass( "has-success" ).removeClass( "has-error" );
    },
    submitHandler: function (form) {
      if(analyticsIsEnabled){
        gtag('event', '4. Comenzar Assessment', {
          'event_category': 'Home Buttons'
        });
      }
      form.submit();
    }
  });
});

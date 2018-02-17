var SmoothScrolling = function () {

  function enableForAllLinks() {
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
  };

  return {
    enableForAllLinks: enableForAllLinks,
  }
};

var ScrollToTopLink = function (linkElement) {

  function enable() {
    onClick();
    fadeOnTop();
  };

  function onClick(){
    $(linkElement).click(function(){
      $("html, body").animate({
        scrollTop: 0
      }, 1000, 'easeInOutExpo');
      return false;
    });
  }

  function fadeOnTop(){
    $(window).scroll(function(){
      if ($(this).scrollTop() > 100) {
        $(linkElement).fadeIn();
      } else {
        $(linkElement).fadeOut();
      }
    });
  }
  return {
    enable: enable,
  }
};

var Analytics = function () {  

  var analyticsIsEnabled = window.location.hostname!="localhost";
  configure();

  function configure () {  
    if(analyticsIsEnabled){
      window.dataLayer = window.dataLayer || [];
      function gtag(){dataLayer.push(arguments);}
      gtag('js', new Date());
      gtag('config', 'UA-11277405-2');
    }
  }

  function addEventOnClick(element,action,category) {
    $(element).click(function (e) { 
      e.preventDefault();
      sendEvent(action,category);
    });
  }

  function sendEvent(action,category){
    if(analyticsIsEnabled){
      gtag('event', action, {
        'event_category': category
      });
    }
  }
  return {
    analyticsIsEnabled: analyticsIsEnabled,
    addEventOnClick: addEventOnClick,
    sendEvent: sendEvent
  }
};

$.validator.setDefaults({ 
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
  }
});

$(document).ready(function() { 
    /*
    $.fn.isInViewport = function() {
      var elementTop = $(this).offset().top;
      var elementBottom = elementTop + $(this).outerHeight();
      var viewportTop = $(window).scrollTop();
      var viewportBottom = viewportTop + $(window).height();
      return elementBottom > viewportTop && elementTop < viewportBottom;
    };

    gtag('event', '0. Home', {
      'event_category': 'Scroll'
    });
    
    $(window).on('resize scroll', function() {
      if ($('#agile-testing').isInViewport()) {
        gtag('event', '1. Agile Testing', {
          'event_category': 'Scroll'
        });
      }
      if ($('#assessment-que-es').isInViewport()) {
        gtag('event', '2. Assessment Que Es', {
          'event_category': 'Scroll'
        });
      }
      if ($('#assessment-start').isInViewport()) {
        gtag('event', '3. Formulario Inicio', {
          'event_category': 'Scroll'
        });
      }
    });
    */
});

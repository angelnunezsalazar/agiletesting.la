var AnswerSlide = function (elementSlide) {
  var pipFormats = {'1':'Nunca', '2':'Rara Vez', '3':'A Veces', '4':'Casi Siempre', '5':'Siempre'};

  function create() {
    noUiSlider.create(elementSlide,{
      start: 1,
      behaviour: 'tap',
      step: 1,
      connect: 'lower',
      range: {
         'min':  1,
         'max':  5
      },
      pips: {
         mode: 'values',
         values: [1,2,3,4,5],
         density: 24,
         format: {
          to: function(value){
            return pipFormats[value];
          }
        }
      }
    });
  };

  function syncronizeTo(inputElement){
    elementSlide.noUiSlider.on('update', function(values) {
      inputElement.value=values
    });
  }

  return {
    create: create,
    syncronizeTo: syncronizeTo
  }
};

$(document).ready(function(){
  var numberOfSteps = 3;
  buttonNextOnClick();
  buttonBackOnClick();

  function buttonNextOnClick(){
    for (i = 1; i <= numberOfSteps-1; i++) {
      $("#step-" + i + "-next").click({ num: i },function(e) {
        e.preventDefault();
        var num=e.data.num;
        $("#step-" + num).fadeOut(function(){
          $("#step-" + (num + 1)).fadeIn(); 
          $("#step-" + (num + 1)+"-nav").addClass("complete");
          $("#step-" + (num + 1)+"-nav").removeClass("disabled");
        });
        $("html, body").animate({ scrollTop: 0 }, "slow");
        
        if(historyApi()){
          var step=num+1;
          history.pushState({step:step}, null, "?step-" + step);
        }
      });
    }
  }

  function buttonBackOnClick(){
    for (i = 2; i <= numberOfSteps; i++) {
      $("#step-" + i + "-back").click({ num: i },function(e) {
        e.preventDefault();
        if(historyApi()){
          history.back();
        }
        else{
          var num=e.data.num;
          returnFromStep(num)
        }
      });
    }
  }

  function returnFromStep(currentStep){
    $("#step-" + currentStep).fadeOut(function(){
      $("#step-" + (currentStep - 1)).fadeIn(); 
      $("#step-" + currentStep+"-nav").addClass("disabled");
      $("#step-" + currentStep+"-nav").removeClass("complete");
      $("#step-" + (currentStep - 1)+"-nav").addClass("complete");
    });
    $("html, body").animate({ scrollTop: 0 }, "slow");
  }

  if(historyApi()){
    window.addEventListener("popstate", function(e) {
        var newStep=e.state.step;
        returnFromStep(newStep+1);
    });
    history.pushState({step:1}, null, "?step-1");
  }

  function historyApi() {
    return !!(window.history && history.pushState);
  }
});
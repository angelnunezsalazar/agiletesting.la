$(document).ready(function(){

  Highcharts.setOptions({
      colors: ['#50B432', '#E04F00']
  });

  companyData=[]
  othersData=[]
  wholeTeamLabels=["Testing a lo largo del proyecto",
                   "Colaboración activa entre los '3 Amigos'",
                   "Todo el equipo participa desde la definición",
                   "Todo el equipo contribuye con actividades de testing",
                   "Todos somos responsables de la calidad"];
  automationLabels=["Estrategia basada en la Pirámide de Automatización", 
                    "No se necesita ninguna intervención manual",
                    "Las pruebas se ejecutan continuamente",
                    "Los resultados son visibles y se toma acción cuando fallan."];
  testingLabels=["Risk Based Testing para determinar el alcance de las pruebas",
                 "Sesiones de Exploratory Testing son parte regular del trabajo",
                 "Balance entre pruebas manuales, automatizadas y exploratorias",
                 "Estrategia, y diseño de la prueba de manera iterativa",
                 "Estándares consistentes, transparentes y centralizados",
                 "El producto no tiene fallos graves en producción"];

  $.when(
    getCompanyData(1),
    getOthersData(1)
  ).then(function(){
    displayChart(
      document.getElementById("wholeTeamCanvas"),
      wholeTeamLabels,
      companyData,
      othersData
    );
  });

  $('#tab-navigation a').on('click',function (e) {
      e.preventDefault();
      var pillar = $(this).attr("data-pillar");
      var canvas= '';
      var labels = [];
      if(pillar==1) {
        canvas = 'wholeTeamCanvas';
        labels=wholeTeamLabels
      }
      if(pillar==2) {
        canvas = 'automationCanvas';
        labels=automationLabels
      }
      if(pillar==3) {
        canvas = 'testingCanvas';
        labels=testingLabels
      }

      $.when(
        getCompanyData(pillar),
        getOthersData(pillar)
      ).then(function(){
        displayChart(
          canvas,
          labels,
          companyData,
          othersData
        );
        $(this).tab('show');
      });
  });

  function getCompanyData(pillar){
    return $.getJSON("/api/assessment/<%= @assessment_id %>/answers?pillar="+pillar, function (data) {
      companyData=[]  
      $.each(data,function (index,value) {
        companyData.push(value.answer)
      });
    });
  }

  function getOthersData(pillar){
    return $.getJSON("/api/questions?pillar="+pillar, function (data) {
      othersData=[]  
      $.each(data,function (index,value) {
        var parseData=+parseFloat(value.average_previous).toFixed(2);
        othersData.push(parseData);
      });
    });
  }


  function displayChart(canvas,labels,companyData,othersData){
    Highcharts.chart(canvas, {
        chart: {
            type: 'column'
        },
        title: {
            text: 'Enfoque de Todo el Equipo'
        },
        subtitle: {
            text: 'El Nivel de Madurez de tu empresa comparado con otros encuestados'
        },
        xAxis: {
            categories: labels,
            crosshair: true
        },
        yAxis: {
            min: 0,
            max: 5,
            tickInterval: 1,
            endOnTick:false,
            title: {
                text: null
            }
        },
        tooltip: {
            headerFormat: '<span>{point.key}</span><table>',
            pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                '<td style="padding:0"><b>{point.y}</b></td></tr>',
            footerFormat: '</table>',
            shared: true,
            useHTML: true
        },
        plotOptions: {
            column: {
                pointPadding: 0.2,
                borderWidth: 0
            }
        },
        series: [{
            name: 'Tu Empresa',
            data: companyData

        }, {
            name: 'Otros Encuestados',
            data: othersData

        }],
        credits: {
            enabled: false
        },
    });
  }

  $("#share-links").jsSocials({
    showLabel: false,
    showCount: false,
    url: "http://agiletesting.la/assessment",
    text: "Agile Testing Assessment",
    shares: ["twitter","linkedin","facebook","email"]
  });

  jsSocials.shares.email = {
    to: "hola@agiletesting.la"
  };

}); 
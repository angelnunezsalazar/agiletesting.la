function AssessmentResults(attributes) {
	this.init(attributes);
}

AssessmentResults.prototype = {
	init: function(attributes) {
    this.assessmentId=attributes.assessmentId;
    this.companyData=[]
    this.othersData=[]
    this.wholeTeamLabels=["Testing a lo largo del proyecto",
                     "Colaboración activa entre los '3 Amigos'",
                     "Todo el equipo participa desde la definición",
                     "Todo el equipo contribuye con actividades de testing",
                     "Todos somos responsables de la calidad"];
    this.automationLabels=["Estrategia basada en la Pirámide de Automatización", 
                      "No se necesita ninguna intervención manual",
                      "Las pruebas se ejecutan continuamente",
                      "Los resultados son visibles y se toma acción cuando fallan."];
    this.testingLabels=["Risk Based Testing para determinar el alcance de las pruebas",
                   "Sesiones de Exploratory Testing son parte regular del trabajo",
                   "Balance entre pruebas manuales, automatizadas y exploratorias",
                   "Estrategia, y diseño de la prueba de manera iterativa",
                   "Estándares consistentes, transparentes y centralizados",
                   "El producto no tiene fallos graves en producción"];
  },
  results: function(){
    this.showFirstTab();
    this.onTabsClick();
  },
  showFirstTab:function(){
    this.showTab($("#wholeTeam-tab"),1,document.getElementById("wholeTeamCanvas"),this.wholeTeamLabels)
  },
  showTab: function(tab,pillar,canvas,labels){
    var self=this;
    $.when(
      self.getCompanyData(pillar),
      self.getOthersData(pillar)
    ).then(function(){
      self.showChart(
        canvas,
        labels,
        self.companyData,
        self.othersData
      );
      tab.tab('show');
    });
  },
  onTabsClick: function(){
    var self=this;
    $('#tab-navigation a').on('click',function (e) {
      e.preventDefault();
      var pillar = $(this).attr("data-pillar");
      var canvas= '';
      var labels = [];
      if(pillar==1) {
        canvas = 'wholeTeamCanvas';
        labels= self.wholeTeamLabels
      }
      if(pillar==2) {
        canvas = 'automationCanvas';
        labels= self.automationLabels
      }
      if(pillar==3) {
        canvas = 'testingCanvas';
        labels= self.testingLabels
      }
      self.showTab($(this),pillar,canvas,labels)
    });
  },
  getCompanyData: function(pillar){
    var self=this;
    return $.getJSON("/api/assessment/"+this.assessmentId+"/answers?pillar="+pillar, function (data) {
      self.companyData=[]  
      $.each(data,function (index,value) {
        var parseData=+parseFloat(value.answer).toFixed(2);
        self.companyData.push(parseData)
      });
    });
  },
  getOthersData: function(pillar){
    var self=this;
    return $.getJSON("/api/questions?pillar="+pillar, function (data) {
      self.othersData=[]  
      $.each(data,function (index,value) {
        var parseData=+parseFloat(value.average_previous).toFixed(2);
        self.othersData.push(parseData);
      });
    });
  },
  showChart: function(canvas,labels,companyData,othersData){
    Highcharts.setOptions({
        colors: ['#50B432', '#E04F00']
    });
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
};
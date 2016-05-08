$(function(){
  $(document).ready(function(){
    $.material.init();
    new WOW().init();
    $('#chart-1').css({ 'line-height': '1' });

    var data = $('#scatter-global-chart').data('chartdata');
    console.log(data);
    $('#scatter-global-chart').highcharts({
        chart: {
            type: 'scatter'
        },
        legend: { enabled: false },
        xAxis: {
            title: {
                enabled: true,
                text: 'Avg. Mastery Points'
            },
            startOnTick: true,
            endOnTick: true,
            showLastLabel: true,
            min: 0
        },
        yAxis: {
            title: {
                text: 'Avg. Winrate (%)'
            },
            min: 0,
            max: 100,
            tickInterval: 10,
            labels: {
                formatter: function () {
                    return this.value + '%';
                }
            }
        },
        plotOptions: {
            scatter: {
                marker: {
                    radius: 5,
                    states: {
                        hover: {
                            enabled: true,
                            lineColor: 'rgb(100,100,100)'
                        }
                    }
                },
                states: {
                    hover: {
                        marker: {
                            enabled: false
                        }
                    }
                },
                tooltip: {
                    headerFormat: '<b>{series.name}</b><br>',
                    pointFormat: 'Avg. Mastery Points: {point.x}<br>Avg. Winrate: {point.y}%'
                }
            }
        },
        series: data
    });
  });
});

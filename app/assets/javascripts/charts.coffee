@chartsReady = ->
  Highcharts.setOptions(
    lang:
      thousandsSep: ','
    colors: ['#7cb5ec', '#90ed7d', '#f7a35c', '#8085e9',
      '#f15c80', '#e4d354', '#2b908f', '#f45b5b', '#91e8e1']
  )
  if $('[data-object~="draw-chart"]').length > 0
    $.each($('[data-object~=draw-chart]'), () ->
      $(@).highcharts(
        credits:
          enabled: false
        chart:
          zoomType: 'x'
        title:
          text: $(@).data('title')
        subtitle:
          text: (if document.ontouchstart == undefined then 'Click and drag in the plot area to zoom in' else 'Pinch the chart to zoom in')
          style:
            color: '#999'
        xAxis:
          categories: $(@).data('categories')
          title:
            text: $(@).data('xaxis')
        yAxis:
          min: 0
          minTickInterval: 1
          title:
            text: $(@).data('yaxis')
          # labels:
          #   formatter: () -> return bytes(this.value, true, 0)
        # tooltip:
        #   formatter: () -> return bytes(this.y, true, 1)
        plotOptions:
          column:
            pointPadding: 0.2
            borderWidth: 0
            # stacking: 'normal'
        series: $(@).data('series')
      )
    )

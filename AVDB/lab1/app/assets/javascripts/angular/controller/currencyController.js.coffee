window.Application.controller 'CurrencyController', ($scope, currencyFactory) ->

  $scope.init =(date)->
    $scope.rate_date = date
    $scope.loadCurrencies().then(load_currency_to_chart)


  load_currency_to_chart=->
    kontinue = false
    $scope.currencies.forEach (currency) ->
      if currency.enabled && !kontinue
        kontinue = currency.selected = true
        updateChart(currency)

#============ Sorting Table ============#
  $scope.mainTable =
    sort:
      column: ''
      descending: false

  $scope.listTable =
    filter:
      name: ''
      #last_rate: ''
    sort:
      descending: false
      column: ''

  $scope.changeSorting = (table, column)->
    console.log table
    if table.sort.column == column
      table.sort.descending = !table.sort.descending
    else
      table.sort.column = column
      table.sort.descending = false

#============ Loading data ============#

  $scope.loadCurrencies =->
    currencyFactory.getCurrencies $scope.rate_date, (data)->
      $scope.currencies = data

#============ Model Changes ===========#
  $scope.enable_currency =(currency)->
    currency.enabled = !currency.enabled
    currency.selected = false
    currencyFactory.editCurrency(currency)

  $scope.select_currency =(currency) ->
    currency.selected = !currency.selected
    updateChart(currency)

 #=========== Chart ===================#
  updateChart = (currency)->
    if currency.selected
      currencyFactory.getCurrencyHistory currency, (data)->
        seria =
          id: currency.id,
          name: currency.code,
          pointInterval: 24 * 3600 * 1000,
          pointStart: Date.parse(data.start_date),
          data: data.points.map (x) -> parseFloat(x)
        $scope.currencyChart.series.push(seria)
    else
      $scope.currencyChart.series = $scope.currencyChart.series.filter (x) -> x.id != currency.id

  $scope.currencyChart =
      title:
        text: 'Currency Exchange Rate'
      xAxis:
          type: 'datetime'
      yAxis:
        title:
          text: 'Belarussian Ruble'
      series: []

#=========== Date Picker ==============#
  $scope.datepicker = {}

  $scope.datepicker.open = ($event) ->
    $event.preventDefault()
    $event.stopPropagation()
    $scope.datepicker.opened = true

  $scope.datepicker.dateOptions =
    formatYear: 'yy',
    startingDay: 1,
    showButtonBar: false

  $scope.datepicker.disabled = (date, mode) ->
    mode == 'day' && date.getDay() == 0

#=========== Currency Exchange ==========#
  FROM =  'From'
  TO = 'To'

  $scope.currency_exchange =
    to:
      code: TO
    from:
      code: FROM

  $scope.currency_exchange.change_currency =(currency, type)->
    if type == 1
      $scope.currency_exchange.from = currency
    else
      $scope.currency_exchange.to = currency
    $scope.currency_exchange.convert()

  $scope.currency_exchange.valid =->
    $scope.currency_exchange.to.code != TO &&
    $scope.currency_exchange.from.code != FROM &&
    isFinite($scope.currency_exchange.from_value)

  $scope.currency_exchange.convert =->
    if $scope.currency_exchange.valid()
      value = $scope.currency_exchange.from_value
      from = $scope.currency_exchange.from.last_rate
      to = $scope.currency_exchange.to.last_rate
      $scope.currency_exchange.to_value = from / to * value

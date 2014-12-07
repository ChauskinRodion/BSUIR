window.Application.factory 'currencyFactory', ($http) ->
  getCurrencies: (date, callback)->
    $http.get('/currency/get', { params: {date}}).success(callback)

  getCurrencyHistory: (currency, callback) ->
    $http.get('/currency/get_history/?id=' + currency.id).success(callback)

  editCurrency: (currency, callback)->
    $http.put('/currency/' + currency.id, currency).success(callback || ->)




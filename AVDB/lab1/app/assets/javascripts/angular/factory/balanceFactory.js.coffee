window.Application.factory 'balanceFactory', ($http) ->
  getBalances: (callback)->
    $http.get('/balance/get').success(callback)

  regenerateBalances: (callback)->
    $http.get('/balance/regenerate').success(callback)

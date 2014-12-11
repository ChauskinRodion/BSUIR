window.Application.controller 'DatabaseController', ($scope, $http) ->

  $scope.mail = {}

  $scope.prepare_mail_model =(id)->
    $scope.mail.type = id
    console.log id
    $scope.mail.ids = $('#' + id + ' :checkbox:checked').map( (i, el) -> parseInt el.value).get()

  $scope.sendMail =->
    data = JSON.stringify($scope.mail)
    $http.post('/database/send_email', data)
    .success (response)->
      if response.success
        alert 'mail successfuly delivered'
        $('#mail-modal').modal('hide')
      else
        alert 'fail blah blah blah..'


  $scope.create_client =->
    data = JSON.stringify($scope.client)
    $http.post('/database/create_client', data).success (response)->
      if response.success
        alert 'New Client Successfully Created'
        $('#new-client-modal').modal('hide')
      else
        alert 'Something wrong. Do you really need this?'


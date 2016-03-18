# Angular App
angular.module('CB3', [
  'firebase'
  'ngAnimate'
  'ui.bootstrap'
  'ngSanitize'
]).config(($uibTooltipProvider) ->
  $uibTooltipProvider.options placement: 'auto bottom'
  # $uibTooltipProvider.setTriggers({
  #   'outsideClick': 'outsideClick'
  # });
  return
).controller('mainCtrl', ($scope, $http, $firebaseObject, $firebaseArray) ->
#   $http.get('http://qa.api.crateandbarrel.com/APIHandler.ashx?pid=$qu1rr3lE@t3r&action=search&q=' + 'couch' + '&json=1').then (data) ->
   

  $scope.searchAPI = ->
    console.log("searching")
    $http.get('http://qa.api.crateandbarrel.com/APIHandler.ashx?pid=$qu1rr3lE@t3r&action=search&q=' + $scope.q + '&json=1').then (data) ->
      console.log(data)

      $scope.count = data.data.CommonAPI.SearchResults['@count']
      $scope.totalCount = data.data.CommonAPI.SearchResults['@totalCount']
      $scope.theData = data.data.CommonAPI.SearchResults.item
      $scope.cards = $scope.theData
      return

  $scope.cleanImg = (old_url) ->
    if !old_url
      return
    new_url = old_url.split('?')[0]
    new_url = old_url.split('$')[0].split('&')[0]
    new_url

  $scope.showJson = false
  $scope.panel = false
  $scope.test = {}
  $scope.totalPrice = 0

  $scope.setPanel = (card) ->
    $scope.panel = card
    $scope.totalPrice += parseInt(card.CommonAPI.Item.Sku.priceRange.replace(/[^0-9\.]+/g, ''))
    $scope.test = card
    return

  firebaseRoot = 'https://moodboardapi.firebaseio.com/'
  
  myBoardKey = localStorage.getItem("moodBoardKey");
  
  if !myBoardKey
    $firebaseArray(new Firebase(firebaseRoot)).$add({}).then((ref) ->
      myBoardKey = localStorage.setItem('moodBoardKey', ref.key());
      $scope.myBoard = $firebaseArray(new Firebase(firebaseRoot + '/'+myBoardKey))
    )
  if myBoardKey
    console.log "my board key is"+myBoardKey
    $scope.myBoard = $firebaseArray(new Firebase(firebaseRoot + '/'+myBoardKey))

  $scope.addCard = (card) ->
    $scope.myBoard.$add(card)
  

)

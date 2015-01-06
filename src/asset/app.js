var app = angular.module('PadlyApp', []);
WEBROOT = "http://192.168.33.2:30080";

app.controller('SearchController', function($scope, $http) {
  $scope.search = {};
  $scope.search.textbox = "";
  $scope.search.elements = {};
  $scope.search.types = {};


  $scope.setElement = function() {
    $scope.search.elements[this.element] = !$scope.search.elements[this.element];
  };

  $scope.setType = function() {
    $scope.search.types[this.type] = !$scope.search.types[this.type];
  };

  $scope.setRarity = function() {
    $scope.search.rarity = this.rarity;
  }

  //a scope function to load the data.
  $scope.loadData = function () {
    console.log($scope.search);

    $http.get(WEBROOT+'/monsters').success(function(data) {
     $scope.items = data;
    });
  };
});
var app = angular.module('PadlyApp', []);
WEBROOT = "http://192.168.33.2:30080";

app.controller('SearchController', function($scope, $http) {
  $scope.search = {};
  $scope.search.textbox = "";
  $scope.search.elements = {};
  $scope.search.types = {};
  $scope.search.awoken_skills = {};
  $scope.ref = {};
  elements = ['fire', 'water', 'wood', 'light', 'dark'];
  $scope.ref.elements = elements;
  $scope.ref.types = ['dragon', 'devil', 'balanced', 'attacker', 'physical', 'healer', 'god', 'evo_material', 'enhance_material'];

  awoken = ['enhanced_hp', 'enhanced_attack', 'enhanced_heal', 'skill_boost', 'extend_time'];

  for (var i=0; i<elements.length; i++) {
    awoken.push("enhanced_"+elements[i]+"_attack");
  }
  for (var i=0; i<elements.length; i++) {
    awoken.push("enhanced_"+elements[i]+"_orbs");
  }
  for (var i=0; i<elements.length; i++) {
    awoken.push("reduce_"+elements[i]+"_damage");
  }

  $scope.ref.awoken_skills = awoken.concat(['resistance_bind', 'resistance_dark', 'resistance_jammers', 'resistance_poison', 'resistance_skill_lock',
    'auto_recover', 'recover_bind', 'two_prong_attack']);

  $scope.setElement = function() {
    $scope.search.elements[this.element] = !$scope.search.elements[this.element];
  };

  $scope.setType = function() {
    $scope.search.types[this.type] = !$scope.search.types[this.type];
  };

  $scope.setAwokenSkill = function() {
    $scope.search.awoken_skills[this.skill] = !$scope.search.awoken_skills[this.skill];
  };

  $scope.setRarity = function() {
    $scope.search.rarity = this.rarity;
  }

  //a scope function to load the data.
  $scope.loadData = function () {

    console.log($scope.search);
    s = $scope.search

    q = "";

    if (s.textbox) {
      q += "name=" + s.textbox + "&"
    }

    if (s.cost && s.cost.min) {
      q += "cost_min=" + s.cost.min + "&"
    }
    if (s.cost && s.cost.max) {
      q += "cost_max=" + s.cost.max + "&"
    }

    value = [];
    for (key in s.elements) {
      if (!s.elements[key]) {
        continue;
      }

      value.push(key);
    }
    if (value.length > 0) {
      value.join(',');
      q += "";
    }

    $http.get(WEBROOT+'/monsters').success(function(data) {
     $scope.items = data;
    });
  };
});
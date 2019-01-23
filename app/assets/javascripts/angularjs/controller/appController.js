app.controller("detailController", [
  "$scope",
  "$window",
  "$http",
  "Details",
  "Admin",
  function($scope, $window, $http, Details, Admin) {
    $scope.init = function() {
      $scope.dataPresent = false;
      if (typeof json != "undefined") {
        angular.forEach(json, function(value, key) {
          $scope[key] = value;
        });
      }
      $scope.states = JSON.parse(states);
      if ($scope.data) {
        $scope.dataPresent = true;
      } else {
        $scope.dataPresent = true;
      }
    };
    $scope.init();

    var vm = this;

    $scope.submit = function() {
      console.log($scope.student);
      data = new Details($scope.student);
      data.save().then(function(value) {
        $window.location.href = "http://localhost:3000/";
      });
      $window.location.href = "http://localhost:3000/";
    };

    $scope.uploadFile = function(files) {
      var fd = new FormData();
      //Take the first selected file
      fd.append("file", files[0]);
      $scope.student.image = fd;
    };

    $scope.deleteDetail = function(data) {
      data = new Details({ id: data.id });
      debugger
      data.delete().then(function(value) {
        $window.location.href = "http://localhost:3000/";
      });
    };

    $scope.download = function() {
      window.location.href = "/admin/download";
    };

    $scope.selectDistrict = function(state) {
      console.log(state);
      for (var i = 0; i < $scope.states.states.length; i++) {
        if ($scope.states.states[i].state == state) {
          $scope.districts = $scope.states.states[i].districts;
        }
      }
    };

    $scope.downloadPdf = function()
    {
      window.location.href = "/admin/show";      
    }

    $scope.downloadXLS = function()
    {
      window.location.href = "/admin/excel";      
    }
  }
]);

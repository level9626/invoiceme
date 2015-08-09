
function CompanyNewCtrl($scope, $mdDialog, Company) {
  $scope.company = {
    name: '',
    email: '',
    address: ''
  };

  $scope.cancel = function() {
    $mdDialog.cancel();
  };

  $scope.saveCompany = function () {
    Company.save($scope.company, function (company) {
      $mdDialog.hide();
    }, function (responce) {
      console.log(responce.data.errors);
      $scope.errors = responce.data.errors;
    });
  };
}
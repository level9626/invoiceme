'use strict';

angular.module('PaymentsApp')
       .controller('PaymentsShowCtrl',
        ['$scope',
         '$routeParams',
         'Payment',
         function ($scope, $routeParams, Payment) {

              Payment.get({id: $routeParams['id']}, function (payment) {
                 $scope.payment = payment;
             });

         }]);

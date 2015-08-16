angular.module('ProfilesApp')
  .controller('ProfileStatisticsCtrl',
    ['$scope',
    '$routeParams',
    'Invoice',
    function ($scope, $routeParams, Invoice) {
      $scope.colors = [];

      Invoice.statistics(function (statistics) {
        statistics.percent_by_state = _.map(statistics.percent_by_state, function(el){
          el.value = parseFloat(el.value);
          return el;
        });
        $scope.statistics = statistics;
        _get_colors();
      });

      $scope.is_currency = function (val) {
        return _.contains(['uah', 'eur', 'usd', 'rub'], val);
      };

      $scope.is_in_the_middle = function (obj, index) {
        var count = _.keys(obj).length;
        if (count - (index + 1) === 1) return true;
        if (count - (index + 1) === 2) return true;

        return false;
      };

      // Private Scope
      function _get_colors () {
        var colors = {
          draft: '#999',
          open: '#999',
          unpaid: '#d22f2f',
          partly: '#ff8e00',
          paid: '#00bd22',
          overdue: '#8d0404',
          bad_debt: '#333'
        };

        _.each($scope.statistics.percent_by_state, function(el) {
          $scope.colors.push(colors[el.label]);
        });
      }
    }]);

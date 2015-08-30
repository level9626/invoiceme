'use strict';

angular.module('InvMe')
  .directive('inFilterTabs',[
  'Search',
  function (Search) {
    return {
      restrict: 'A',
      link: function (scope) {
        scope.methods.clear_filters = function (param) {
          if (_table_filter_keys().length == 0)
            return;

          Search.clear_param(param);
        };

        scope.methods.filter = function (filter_param, filter_value) {
          $(document).scrollTop(0);
          var params = {};
          params[filter_param] = filter_value;
          Search.search_q(params);
        };

        scope.methods.selected = function (filter_param, filter_value) {
          if (filter_param == 'index' && _table_filter_keys().length == 0)
            return true;

          return Search.q_params()['q[' + filter_param + ']'] == filter_value;
        };

        // Privatescope
        function _table_filter_keys () {
          return _.filter(Search.q_keys(), function (el) {
            return el.match(/q\[(state_eq|currency_eq)\]/);
          });
        }
      }
    }
  }]);

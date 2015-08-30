'use strict';

angular.module('InvMe')
  .factory('Search',[
  '$location',
  function($location) {
    // Private Scope
    function _merge_for_q (obj) {
      var obj2 = {};
      _.each(obj, function (v, k) {
        obj2["q["+k+"]"] = v;
      });
      return _.extend($location.search(), obj2);
    }

    function _merge (obj) {
      return _.extend($location.search(), obj);
    }

    return {
      search: function (params) {
        $location.search($.param(_merge(params)));
      },
      search_q: function (params) {
        $location.search($.param(_merge_for_q(params)));
      },
      clear: function () {
        $location.search('');
      },
      clear_param: function (param) {
        $location.search($.param(_.omit($location.search(), param)));
      },
      q_params: function () {
        return $location.search();
      },
      q_keys: function () {
        return _.keys($location.search());
      }
    }
  }]);

'use strict';

// monkey patch for angular ui datepicker
angular.module('InvMe')
  .directive('datepickerPopup',
    ['dateFilter',
    'datepickerPopupConfig',
    function (dateFilter, datepickerPopupConfig) {
      return {
        restrict: 'A',
        priority: 1,
        require: 'ngModel',
        link: function(scope, element, attr, ngModel) {
          var dateFormat = attr.datepickerPopup || datepickerPopupConfig.datepickerPopup;
          ngModel.$formatters.push(function (value) {
            return dateFilter(value, dateFormat);
          });
        }
      };
  }]);
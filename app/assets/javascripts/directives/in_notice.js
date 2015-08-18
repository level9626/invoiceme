'use strict';

angular.module('InvMe')
  .directive('inNotice',[
  '$rootScope',
  '$timeout',
  function($rootScope, $timeout) {
    return {
      restrict: 'E',
      replace: true,
      template: '<div class="row" ng-repeat="notification in notifications"> \
                  <md-toolbar class="md-{{notification.type}}"> \
                    <div class="md-toolbar-tools"> \
                      <h2 class="md-flex">{{notification.text}}</h2> \
                      <div flex=""></div> \
                      <md-button class="close md-icon-button" \
                                 aria-label="remove message" \
                                 ng-click="remove_message($index)" \
                                 type="button"> \
                        <i class="fa fa-times"/> \
                      </md-button> \
                    </div> \
                  </md-toolbar> \
                </div>',
      link: function(scope) {
        scope.notifications = [];
        $rootScope.$on('notify', function (event, args) {
          if (_contains(scope.notifications, args))
            return;

          scope.notifications.push(args);
          $timeout(function (){
            scope.notifications.shift();
          }, 5000);
        });

        scope.remove_message = function (index) {
          scope.notifications.splice(index, 1);
        };

        function _contains(thelist, props) {
          var pnames = _.keys(props);
          return _.find(thelist, function (obj) {
            return _.all(pnames, function (pname) {
              return obj[pname] == props[pname];
            });
          });
        };
      }
    }
  }]);

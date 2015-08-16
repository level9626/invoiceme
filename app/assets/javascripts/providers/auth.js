'use strict';

angular.module('InvMe')
  .provider('Auth', function AuthProvider() {
    /**
     * The default paths.
     */
    var paths = {
        logout:                        '/users/sign_out.json',
        updateProfile:                 '/users.json',
        currentUser:                   'api/profiles/current.json'
      };
    /**
     * The default HTTP methods to use.
     */
    var methods = {
        login:                         'POST',
        updateProfile:                 'PUT',
        currentUser:                   'GET'
      };

    /**
     * Set to true if 401 interception of the provider is not desired
     */
    var ignoreAuth = false;

    var parse = function (response) {
      return response.data ;
    };

    // A helper function that will setup the ajax config
    // and merge the data key if provided
    function httpConfig(action, data) {
      var config = {
          method:     methods[action].toLowerCase(),
          url:        paths[action],
          ignoreAuth: ignoreAuth
        };
      if (data) {
        config.data = data;
      }
      return config;
    }
    // A helper function to define our configure functions.
    // Loops over all properties in obj, and creates a get/set
    // method for [key + suffix] to set that property on obj.
    function configure(obj, suffix) {
      /*jshint validthis: true */
      angular.forEach(obj, function (v, action) {
        this[action + suffix] = function (param) {
          if (param === undefined) {
            return obj[action];
          }
          obj[action] = param;
          return this;
        };
      }, this);
    }
    configure.call(this, methods, 'Method');
    configure.call(this, paths, 'Path');
    // The ignoreAuth config function
    this.ignoreAuth = function (value) {
      if (value === undefined) {
        return ignoreAuth;
      }
      ignoreAuth = !!value;
      return this;
    };
    // The parse configure function.
    this.parse = function (fn) {
      if (typeof fn !== 'function') {
        return parse;
      }
      parse = fn;
      return this;
    };
    // Creates a function that always
    // returns a given arg.
    function constant(arg) {
      return function () {
        return arg;
      };
    }

    this.$get = [
      '$q',
      '$http',
      '$rootScope',
      function ($q, $http, $rootScope) {
        function save(user) {
          if (!user || $.isEmptyObject(user))
            return;
          $rootScope._currentUser = user;
        }
        // A reset that saves null for currentUser
        function reset() {
          save(null);
        }
        var service = {
            getCurrentUser: function (creds) {
              creds = creds || {};
              return $http(httpConfig('currentUser'), true).then(parse).then(save);
            },
            logout: function () {
              var returnOldUser = constant(service._currentUser);
              $rootScope._currentUser = null;
              return $http(httpConfig('logout')).then(reset).then(returnOldUser);
            },
            updateProfile: function (creds) {
              creds = creds || {};
              return $http(httpConfig('updateProfile', { user: creds })).then(parse).then(save);
            },
            currentUser: function () {
              return $rootScope._currentUser;
            },
            isAuthenticated: function () {
              return !!$rootScope._currentUser;
            },
          };
        return service;
      }
    ];
  });

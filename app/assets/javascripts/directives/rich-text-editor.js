angular.module('InvMe')
  .directive('richTextEditor', function() {
    return {
      restrict: 'A',
      replace: true,
      require: '?ngModel',
      transclude: true,
      template: '<div><textarea></textarea></div>',
      link: function(scope, element, attrs, controller) {
        var editor, textarea, toolbar, button;
        textarea = element.find('textarea').wysihtml5({
          toolbar: {
              "font-styles": false,
              "lists": false,
              "link": false,
              "image": false,
              "color": false,
              "blockquote": false,
              "size": 'xs'
          }
        });
        editor = textarea.data('wysihtml5').editor;
        toolbar = textarea.data('wysihtml5').toolbar;

        // show/hide editor toolbar
        button = $('\
          <button id="show-toolbar" \
                  class="btn-primary pull-right btn-xs" \
                  type="button" \
                  style=" margin-bottom: 8px;"> \
            Show Editor \
          </button>');

        toolbar.parent().prepend(button);

        toolbar.addClass('hidden');

        button.on('click', function(){
          if (toolbar.hasClass('hidden')){
            button.text("Hide editor");
            toolbar.removeClass('hidden');
          }else{
            button.text("Show editor");
            toolbar.addClass('hidden')   ;
          }
          return false;
        });

        // update editor content on model change
        editor.on('change', function() {
          return controller.$setViewValue(editor.getValue());
        });
        return scope.$watch(attrs.ngModel, function(newValue, oldValue) {
          textarea.html(newValue);
          return editor.setValue(newValue);
        });
      }
    };
  });

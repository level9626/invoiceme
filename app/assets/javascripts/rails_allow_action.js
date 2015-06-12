$.rails.allowAction = function(element) {
  console.log('here');
  var $link, $modal_html, message, modal_html;
  message = element.data('confirm');
  if (!message) { return true; }

  $link = element.clone()
            .removeAttr('class')
            .removeAttr('data-confirm')
            .addClass('btn')
            .addClass('btn-danger')
            .html("Yes, I'm positively certain.");

  modal_html = "<div class=\"modal\" id=\"deleteModal\">"+
                 "<div class=\"modal-header\">"+
                   "<a class=\"close\" data-dismiss=\"modal\">×</a>"+
                     "<h3>" + message + "</h3>"+
                 "</div>"+
                   "<div class=\"modal-body\">"+
                     "<p>Be certain, sonny.</p>"+
                   "</div>"+
                   "<div class=\"modal-footer\">"+
                   "<a data-dismiss=\"modal\" class=\"btn\">Cancel</a>"+
                 "</div>"+
               "</div>";

  $modal_html = $(modal_html);
  $modal_html.find('.modal-footer').append($link);
  $modal_html.modal();
  return false;
};
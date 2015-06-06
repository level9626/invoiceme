$(document).ready( function() {
  var el        = $('[data-content-toggle]'),
      vals      = el.attr('data-content-toggle').split(','),
      texts     = el.attr('data-button-values').split(','),
      text_from = texts[0],
      text_to   = texts[1],
      from      = $(vals[0]),
      to        = $(vals[1]);

  console.log(from);
  console.log(to);

  // By default 'from' DOM element will be shown.
  $(to).addClass('hidden');
  el.find('a').text(text_from);

  el.click(function () {
    if(from.hasClass('hidden')) {
      from.removeClass('hidden');
      to.addClass('hidden');
      el.find('a').text(text_from);
    } else {
      to.removeClass('hidden');
      from.addClass('hidden');
      el.find('a').text(text_to);
    }
  });

});

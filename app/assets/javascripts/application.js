//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require rails_allow_action
//= require raphael
//= require morris
//= require data-content-toggle
//= require_tree .

// Manky patch JS Number class
Number.prototype.round = function(p) {
    p = p || 10;
    return parseFloat( this.toFixed(p) );
};

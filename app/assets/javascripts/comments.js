
$(document).ready(function(){
    $('.deleteAction').click(function(){
        var pathname = window.location.pathname.split('/')[1];
        var pathname_id = window.location.pathname.split('/')[2];
        var current_comment = $(this).parents('.well');
        if(confirm('Are you sure?')){
            $.ajax({
                url: pathname + '/' + pathname_id +'/comments/' + $(current_comment).attr('data-item_id'),
                type: 'POST',
                data: { _method: 'DELETE' },
                success: function(){
                $(current_comment).fadeOut(0);
                }
            });
        }
    });
});

$(document).ready(function(){
    $('.new_comment').submit( function(e) {
        e.preventDefault();
        var that = this;
        $.ajax({
            url: $(this).attr('action'),
            type: $(this).attr('method'),
            data: $(this).serializeObject(),
            dataType: 'JSON',
            success: function(data){
                $('#comments').append('<div class="well" data-item_id="'+data.id+'">'+
                                    '<div class="incomplete-comments">'+
                                        '<div class="inline-block pull-right">'+
                                            '<span class="deleteAction">'+
                                                '<div class="fa fa-close"></div>'+
                                            '</span>'+
                                        '</div>'+
                                        data.content +
                                    '</div>'+
                                '</div>');

                $(that).data("wysihtml5").editor.setValue('');
            },
            error: function(){
                // TODO: Handle exceptions/validations
                alert('Fix problems below: \n' +
                      'Cannot be empty.\n' +
                      'The number of characters is invalid (1 to 300)');
            }
        });
        return false;
    });
});
// From http://code.google.com/p/jquery-longpolling/
(function($){
    $.extend({
        longpolling : function(options){
            var _options = options;
            
            options.complete = function(){
                $.longpolling(_options);
            };

            $.ajax(options);
        }
    });
}(jQuery));


$(document).ready(function() {
setTimeout(function() {
	$.longpolling({url:"/pings.json?", success:function(data) {
		var ul = $('ul');
		ul.append("<li>" + data + "</li>");
		if (ul.children().length > 10) {
			ul.children("li:first").remove();
		}
	}});	
}, 10);
});

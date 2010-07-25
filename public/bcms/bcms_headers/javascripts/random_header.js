function random_header(page_id, headerClass, time) {
	var urlString = "/random_headers/show/" + page_id.toString();
	jQuery(headerClass).everyTime(time,function(i){
		jQuery(headerClass).animate({opacity: 0.5}, "slow");
		jQuery.ajax({
			url: urlString,
			cache: false,
			success: function(header_string){
				jQuery(headerClass).attr("src", header_string);
				jQuery(headerClass).animate({opacity : 1.0}, "slow");
				}});
			});
		};
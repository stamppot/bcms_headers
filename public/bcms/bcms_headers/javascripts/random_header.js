function random_header(page_id, headerClass, time) {
	var urlString = "/random_headers/show/" + page_id.toString();
	jQuery(headerClass).everyTime(time,function(i){
		jQuery.ajax({
			url: urlString,
			cache: false,
			success: function(header_string){
				jQuery(headerClass).attr("src", header_string);
			}
		});
	});
}
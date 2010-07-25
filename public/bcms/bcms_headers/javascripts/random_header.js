function random_header(page_id, headerClass, time) {
	var urlString = "/random_headers/show/" + page_id.toString();
	// first image
	jQuery.ajax({
		url: urlString,
		cache: false,
		success: function(header_string){
			jQuery(headerClass).attr("src", urlString);
		}
	});
	jQuery(headerClass).everyTime(time,function(i){ // div to update
		jQuery.ajax({
			url: urlString,
			cache: false,
			success: function(header_string){
				jQuery(headerClass).attr("src", urlString);
			}
		});
	});
}
function random_header(section_id, headerClass, time) {
	var urlString = "/random_headers/show/" + section_id.toString();
	jQuery(headerClass).everyTime(time,function(i){ // div to update
		jQuery.ajax({
			url: urlString,
			cache: false,
			success: function(header_string){
				jQuery(headerClass).attr("src").replace(header_string);
			}
		});
	});
}
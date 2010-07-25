function random_header(controllerActionString, headerClass, time) {
	jQuery(headerClass).everyTime(time,function(i){ // div to update
		jQuery.ajax({
			url: controllerActionString, /* controller action */
			cache: false,
			success: function(header_string){
				jQuery(headerClass).attr("src").replace(header_string);
			}
		});
	});
}
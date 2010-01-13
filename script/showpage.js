$(function () {
	$('.page_thumbnail') .click(function () {
		var pid = $(this) .attr('id') .split('_') [0];		
		if ($('#' + pid + '_container') .html() .indexOf('getScreen') < 0) {
			var alt = $(this) .attr('alt');
			/*$('#' + pid + '_container') .html('<img src="http://repo.lib.virginia.edu:18080/fedora/get/uva-lib:' + pid + '/uva-lib-bdef:102/getScreen" class="page_screen" alt="' + alt + '" title="Click to Shrink"/>') .fadeIn('slow');*/
			$('#' + pid + '_container .page_screen') .attr('id', pid + '_image');
			$('#' + pid + '_container .page_screen') .attr('alt', alt);
			$('#' + pid + '_container .page_screen') .attr('src', 'http://repo.lib.virginia.edu:18080/fedora/get/uva-lib:' + pid + '/uva-lib-bdef:102/getScreen');
			$(this) .hide();
			$('#' + pid + '_container') .fadeIn('fast');
		} else {
			$(this) .hide();
			$('#' + pid + '_container') .fadeIn('fast');
		}
	});
	$('.page_screen') .click(function () {
		var pid = $(this) .attr('id') .split('_') [0];
		$(this) .parent() .hide();
		$('#' + pid + '_link') .fadeIn('fast');
	});
});
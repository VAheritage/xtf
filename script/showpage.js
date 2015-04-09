$(function () {
	$('.page_thumbnail') .click(function () {
		var pid = $(this) .attr('id') .split('_') [0];		
		if ($('#' + pid + '_container') .html() .indexOf('getScreen') < 0) {
			var alt = $(this) .attr('alt');
            var repo = $('#' + pid + '_container').attr('class').split(" ")[1];
            if (repo != undefined ) {
              image_url = "http://" + repo + ".lib.virginia.edu:8080/fedora/objects/uva-lib:" + pid + "/methods/djatoka%3AStaticSDef/getScaled?maxWidth=1600&maxHeight=1600";
            } else {
              image_url = "http://" + "fedora-prod01" + ".lib.virginia.edu:8080/fedora/get/uva-lib:" + pid + "/uva-lib-bdef:102/getScreen";
            }
			/*$('#' + pid + '_container') .html('<img src="http://repo.lib.virginia.edu:18080/fedora/get/uva-lib:' + pid + '/uva-lib-bdef:102/getScreen" class="page_screen" alt="' + alt + '" title="Click to Shrink"/>') .fadeIn('slow');*/
			$('#' + pid + '_container .page_screen') .attr('id', pid + '_image');
			$('#' + pid + '_container .page_screen') .attr('alt', alt);
			$('#' + pid + '_container .page_screen') .attr('src', image_url);
            if (repo != undefined ) {
			  $('#' + pid + '_container .page_screen') .attr('style', 'height: 800px; width: 600px;');
            } else {
			  $('#' + pid + '_container .page_screen') .attr('style', 'width: 600px;');
            }
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

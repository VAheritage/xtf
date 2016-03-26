$(function () {
	$('#basicSubmit') .click(function () {
		var publisher = $('#publisher') .attr('value');
		var search_text = $('input[type=text]') .attr('value');
		if (publisher != 'null') {
			$('#f1-publisher') .attr('value', publisher);
			$('#f1-publisher') .attr('name', 'f1-publisher');
		}
		
		if (search_text != '') {
			$('#search_text') .attr('value', search_text);
			$('#search_text') .attr('name', 'text');
		};
	});
});
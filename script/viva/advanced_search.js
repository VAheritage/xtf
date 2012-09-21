/***********************************************
Javascript written by Ethan Gruber, Fall-Winter 2008/2009
for the VIVA EAD XTF project developed by Scholarly Resources of the U.Va. Library

Library: JQuery 1.2.6

This script submits a clean query from the advanced search form, omitting any search parameters
that are blank.
***********************************************/

$(function () {
	$('input') .each(function () {
		$(this) .removeAttr('disabled');
	});
	$('select') .each(function () {
		$(this) .removeAttr('disabled');
	});
	
	$('#submit') .click(function () {
		$('input[@type="text"]') .each(function () {
			var string = this .value;
			this .value = (string.replace(/^\W + /, '')) .replace(/\W + $/, '');
			if (this .value == null || this .value == '') {
				$(this) .attr('disabled', 'disabled');
			}
		});
		if ($('input[@name="text-join"]:checked') .attr('value') != 'or') {
			$('input[@name="text-join"]') .each(function () {
				$(this) .attr('disabled', 'disabled');
			});
		}
		if ($('select[@name="text-prox"]') .attr('value') == 'null') {
			$('select[@name="text-prox"]') .attr('disabled', 'disabled');
		}
		if ($('select[@name="f1-publisher"]') .attr('value') == 'null') {
			$('select[@name="f1-publisher"]') .attr('disabled', 'disabled');
		}
	});
});
/***********************************************
Javascript written by Ethan Gruber, Fall-Winter 2008/2009
for the VIVA EAD XTF project developed by Scholarly Resources of the U.Va. Library

Library: JQuery 1.2.6

The purpose of this script is to remove the name of the drop to menu to omit the sort parameter
in the event that some selects the "Relevance" parameter for sorting.  If someone selects something
other than Relevance, the name attribute is replaced, if it is not already there.
***********************************************/

$(function () {
	$('#sort_button') .click(function () {
		if ($('select[name=sort]') .attr('value') == '') {
			$('select[name=sort]') .removeAttr('name');
		} else {
			$('select[name=sort]') .attr('name', 'sort');
		}
	});
});
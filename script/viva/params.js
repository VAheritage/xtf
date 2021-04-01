/***********************************************
Javascript written by Ethan Gruber, Fall-Winter 2008/2009
for the VIVA EAD XTF project developed by Scholarly Resources of the U.Va. Library

Library: JQuery 1.2.6

The purpose of this script is to allow users to submit a search phrase within the current search results.
Several paramers are omitted when searching, such as the page number and sort.
***********************************************/

$(function () {
  $('#search_within') .click(function () {
    if ($('#dropdown') .children('option:selected') .attr('title') == 'within') {
      var qString = unescape(window.location.search.substring(1)).split(/[&;]/);
      var params = new Array();
      var search_within_text = $('#search_within_text').val();
      if ($('#form input[name="text"]').val() !== undefined) {
    	  var prev_text = $('#form input[name="text"]').val();
    	  $('#form input[name="text"]').val(prev_text + ' ' + search_within_text);
      }
      else {
          $('#form') .append('<input type="hidden" name="text" value="' + search_within_text + '"/>');
      }
      for (var i = 0; i < qString.length; i++){
      //below is a list of parameters to omit when doing the "search within" the current results
          if (qString[i].indexOf('browse-all') < 0 && qString[i].indexOf('expand') < 0 && qString[i].indexOf('startDoc') && qString[i].indexOf('sort') < 0 && qString[i].indexOf('text') < 0 && qString[i].indexOf('smode') < 0 && sQtring[i].indexOf(/f[0-9]-/) < 0){
            $('#form') .append('<input type="hidden" name="' + qString[i].split('=')[0] + '" value="'+ qString[i].split('=')[1] + '"/>');
        }
      }
      if ($('#form input[name="text"]').val() !== undefined) {
        if ($('#form input[name="browse-all"]').val() !== undefined) {
           $('#form input[name="browse-all"]').remove();
        }
      }
    } 
  });
});

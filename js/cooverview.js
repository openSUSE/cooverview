// GLOBAL VARIABLES

var pull_command;

function load_and_update () {
  //console.log("This: " + $(this).attr('id') );
  var container = $(this).attr('id').replace("hl-","");
  var details = jQuery('div[id*="details-' + container + '"]');

  if ( details.html() == '' ) {
    var request = $.ajax({
      url: "cooverview",
      method: "POST",
      data: JSON.stringify({ container : container, pull_command: pull_command }),
      beforeSend: function(request) {
	request.setRequestHeader("Accept", "text/html");
      },
      contentType: "application/json; charset=utf-8",
      dataType: 'json',
      failure: function( msg ) {
	alert("something went wrong");
      },
      complete: function(msg){
	details.html(msg.responseText);}
    });
    $(".layers-button").each(function(i,elem){
      $(elem).on('click',toogle_layer);
    });
  } else {
    details.html('');
  }
}

function toogle_layer (id) {
  var element = $('#layers-' + id );
  var css_display = element.css("display");
  if ( css_display == "none" ) {
      element.css("display","block");
  } else {
      element.css("display","none");
  }
}

$(document).ready(function(){
  // set action for click event for each container bar
  $(".container-hl").each(function(i,elem){
    $(elem).on('click',load_and_update);
  });

  // Get pull_command from cookie
  pull_command = Cookies.get('pull_command');

  // set action for click event of "Save" button in modal window
  $("#modal_save_button").click(function() {
    pull_command = $('#pull_command_selector :radio:checked').val();
    $("#SettingsDialog").modal('hide');
    Cookies.set('pull_command', pull_command);
    $('.pcmd').each(function() {
      $(this).text(pull_command);
    });
  });

  // prepare pull command and show modal window if not found in cookie
  if (! pull_command) {
    $("#SettingsDialog").modal('show');
  } else {
    // set pull_command radio button to checked
    $("#" + pull_command).prop('checked', true);
  }

});

function update_search(pattern) {
  $('#srch_term').val(pattern);
  $('#search_form').submit();
}

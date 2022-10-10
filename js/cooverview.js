// GLOBAL VARIABLES

var pull_command;

function load_and_update () {
  //console.log("This: " + $(this).attr('id') );
  var container = $(this).data("container");
  var details = $('#details-' + $(this).attr('id'));
  var spinner = $(this).find('#spinner');

  if ( details.html() == '' ) {
    spinner.removeClass('d-none');
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
	details.html(msg.responseText);
	spinner.addClass('d-none');
	details.parent().collapse('show');
      }
    });
  } else {
    details.parent().collapse('toggle');
  }
}
function fallbackCopyTextToClipboard(text) {
  var textArea = document.createElement("textarea");
  textArea.style.position = 'fixed';
  textArea.class = 'd-none'
  textArea.value = text;
  document.body.appendChild(textArea);
  textArea.focus();
  textArea.select();
  document.execCommand('copy');
  document.body.removeChild(textArea);
  return false;
}

$(document).on('click', '#clipboard', function(){
  var text = $(this).data("copy");
  if (!navigator.clipboard) {
    fallbackCopyTextToClipboard(text);
    return false;
  }
  navigator.clipboard.writeText(text);
  // Display a tooltip saying you have copied to the clipboard
  $(this).tooltip({ trigger: 'manual' });
  $(this).attr('title', 'Copied to the clipboard');
  $(this).attr('data-original-title', 'Copied to the clipboard');
  $(this).tooltip('show');
  setTimeout(() => {
    $(this).tooltip('hide');
    $(this).attr('title', 'Copy to clipboard');
    $(this).attr('data-original-title', 'Copy to clipboard');
  }, 2000);
  return false;
});
$(document).on('click', '#unclickable', function(){
  return false;
});

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
    Cookies.set('pull_command', pull_command, {expires : 365});
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

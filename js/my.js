function load_and_update () {
  //console.log("This: " + $(this).attr('id') );
  var container = $(this).attr('id').replace("hl-","");
  var details = jQuery('div[id*="details-' + container + '"]');

  if ( details.html() == '' ) {
    var request = $.ajax({
      url: "cooverview",
      method: "POST",
      data: JSON.stringify({ container : container }),
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
  $(".container-hl").each(function(i,elem){
    $(elem).on('click',load_and_update);
  });
});

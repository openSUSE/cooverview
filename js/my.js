
function load_and_update () {
  //console.log("This: " + $(this).attr('id') );
  var container = $(this).attr('id').replace("hl-","");
  console.log("container: " + container);

  var details = jQuery('div[id*="details-' + container + '"]');
  console.log("html: '" + details.html() + "'");

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
	console.log(msg);
	details.html(msg.responseText);}
    });
  } else {
    details.html('');
  }
}

$(document).ready(function(){
  $(".container-hl").each(function(i,elem){
    //console.log("elem id: "+ i +" :: " + $(elem).attr("id"));
    $(elem).on('click',load_and_update);
  });
});

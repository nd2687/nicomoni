$(document).on("ready page:load", function() {
  $(function() {
    setTimeout(function() {
      $('#flashAlert').slideUp("slow");
    }, 7500);
  });

  $(window).mousemove(function(e){
    var client_pos_x = e.clientX,
        client_pos_y = e.clientY;
    if(client_pos_x < 170 && client_pos_y < 300){
      $('#menuLink').slideDown('slow');
    }
    else {
      $('#menuLink').fadeOut('slow');
    }
  });
});

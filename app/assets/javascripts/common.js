$(document).on("ready page:load", function() {
  $(function() {
    setTimeout(function() {
      $('#flashAlert').slideUp("slow");
    }, 7500);
  });

  var menu        = $('#menu'),
      menu_open   = $('#menuOpen'),
      menu_remove = $('#menuRemove');

  $('#menuLink').on('click', function() {
    if(menu.hasClass('open')) {
      menu.animate({'left': -150}, 300).removeClass('open');
      menu_remove.fadeOut('fast', function() {
        menu_open.fadeIn('fast');
      });
    } else {
      menu.animate({'left': 0}, 300).addClass('open');
      menu_open.fadeOut('fast', function() {
        menu_remove.fadeIn('fast');
      });
    }
  });
});

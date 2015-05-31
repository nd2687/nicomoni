$(document).on("ready page:load", function() {
  var form  = $(document).find("form#new_broadcast"),
      count = 0;

  form.bind("ajax:success", function(e, data, status, xhr) {
    if(data[0] === "<"){ return false; }
    var player_url  = data[0].player_url,
        src         = player_url + "&#38;amp;languagecode=ja&#45;jp",
        iframeblock = $('<iframe src="' + src + '" frameborder="0" height="488px" width="960px">'),
        embedblock  = $('<embed type="application/x&#45;shockwave&#45;flash" src="' + src + '" name="plugin" height="100%" width="100%">');
    if(count === 0){
      $('.broadcastsField').prepend(iframeblock.append(embedblock));
    } else {
      $('.broadcastsField').append(iframeblock.append(embedblock));
    }
    count += 1;
    if(count === 2){ form.parents('.prepareblock').remove(); }
  });

  form.bind("ajax:error", function(e, data, status, xhr) {
    alert("error");
  });

  var change_aspect_form = $('#change_aspect_form');
  $('#aspect_ratio').change(function() { change_aspect_form.submit(); });
  change_aspect_form.bind("ajax:success", function(e, data, status, xhr) {
    $('.broadcastsField').find('iframe').attr('width', data[0]).attr('height', data[1]);
  });
});

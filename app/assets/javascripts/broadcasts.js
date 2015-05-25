$(document).on("ready page:load", function() {
  var form  = $(document).find("form#new_broadcast"),
      count = 0;

  form.bind("ajax:success", function(e, data, status, xhr) {
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
  })
});

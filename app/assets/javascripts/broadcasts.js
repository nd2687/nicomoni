function broadcasting() {
  var form  = $(document).find("form#new_broadcast");

  form.bind("ajax:success", function(e, data, status, xhr) {
    var broadcast = data[0];
    if(broadcast === "<"){ return false; }

    if(broadcast.platform === "niconico") {
      var room        = data[1],
          token       = data[2],
          community   = data[3],
          open_time   = data[4],
          player_url  = broadcast.player_url,
          src         = player_url + "&#38;amp;languagecode=ja&#45;jp",
          iframeblock = $('<iframe src="' + src + '" frameborder="0" height="488px" width="960px" id="'+broadcast.id+'">'),
          embedblock  = $('<embed type="application/x&#45;shockwave&#45;flash" src="' + src + '" name="plugin" height="100%" width="100%">');

      two_screen(form, iframeblock, embedblock);

      var url = "http://icon.nimg.jp/community/s/"+community;
      remove_cast_btn(room, broadcast, token, url, open_time, community);
    }
    else if(broadcast.platform === "twitcasting") {
      var room        = data[1],
          token       = data[2],
          userid      = data[3],
          open_time   = data[4],
          player_url  = broadcast.player_url,
          src         = player_url,
          iframeblock = $('<iframe src="' + src + '" frameborder="0" height="488px" width="960px" id="'+broadcast.id+'">'),
          embedblock  = $('<embed type="application/x&#45;shockwave&#45;flash" src="' + src + '" name="plugin" height="100%" width="100%">');

      two_screen(form, iframeblock, embedblock);

      var url = "http://api.twitcasting.tv/api/userstatus?user="+userid;
      var image_url = "";
      get_user_image(url).done(function(json){
        image_url = json.image;
        remove_cast_btn(room, broadcast, token, image_url, open_time, userid);
      }).fail(function(json){
        console.log("error");
        remove_cast_btn(room, broadcast, token, image_url, open_time, userid);
      });
    }

    $('#broadcast_url').val('');
  });

  form.bind("ajax:error", function(e, data, status, xhr) {
    alert("error");
  });
}

function get_user_image(url){
  return $.ajax({
    type: 'GET',
    url: url,
    dataType: 'jsonp',
  });
}

function remove_cast_btn(room, broadcast, token, url, open_time, link_info){
  var site_link
  if(broadcast.platform === "niconico"){
    site_link = "http://com.nicovideo.jp/community/"+link_info
  }
  else if(broadcast.platform === "twitcasting"){
    site_link = "http://twitcasting.tv/"+link_info
  }
  var id = broadcast.id;
  var removeButton    = $('<form class="button_to" action="/rooms/'+room.url_token+'/remove_broadcast" method="post">'),
      hiddenBlock     = $('<input type="hidden" value="patch" name="_method">'),
      hiddenBlock2    = $('<input type="hidden" value="'+id+'" name="id">'),
      hiddenBlock3    = $('<input type="hidden" value="'+token+'" name="authenticity_token">'),
      buttonBlock     = $('<input type="submit" class="RemoveButton InInfoField" id="'+id+'" value="取り消し">'),
      thumbnail       = $('<a href="'+site_link+'" target="_blank"><img alt="'+url+'" src="'+url+'"></a>'),
      thumbnail_block = $('<div class="CommunityThumbnail">');
  $('.BroadcastInfoBlock').append(thumbnail_block.append(thumbnail).append(removeButton.append(hiddenBlock).append(buttonBlock).append(hiddenBlock2).append(hiddenBlock3)).append(open_time));
}

function two_screen(form, iframeblock, embedblock){
  var count = 0;
  if(count === 0){
    $('.broadcastsField').prepend(iframeblock.append(embedblock));
  } else {
    $('.broadcastsField').append(iframeblock.append(embedblock));
  }
  count += 1;
  if(count === 2){ form.parents('.prepareblock').remove(); }
}

function room_field_toggle() {
  $('.RoomInfoField').on('click', function() {
    $(this).slideUp( function () {
      $('#RoomInfoTrigger').fadeIn();
    });
  });

  $('#RoomInfoTrigger').on('click', function() {
    $(this).fadeOut('fast', function(){
      $('.RoomInfoField').slideDown();
    });
  });
}

function change_aspect() {
  var change_aspect_form = $('#change_aspect_form');
  $('#aspect_ratio').change(function() { change_aspect_form.submit(); });
  change_aspect_form.bind("ajax:success", function(e, data, status, xhr) {
    $('.broadcastsField').find('iframe').attr('width', data[0]).attr('height', data[1]);
  });

  change_aspect_form.bind("ajax:error", function(e, data, status, xhr) {
    alert('error');
  });
}

function user_link() {
  $('.UserLinkImage').on('click', function() {
    window.open(this.href, 300, 200);
    return false;
  });
}

function propagation() {
  $('#aspect_ratio1').on('click', function(e){ e.stopPropagation(); });
  $('.InInfoField').on('click', function(e) { e.stopPropagation(); });
  $('.CommunityThumbnail').on('click', function(e) { e.stopPropagation(); });
}


$(document).on("ready page:load", function() {
  broadcasting();
  change_aspect();
  user_link();
  room_field_toggle();
  propagation();
});


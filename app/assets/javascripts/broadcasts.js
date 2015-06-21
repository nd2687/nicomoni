$(document).on("ready page:load", function() {
  var form  = $(document).find("form#new_broadcast"),
      count = 0;

  form.bind("ajax:success", function(e, data, status, xhr) {
    var broadcast = data[0],
        room      = data[1],
        token     = data[2],
        community = data[3],
        base_time = data[4];

    if(broadcast === "<"){ return false; }
    var player_url  = broadcast.player_url,
        src         = player_url + "&#38;amp;languagecode=ja&#45;jp",
        iframeblock = $('<iframe src="' + src + '" frameborder="0" height="488px" width="960px" id="'+broadcast.id+'">'),
        embedblock  = $('<embed type="application/x&#45;shockwave&#45;flash" src="' + src + '" name="plugin" height="100%" width="100%">');
    if(count === 0){
      $('.broadcastsField').prepend(iframeblock.append(embedblock));
    } else {
      $('.broadcastsField').append(iframeblock.append(embedblock));
    }
    count += 1;
    if(count === 2){ form.parents('.prepareblock').remove(); }

    var id = broadcast.id;
    var removeButton    = $('<form class="button_to" action="/rooms/'+room.url_token+'/remove_broadcast" method="post">'),
        hiddenBlock     = $('<input type="hidden" value="patch" name="_method">'),
        hiddenBlock2    = $('<input type="hidden" value="'+id+'" name="id">'),
        hiddenBlock3    = $('<input type="hidden" value="'+token+'" name="authenticity_token">'),
        buttonBlock     = $('<input type="submit" class="RemoveButton InInfoField" id="'+id+'" value="取り消し">'),
        thumbnail       = $('<img alt="'+community+'" src="http://icon.nimg.jp/community/s/'+community+'">'),
        open_time       = base_time,
        thumbnail_block = $('<div class="CommunityThumbnail">');
    $('.BroadcastInfoBlock').append(thumbnail_block.append(thumbnail).append(removeButton.append(hiddenBlock).append(buttonBlock).append(hiddenBlock2).append(hiddenBlock3)).append(open_time));
  });

  $('.RemoveButton').mouseover(function() {
    var id = $(this).attr('id');
    $('.broadcastsField').find('#'+id).wrap('<div class="ButtonFilter">');
  }).mouseout(function() {
    var id = $(this).attr('id');
    $('.broadcastsField').find('#'+id).unwrap();
  });

  form.bind("ajax:error", function(e, data, status, xhr) {
    alert("error");
  });

  var change_aspect_form = $('#change_aspect_form');
  $('#aspect_ratio').change(function() { change_aspect_form.submit(); });
  change_aspect_form.bind("ajax:success", function(e, data, status, xhr) {
    $('.broadcastsField').find('iframe').attr('width', data[0]).attr('height', data[1]);
  });

  change_aspect_form.bind("ajax:error", function(e, data, status, xhr) {
    alert('error');
  });

  $('.UserLinkImage').on('click', function() {
    window.open(this.href, 300, 200);
    return false;
  });

  $('#aspect_ratio1').click(function(e){
    e.stopPropagation();
  });

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

  $('.InInfoField').on('click', function(e) { e.stopPropagation(); });
});


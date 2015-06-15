$(document).on("ready page:load", function() {
  var form  = $(document).find("form#new_broadcast"),
      count = 0;

  form.bind("ajax:success", function(e, data, status, xhr) {
    if(data[0] === "<"){ return false; }
    var player_url  = data[0].player_url,
        src         = player_url + "&#38;amp;languagecode=ja&#45;jp",
        iframeblock = $('<iframe src="' + src + '" frameborder="0" height="488px" width="960px" id="'+data[0].id+'">'),
        embedblock  = $('<embed type="application/x&#45;shockwave&#45;flash" src="' + src + '" name="plugin" height="100%" width="100%">');
    if(count === 0){
      $('.broadcastsField').prepend(iframeblock.append(embedblock));
    } else {
      $('.broadcastsField').append(iframeblock.append(embedblock));
    }
    count += 1;
    if(count === 2){ form.parents('.prepareblock').remove(); }

    var id = data[0].id;
    var removeButton = $('<form class="button_to" action="/rooms/'+data[1].url_token+'/remove_broadcast" method="post">'),
        hiddenBlock  = $('<input type="hidden" value="patch" name="_method">'),
        hiddenBlock2 = $('<input type="hidden" value="'+id+'" name="id">'),
        hiddenBlock3 = $('<input type="hidden" value="'+data[2]+'" name="authenticity_token">'),
        buttonBlock  = $('<input type="submit" id="'+id+'" value="'+id+'ちゃんを消す">');
    $('.ownerBlock').append(removeButton.append(hiddenBlock).append(buttonBlock).append(hiddenBlock2).append(hiddenBlock3));
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
    if($(this).hasClass('infoClosed')){
      $(this).removeClass('infoClosed').animate({'opacity': '1'}, 'fast');
    } else {
      $(this).addClass('infoClosed').animate({'opacity': '0.15'}, 'fast');
    }
  });

  $('.InInfoField').on('click', function(e) { e.stopPropagation(); });
});


$(document).on("ready page:load", function(){
  var form = $('#new_response');
  form.bind("ajax:success", function(e, data, status, xhr){
    var comment      = data[0].comment,
        name         = data[0].name,
        created_at   = data[1],
        index        = data[2],
        comment_body = "";

    comment = comment.replace(/\r\n/g, '\n');
    comment = comment.replace(/\r/g, '\n');
    comment = comment.split('\n');
    $.each(comment, function(i, value){
      if(0<=i && i+1 != comment.length){
        comment_body += value + "<br>"
      }else{
        if(i+1 == comment.length){ comment_body += value }
      }
    });

    if(data === false){ console.log("error"); return false; }
    var ul = $('.ResponseList');
    ul.append('<li style="list-style:none;">'+ index+ ' '+ name +' <i class="fa fa-pencil"></i> '+ created_at +'<h4 style="color:#3d4eb7">'+ comment_body +'</h4></li>');
  });

  form.bind("ajax:error", function(e, data, status, xhr){
    console.log("error");
  });
});

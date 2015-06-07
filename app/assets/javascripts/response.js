$(document).on("ready page:load", function(){
  var form = $('#new_response');
  form.bind("ajax:success", function(e, data, status, xhr){
    if(data === false){ console.log("error"); return false; }
    var ul = $('.ResponseList');
    ul.append('<li>'+ data.name + ' ' + data.comment + '</li>');
  });

  form.bind("ajax:error", function(e, data, status, xhr){
    console.log("error");
  });
});

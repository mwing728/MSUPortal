$(document).ready(function(){ 
    $('#btn').click(function(){
        console.log($('#q-id').text())
        $.ajax({
                type: "POST",
                contentType: "application/json;",
                url: "/questions",
                data: JSON.stringify($('#q-id').text()),
                dataType: "json"
            });
    });
  });
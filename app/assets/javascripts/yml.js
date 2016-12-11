$(function() {
  console.log('im here')

  var hidden_data = $("#hidden_data_yml")
  hidden_data.data('orderidset', false)

  $("#input-700").on('fileloaded', function(event) {
    if(hidden_data.data("orderidset") == false){
      $.post( hidden_data.data("ymlorderpath"), function(response_data){
        console.log("data:", response_data)
        var new_url = hidden_data.data("ymlpath").replace("__REPLACE__", response_data.id)
        hidden_data.data("ymlpath", new_url)
        hidden_data.data("orderid", response_data.id)
        hidden_data.data("orderidset", true)
        
      })    
    }
  });

  $("#input-700").fileinput({
    uploadUrl: hidden_data.data("ymlpath"), // server upload action
    uploadAsync: true,
    allowedFileExtensions: ['yml', 'yaml', 'xls', 'xlsx'],
    maxFileCount: 100,
    uploadExtraData: function() {
      return {"order_id":  $("#hidden_data_yml").data("orderid"), "count_files": $("#input-700").fileinput('getFileStack').length, "type": $("#hidden_data_yml").data("type"), "targettype": $("#hidden_data_yml").data("targettype")}
    }
      
  })


  $("#input-700").on('filebatchuploadcomplete', function(event, files, extra) {
      // Turbolinks.clearCache() 
      // Turbolinks.visit(window.location.origin + "/yml/" + extra.order_id.toString() + ".xls")
      window.location.href = window.location.origin + "/" + extra.type.toString() + "/" + extra.order_id.toString() + "." + extra.targettype.toString()
      console.log('File batch upload success');
  });
 
})
$(function() {
  var url   = location.href;
  if(url.indexOf('?') != -1) {
    params    = url.split("?");
    spparams   = params[1].split("&");
    
    var paramArray = [];
    
    for ( i = 0; i < spparams.length; i++ ) {
      vol = spparams[i].split("=");
      paramArray.push(vol[0]);
      paramArray[vol[0]] = vol[1];
    }

    sort_param = paramArray["q%5Bs%5D"];

    switch(sort_param) {
      case 'created_at+desc':
        $('#sort_select').val('created_desc');
      break;
      case 'created_at+asc':
        $('#sort_select').val('created_asc');
      break;
      case 'ikes_count+desc':
        $('#sort_select').val('like');
      break;
    }
  }

  $('#sort_select').change(function() {
    var val = $(this).val();
    switch(val) {
      case 'created_desc':
      $('#sort_link_created_at_desc')[0].click();
      break;
      case 'created_asc':
      $('#sort_link_created_at_asc')[0].click();
      break;
      case 'like':
      $('#sort_link_like')[0].click();
      break;
    }
  });
});

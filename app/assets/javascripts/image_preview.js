$(function(){
  $fileField = $('#file')
  // 選択された画像をプレビュー
  $($fileField).on('change', $fileField, function(e) {
    $preview = $("#img_field");
    $preview.empty();
    for (var i=0; i<e.target.files.length; i++) {
      file = e.target.files[i]
      reader = new FileReader();

      reader.onload = (function(file) {
        return function(e) {
          var preview_item = $('<div class="preview_item">').css('background', 'transparent url('+e.target.result +')').append($('<div class="file-name">' + file.name + '</div>'));
          $preview.append(preview_item)
        };
      })(file);
      reader.readAsDataURL(file);
    }
  });
});
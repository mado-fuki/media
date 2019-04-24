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
          $preview.append($('<img>').attr({
            src: e.target.result,
            width: "100%",
            class: "preview",
            title: file.name
          }));
        };
      })(file);
      reader.readAsDataURL(file);
    }
  });
});
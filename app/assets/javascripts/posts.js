$(function() {
  images_preview();

  var title_valid = false;
  var content_valid = false;
  var images_valid = false;

  if ($('#title').val().length == 0) {
    $('#submit_btn').prop('disabled', true);
  }

  $('#file').on('keydown keyup keypress change', function() {
    if ( $(this).val().length > 0) {
      images_valid = true;
    } else {
      images_valid = false;
    }
    flag_check();
  });

  $('#title').on('keydown keyup keypress change', function() {
    if ( $(this).val().length > 0 && $(this).val().length <= 30) {
      $('#title').removeClass('valid-error-input');
      $('#title_error_message').text('');
      title_valid = true;
    } else {
      $('#title').addClass('valid-error-input');
      title_valid = false;
    }
    flag_check();
  });

  $('#title').on('keyup change', function() {
    if(title_valid == false) {
      if ( $(this).val().length <= 0) {
        $('#title_error_message').text('1文字以上入力してください。');
      } else if ( $(this).val().length > 30) {
        $('#title_error_message').text('30文字以下で入力してください。');
      }
    }
  });

  $('#content').on('keydown keyup keypress change', function() {
    if ( $(this).val().length > 0 && $(this).val().length <= 300) {
      content_valid = true;
    } else {
      content_valid = false;
    }
    flag_check();
  });

  $('#content').on('keydown keyup keypress change', function() {
    if ( $(this).val().length > 0 && $(this).val().length <= 300) {
      $('#content').removeClass('valid-error-input');
      $('#content_error_message').text('');
      content_valid = true;
    } else {
      $('#content').addClass('valid-error-input');
      content_valid = false;
    }
    flag_check();
  });

  $('#content').on('keyup change', function() {
    if(content_valid == false) {
      if ( $(this).val().length <= 0) {
        $('#content_error_message').text('1文字以上入力してください。');
      } else if ( $(this).val().length > 30) {
        $('#content_error_message').text('300文字以下で入力してください。');
      }
    }
  });

  // 選択された画像をプレビュー
  function images_preview() {
    $fileField = $('#file')
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
  }

  //全てのフォームが有効ならsubmitボタンを有効にする
  function flag_check() {
    if(title_valid == true && content_valid == true && images_valid == true) {
      $('#submit_btn').prop('disabled', false);
    } else {
      $('#submit_btn').prop('disabled', true);
    }
  }
});
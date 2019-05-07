let title_valid = false;
let content_valid = false;
let images_valid = false;
const FILE_SIZE_LIMIT = 33554432;

$(function() {
  //enterキーでのsubmitを無効化
  $(document).on("keypress", "input:not(.allow_submit)", function(event) {
    return event.which !== 13;
  });

  $('#submit_btn').prop('disabled', true);

  if ($('#edit_title').val().length > 0 && $('#edit_title').val().length <= 32) {
    title_valid = true;
  }
  if ($('#edit_content').val().length > 0 && $('#edit_content').val().length <= 300) {
    content_valid = true;
  }
  edit_flag_check();
  

  $('#edit_title').on('keyup change', function() {
    title_form_add_error_message($('#edit_title'));
    edit_flag_check();
  });
  
  $('#edit_content').on('keyup change', function() {
    content_form_add_error_message($('#edit_content'));
    edit_flag_check();
  });
});

images_preview();
flag_check();

$('#title').on('keyup change', function() {
  title_form_add_error_message($('#title'));
  flag_check();
});

$('#content').on('keyup change', function() {
  content_form_add_error_message($('#content'));
  flag_check();
});

// 選択された画像をプレビュー
function images_preview() {
  $('#file').on('change', $('#file'), function(e) {
    $preview = $('#img_field');
    $preview.empty();
    $('#img_field_error_message').text('');
    let file_error_flag = false;
    if(e.target.files.length > 6) {
      $('#img_field_error_message').text('画像は６枚までです。');
    } else {
      for (var i=0; i<e.target.files.length; i++) {
        if(i == 0) {
          file_error_flag = true;
        }
        file = e.target.files[i];
        reader = new FileReader();
        reader.onload = (function(file) {
          return function(e) {
            var preview_item = $('<div class="preview_item">').css('background', 'transparent url('+e.target.result +')').append($('<div class="file-name">' + file.name + '</div>'));
            // ファイルサイズが上限を超えていたらエラーメッセージを表示する。
            if(file.size > FILE_SIZE_LIMIT) {
              $('#img_field_error_message').text('32MB以上のファイルが選択されています。');
              preview_item.addClass('border-red');
              file_error_flag = false;
              file_error_flag_check(file_error_flag);
            }
            file_error_flag_check(file_error_flag);
            flag_check();
            $preview.append(preview_item);
          };
        })(file);
        reader.readAsDataURL(file);
      }
    }
    file_error_flag_check(file_error_flag);
    flag_check();
  });
}


function title_form_add_error_message(title) {
  $title = title;
  if ($title.val().length > 0 && $title.val().length <= 32) {
    $title.removeClass('valid-error-input');
    $('#title_error_message').text('');
    title_valid = true;
  } else {
    $title.addClass('valid-error-input');
    title_valid = false;
  }
  if(title_valid  == false) {
    if ( $title.val().length <= 0) {
      $('#title_error_message').text('1文字以上入力してください。');
    } else if ( $title.val().length > 32) {
      $('#title_error_message').text('32文字以下で入力してください。');
    }
  }
}

function content_form_add_error_message(content) {
  $content = content;
  if ($content.val().length > 0 && $content.val().length <= 300) {
    $content.removeClass('valid-error-input');
    $('#content_error_message').text('');
    content_valid = true;
  } else {
    $content.addClass('valid-error-input');
    content_valid = false;
  }
  if(content_valid == false) {
    if ($content.val().length <= 0) {
      $('#content_error_message').text('1文字以上入力してください。');
    } else if ( $content.val().length > 300) {
      $('#content_error_message').text('300文字以下で入力してください。');
    }
  }
}

function file_error_flag_check(file_error_flag) {
  if(file_error_flag == true) {
      images_valid = true;
    } else {
      images_valid = false;
    }
}

// posts/id/newの全てのフォームが有効ならsubmitボタンを有効にする
function flag_check() {
  if(title_valid == true && content_valid == true && images_valid == true) {
    $('#submit_btn').prop('disabled', false);
  } else {
    $('#submit_btn').prop('disabled', true);
  }
}

// posts/id/editの全てのフォームが有効ならsubmitボタンを有効にする
function edit_flag_check() {
  if(title_valid == true && content_valid == true) {
    $('#submit_btn').prop('disabled', false);
  } else {
    $('#submit_btn').prop('disabled', true);
  }
}
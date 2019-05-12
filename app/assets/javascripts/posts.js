let title_valid = false;
let content_valid = false;
let images_valid = false;
let edit_images_valid = false;
const IMAGE_FILE_SIZE_LIMIT = 33554432;

$(function() {

  $submit_btn = $('#images_submit_btn');
  $edit_images_submit_btn = $('#edit_images_submit_btn');
  
  $submit_btn.prop('disabled', true);
  $edit_images_submit_btn.prop('disabled', true);

  images_preview('.images_field');
  images_preview('.edit_images_field');
  flag_check();

  if(document.getElementById("edit_title") != null) {
    if ($('#edit_title').val().length > 0 && $('#edit_title').val().length <= 32) {
      title_valid = true;
    }
    if ($('#edit_content').val().length > 0 && $('#edit_content').val().length <= 300) {
      content_valid = true;
    }
    edit_text_flag_check();
  }

  $('#title').on('keyup change', function() {
    title_form_add_error_message($('#title'));
    flag_check();
  });
  
  $('#content').on('keyup change', function() {
    content_form_add_error_message($('#content'));
    flag_check();
  });
  

  $('#edit_title').on('keyup change', function() {
    title_form_add_error_message($('#edit_title'));
    edit_text_flag_check();
  });
  
  $('#edit_content').on('keyup change', function() {
    content_form_add_error_message($('#edit_content'));
    edit_text_flag_check();
  });
});

// 選択された画像をプレビュー
function images_preview(field) {
  $(field).on('change', $(field), function(e) {
    $preview = $('#images_preview_field');
    $error_message = $('#images_preview_error_message');
    $preview.empty();
    $error_message.text('');
    let file_error_flag = false;
    if(e.target.files.length > 6) {
      $error_message.text('画像は６枚までです。');
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
            if(file.size > IMAGE_FILE_SIZE_LIMIT) {
              $error_message.text('32MB以上のファイルが選択されています。');
              preview_item.addClass('border-red');
              file_error_flag = false;
              file_error_flag_check(file_error_flag);
            }
            file_error_flag_check(file_error_flag);
            flag_check();
            edit_images_flag_check();
            $preview.append(preview_item);
          };
        })(file);
        reader.readAsDataURL(file);
      }
    }
    file_error_flag_check(file_error_flag);
    flag_check();
    edit_images_flag_check();
  });
}


function title_form_add_error_message(title) {
  $title = title;
  $error_message = $('#post_title_error_message');
  if ($title.val().length > 0 && $title.val().length <= 32) {
    $title.removeClass('valid-error-input');
    $error_message.text('');
    title_valid = true;
  } else {
    $title.addClass('valid-error-input');
    title_valid = false;
  }
  if(title_valid  == false) {
    if ( $title.val().length <= 0) {
      $error_message.text('1文字以上入力してください。');
    } else if ( $title.val().length > 32) {
      $error_message.text('32文字以下で入力してください。');
    }
  }
}

function content_form_add_error_message(content) {
  $content = content;
  $error_message = $('#post_content_error_message');
  if ($content.val().length > 0 && $content.val().length <= 300) {
    $content.removeClass('valid-error-input');
    $error_message.text('');
    content_valid = true;
  } else {
    $content.addClass('valid-error-input');
    content_valid = false;
  }
  if(content_valid == false) {
    if ($content.val().length <= 0) {
      $error_message.text('1文字以上入力してください。');
    } else if ( $content.val().length > 300) {
      $error_message.text('300文字以下で入力してください。');
    }
  }
}

function file_error_flag_check(file_error_flag) {
  if(file_error_flag == true) {
      images_valid = true;
      edit_images_valid = true;
    } else {
      images_valid = false;
      edit_images_valid = false;
    }
}

// posts/id/newの全てのフォームが有効ならsubmitボタンを有効にする
function flag_check() {
  if(title_valid == true && content_valid == true && images_valid == true) {
    $submit_btn.prop('disabled', false);
  } else {
    $submit_btn.prop('disabled', true);
  }
}

// posts/id/editの全てのフォームが有効ならsubmitボタンを有効にする
function edit_text_flag_check() {
  if(title_valid == true && content_valid == true) {
    $edit_images_submit_btn.prop('disabled', false);
  } else {
    $edit_images_submit_btn.prop('disabled', true);
  }
}

function edit_images_flag_check() {
  if(edit_images_valid == true) {
    $edit_images_submit_btn.prop('disabled', false);
  } else {
    $edit_images_submit_btn.prop('disabled', true);
  }
}
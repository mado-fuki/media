let avater_file_error_flag = false;
const AVATAR_FILE_SIZE_LIMIT = 33554432;

$(function() {
  $('#avater_submit_btn').prop('disabled', true);
  avarter_preview();
});

// アバター画像をプレビュー
function avarter_preview() {
  $('#file').on('change', $('#file'), function(e) {
    $preview = $('#avater_field');
    $preview.empty();
    if (e.target.files.length == 1) {
      file = e.target.files[0];
      // ファイルサイズが上限を超えていたらエラーメッセージを表示する。
      if(file.size > AVATAR_FILE_SIZE_LIMIT) {
        $('#avater_field_error_message').text('32MB以上のファイルが選択されています。');
        avater_file_error_flag = false;
      } else {
        $('#avater_field_error_message').text('');
        $preview.append($('<span>' + file.name + '</span>'))
        avater_file_error_flag = true;
      }
    } else if(e.target.files.length > 1) {
      $('#avater_field_error_message').text('選択できる画像は1枚です。');
      avater_file_error_flag = false;
    } else if(e.target.files.length == 0) {
      $('#avater_field_error_message').text('');
      avater_file_error_flag = false;
    }
    edit_images_flag_check();
  });
}

function edit_images_flag_check() {
  if(avater_file_error_flag == true) {
    $('#avater_submit_btn').prop('disabled', false);
  } else {
    $('#avater_submit_btn').prop('disabled', true);
  }
}
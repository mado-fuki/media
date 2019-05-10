let avater_file_error_flag = false;
const AVATAR_FILE_SIZE_LIMIT = 33554432;

$(function() {
  $('#avater_submit_btn').prop('disabled', true);
  avartar_file_validate();
});

// アバター画像をプレビュー
function avartar_file_validate() {
  $('#edit_avater_file_field').on('change', $('#edit_avater_file_field'), function(e) {
    $message = $('#edit_avatar_message')
    $error_message = $('#edit_avatar_error_message');
    if (e.target.files.length == 1) {
      file = e.target.files[0];
      // ファイルサイズが上限を超えていたらエラーメッセージを表示する。
      if(file.size > AVATAR_FILE_SIZE_LIMIT) {
        $error_message.text('32MB以上のファイルが選択されています。');
        $$message.text('');
        avater_file_error_flag = false;
      } else {
        $error_message.text('');
        $message.text(file.name);
        avater_file_error_flag = true;
      }
    } else if(e.target.files.length > 1) {
      $error_message.text('選択できる画像は1枚です。');
      $message.text('');
      avater_file_error_flag = false;
    } else if(e.target.files.length == 0) {
      $error_message.text('');
      $message.text('');
      avater_file_error_flag = false;
    }
    edit_avater_flag_check();
  });
}

function edit_avater_flag_check() {
  if(avater_file_error_flag == true) {
    $('#avater_submit_btn').prop('disabled', false);
  } else {
    $('#avater_submit_btn').prop('disabled', true);
  }
}
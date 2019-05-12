$(function() {
  //enterキーでのsubmitを無効化
  $(document).on("keypress", "input:not(.allow_submit)", function(event) {
    return event.which !== 13;
  });
});
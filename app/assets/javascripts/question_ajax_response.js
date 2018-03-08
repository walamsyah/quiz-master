$(document).ready(function() {
  return $("#question-form").on("ajax:success", function(event) {
    ref = event.detail, data = ref[0], status = ref[1], xhr = ref[2];
    return $("#quiz-show__questions-container").html(xhr.responseText);
  });
});

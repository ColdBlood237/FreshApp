$(".modify-comment").on("click", function () {
  let commentTextParagraph = $("#comment-" + this.id);
  let commentModifyForm = $("#modify-comment-form-" + this.id);
  commentTextParagraph.addClass("hidden");
  commentModifyForm.removeClass("hidden");
});

$(".cancel-modification").on("click", function () {
  let commentTextParagraph = $(
    "#comment-" + this.id.charAt(this.id.length - 1)
  );
  let commentModifyForm = $(
    "#modify-comment-form-" + this.id.charAt(this.id.length - 1)
  );
  let commentTextArea = commentModifyForm.find("textarea");
  commentTextArea.val(commentTextParagraph.text().trim());
  commentTextParagraph.removeClass("hidden");
  commentModifyForm.addClass("hidden");
});

$("textarea")
  .each(function () {
    this.setAttribute(
      "style",
      "height:" + this.scrollHeight + "px;overflow-y:hidden;"
    );
  })
  .on("input", function () {
    this.style.height = 0;
    this.style.height = this.scrollHeight + "px";
  });

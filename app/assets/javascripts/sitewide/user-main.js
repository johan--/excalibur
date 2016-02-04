$(".interface").on("click", function() {
    var $this = $(this);
    if ($this.hasClass("active")) {
        $this.removeClass("active").addClass("aaaR").prependTo("#groupR");
    } else {
        $this.removeClass("active").addClass("aaaL").prependTo("#groupL");
    }
});
$("#button").click(function() {
    $('html, body').animate({
        scrollTop: $("#button-scroll").offset().top
    }, 2000);
});

$("#button-home-age").click(function() {
    $('html, body').animate({
        scrollTop: $("#instructions").offset().top
    }, 2000);
});

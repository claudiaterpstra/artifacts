$("#button").click(function() {
    $('html, body').animate({
        scrollTop: $("#button-scroll").offset().top
    }, 2000);
});

$("#button-home-page").click(function() {
    $('html, body').animate({
        scrollTop: $("#button-scroll").offset().top
    }, 1500);
});

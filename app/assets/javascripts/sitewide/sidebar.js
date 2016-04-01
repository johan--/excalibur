$(document).ready(function() {

    // $('.menu-toggle').click(function(e){

    //     var menu = $(this).data('show-dialog');

    //     $('.' + menu).toggleClass('side-menu-shown');

    // });

    // $('.side-menu-close').on('click', function () {
    //     $('.side-menu-advanced').removeClass('side-menu-shown');
    // });

    // $('.side-menu-option').on('click', function (e) {
    //     e.preventDefault();

    //     var option = $(this).data('id');

    //     alert('You chose option ' + option);
    // });

    // $('.side-menu-button').on('click', function (e) {
    //     e.preventDefault();

    //     var buttonFunction = $(this).data('function');

    //     alert('You clicked the ' + buttonFunction + ' button.');
    // })

    $('a[disabled=disabled]').click(function(event){
        event.preventDefault(); // Prevent link from following its href
    });
});
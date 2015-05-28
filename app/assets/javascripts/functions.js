function extractCategory() {
  var arr = [];
  $('.jsMenuItem.is-checked input').each(function() {
    arr.push(parseInt($(this).attr("category")));
  });
  return arr;
}

$( document ).ready(function() {

  console.log('I\'m ready');

  $('.jsOpenNav').click(function(event) {
    event.preventDefault();
    $('.jsNav').toggle();
    $('.jsBar').toggleClass('is-active');
    $('body').toggleClass('offMenu');
  });

  $('.jsMenuItem').click(function(event) {
    event.preventDefault();
    $(this).toggleClass('is-checked');
    if ($(this).hasClass('jsMenuItemMain')) {
      if ($(this).hasClass('is-checked')) {
        $('.jsMenuItem').addClass('is-checked');
      }
      else{
        $('.jsMenuItem').removeClass('is-checked');
      }
    };
  });

  $('.jsAdd').click(function(event) {
    event.preventDefault();
    $('.jsAddSection').fadeIn();
    $('body, html').addClass('overflow')
  });

  document.getElementById("customButton").addEventListener("click", function(){
    document.getElementById("offer_image").click();  // trigger the click of actual file upload button
  });

  document.getElementById("offer_image").addEventListener("change", function(){
    var fullPath = document.getElementById('offer_image').value;
    var fileName = fullPath.split(/(\\|\/)/g).pop();  // fetch the file name
    document.getElementById("fileName").innerHTML = fileName;  // display the file name
  }, false);

  $('#categorySubmit').click(function() {
    $(this).attr('disabled', 'disabled');
    extractCategory();
    $.get( "ajax/test.html", function( data ) {
      $( ".result" ).html( data );
      alert( "Load was performed." );
    });
  });
});

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

  $('#offer_image').on('change', function(event) {
    var files = event.target.files;
    var image = files[0];
    var reader = new FileReader();
    reader.onload = function(file) {
      var img = new Image();
      console.log(file);
      img.src = file.target.result;
      $('#customButton').html(img);
    };
    reader.readAsDataURL(image);
    console.log(files);
  });

  $("#offer_price").keydown(function (e) {
    // Allow: backspace, delete, tab, escape, enter and .
    if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 110]) !== -1 ||
      // Allow: Ctrl+A
      (e.keyCode == 65 && e.ctrlKey === true) ||
      // Allow: Ctrl+C
      (e.keyCode == 67 && e.ctrlKey === true) ||
      // Allow: Ctrl+X
      (e.keyCode == 88 && e.ctrlKey === true) ||
      // Allow: home, end, left, right
      (e.keyCode >= 35 && e.keyCode <= 39)) {
      // let it happen, don't do anything
      return;
    }
    // Ensure that it is a number and stop the keypress
    if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
      e.preventDefault();
    }
  });
});

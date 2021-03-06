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
    $("#filter_form").prop("action", "/offers/nav");
    $("#filter_form").submit();
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

  $("#customButton").click(function() {
    $("#offer_image").click();
  });
  $("#offer_image").change(function () {
    var fullPath = $('#offer_image').prop("value");
    var fileName = fullPath.split(/(\\|\/)/g).pop();  // fetch the file name
    $("#fileName").innerHTML = fileName;  // display the file name
  });

  $('#categorySubmit').click(function(e) {
    $(this).attr('disabled', 'disabled');
    var cat_ids = extractCategory();
    console.log(cat_ids);
    $("#category_input").empty();
    $.each( cat_ids, function( key, value ) {
      $("#category_input").append('<input type="number" name="categories[]" value="' + value + '" />');
    });
    $("#filter_form").submit();
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

  $("#offer_price").keypress(function (e) {
    return (((event.which > 47) && (event.which < 58)) || (event.which == 13));
  });

  $("#offer_price").change(function (e) {
    this.value = this.value.replace(/[^0-9]+/g, '');
    if (this.value < 1) this.value = 0;
  });

  //add a function to jQuery so we can call it on our jQuery collections
  $.fn.capitalize = function () {

      //iterate through each of the elements passed in, `$.each()` is faster than `.each()
      $.each(this, function () {

          //split the value of this input by the spaces
          var split = this.value.split(' ');

          //iterate through each of the "words" and capitalize them
          for (var i = 0, len = split.length; i < len; i++) {
              split[i] = split[i].charAt(0).toUpperCase() + split[i].slice(1);
          }

          //re-join the string and set the value of the element
          this.value = split.join(' ');
      });
      return this;
  };

  //when the user presses a key and the value of the `textarea` is changed, the new value will have all capitalized words
  $('#offer_name').on('keyup', function () {
      $(this).capitalize();
  }).capitalize();//also capitalize the `textarea` element(s) on initialization
});

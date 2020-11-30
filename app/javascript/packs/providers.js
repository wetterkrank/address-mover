document.addEventListener("turbolinks: load", function() {
  console.log('This is loaded');
  var options = {
    data: ["John", "Paul", "George", "Ringo"]
  };
  $('#autocomplete').easyAutocomplete(options);

});
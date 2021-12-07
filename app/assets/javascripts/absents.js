jQuery(function() {
  const all_levels = $('#level_select').html();

  function updateLevels() {
    console.log($("#classtype_select option:selected").length)
    const classtype = $('#classtype_select :selected').text();
    const options = '<option value="" label=" "></option>' + $(all_levels).filter("optgroup[label=" + classtype + "]").html();
    if (options) {
      $('#level_select').html(options);
      return $('#level_select').prop("disabled", false);
    } else {
      $('#level_select').empty();
      return $('#level_select').prop("disabled", true);
    }
  }

  // if no classtype is selected
  console.log($("#classtype_select").val());
  if (!$("#classtype_select").val()){
    $('#level_select').prop("disabled", true);
  } else {
    updateLevels();
  }
  
  // update levels when classtype select changes
  $('#classtype_select').change(updateLevels);
});
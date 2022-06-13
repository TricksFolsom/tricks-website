jQuery(function() {
  const all_levels = $('#level_select').html();

  function updateLevels() {
    const classtype = $('#classtype_select :selected').text();

    let options = '<option value="" label=" "></option>';
    
    if (classtype == "Gymnastics")
    {
      // we also need to add all the tumblebunnies
      options = options + '<option value="" label="----- Tumblebunnies -----" disabled></option>'
      options = options + $(all_levels).filter("optgroup[label=Tumblebunnies]").html();
      options = options + '<option value="" label="----- School Aged -----" disabled></option>'
    }

    options = options + $(all_levels).filter("optgroup[label=" + classtype + "]").html();
    
    if (options) {
      $('#level_select').html(options);
      return $('#level_select').prop("disabled", false);
    } else {
      $('#level_select').empty();
      return $('#level_select').prop("disabled", true);
    }
  }

  // if no classtype is selected
  if (!$("#classtype_select").val()){
    $('#level_select').prop("disabled", true);
  } else {
    updateLevels();
  }
  
  // update levels when classtype select changes
  $('#classtype_select').change(updateLevels);
});
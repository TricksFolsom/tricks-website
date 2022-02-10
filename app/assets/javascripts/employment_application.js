var autoResizeImageContainers;
$(function() {
  $('#college_questions').hide();
  $('#high_school_year_question').hide();
  $('#employment_application_high_school_year').change(function() {
    if ($(this).find("option:selected").text() === 'Graduated') {
      $('#college_questions').show('slow');
      return $('#high_school_year_question').show('slow');
    } else {
      $('#college_questions').hide('slow');
      return $('#high_school_year_question').hide('slow');
    }
  });
  $('#do_not_contact_reason_question').hide();
  $('#is_it_ok_if_we_contact_your_previous_employer_switch').change(function() {
    if ($(this).is(":checked") === false) {
      return $('#do_not_contact_reason_question').show('slow');
    } else {
      return $('#do_not_contact_reason_question').hide('slow');
    }
  });
  $('#convictions_question').hide();
  $('#have_you_been_convicted_of_a_crime_in_the_last_7_years_switch').change(function() {
    if ($(this).is(":checked") === true) {
      return $('#convictions_question').show('slow');
    } else {
      return $('#convictions_question').hide('slow');
    }
  });
  $('#employment_application_image_new').change(function() {
    $('#employment_application_image_new').prev().addClass('success');
    return $('#employment_application_image_new').prev().html("Change Image");
  });
  $('#employment_application_resume_new').change(function() {
    $('#employment_application_resume_new').prev().addClass('success');
    return $('#employment_application_resume_new').prev().html("Change Resume");
  });

  // only focus the text box if is has already been selected recently
  const param = 'name_search=';
  const search_params = location.search;
  let result = search_params.indexOf(param);
  if (result >= 0){
    // param found, check if param is empty
    // console.log(search_params.charAt(result + param.length));
    // If I wanted to make sure the param was all the way gone, I could use the below check, but the scenario
    // where the param is present but empty is a case where I believe the user would still want to have the text box focused.
    // if (search_params.charAt(result + param.length) !== '&'){
      // A search param has been found
      $('#name_search_field').focus();
      $('#name_search_field')[0].selectionStart = $('#name_search_field')[0].selectionEnd = $('#name_search_field')[0].value.length;
    // }
  }

  let timeout;
  $('#name_search_field').on("input", () => {
      clearTimeout(timeout);
      timeout = setTimeout(() => {
        // This one auto submits the form so that the URL params are updated. Its a bit slower than AJAX updates, but it is persistent because of the params
        $(":submit")[0].click();

        // This one works, it live updates the search results, but does not set the url param, which means when you select another filter, it clears the search
        // and also that you cannot give someone a URL containing a search query.
        // return $.get(
        //   $('#applicant_search').attr('action'),
        //   $('#applicant_search').serialize(),
        //   null,
        //   'script'
        // );

        // This one was just test code trying out setting params using ajax, not sure if thats possible lol
        // $.ajax({
        //   url: '/employment_applications',
        //   type: 'PATCH',
        //   data: {search: $('#name_search_field').value}
        // })
      }, 400);
      return false;
  });

  return autoResizeImageContainers();
});

autoResizeImageContainers = function() {
  return $('.applicant_image_frame').each(function() {
    var obj;
    obj = $(this);
    return obj.height(obj.width() * 1.3712);
  });
};

$(window).resize(function() {
  return autoResizeImageContainers();
});

$(document).ajaxComplete(function() {
  return autoResizeImageContainers();
});
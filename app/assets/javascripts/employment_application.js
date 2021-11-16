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
    console.log("Here i am")
    $('#employment_application_image_new').prev().addClass('success');
    return $('#employment_application_image_new').prev().html("Change Image");
  });
  $('#employment_application_resume_new').change(function() {
    $('#employment_application_resume_new').prev().addClass('success');
    return $('#employment_application_resume_new').prev().html("Change Resume");
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
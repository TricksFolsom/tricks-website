var autoResizeImageContainers;

$(function() {
  // var departments_selected, locations_selected, toggle_history_questions;
  // locations_selected = 0;
  // $('#hidden_required_location').prop('required', true);
  // $('#select-location-container').find('.switch-button').each(function() {
  //   var obj;
  //   obj = $(this);
  //   return obj.click(function() {
  //     if (obj.prev().is(':checked')) {
  //       locations_selected--;
  //       if (locations_selected === 0) {
  //         return $('#hidden_required_location').prop('required', true);
  //       }
  //     } else {
  //       locations_selected++;
  //       return $('#hidden_required_location').prop('required', false);
  //     }
  //   });
  // });
  // departments_selected = 0;
  // $('#hidden_required_department').prop('required', true);
  // $('#select-department-container').find('.switch-button').each(function() {
  //   var obj;
  //   obj = $(this);
  //   return obj.click(function() {
  //     if (obj.prev().is(':checked')) {
  //       departments_selected--;
  //       if (departments_selected === 0) {
  //         return $('#hidden_required_department').prop('required', true);
  //       }
  //     } else {
  //       departments_selected++;
  //       return $('#hidden_required_department').prop('required', false);
  //     }
  //   });
  // });
  // $('.switch-button').click(function() {
  //   var checkbox;
  //   checkbox = $(this).prev();
  //   checkbox.prop('checked', !checkbox.is(':checked'));
  //   toggle_history_questions(checkbox);
  //   if (checkbox.is(':checked')) {
  //     return $(this).addClass('active');
  //   } else {
  //     return $(this).removeClass('active');
  //   }
  // });
  // toggle_history_questions = function(button) {
  //   var at_least_one_is_checked, clicked_coach_button, id;
  //   id = button.attr('id');
  //   clicked_coach_button = id.indexOf("employment_application_gymnastics") >= 0;
  //   clicked_coach_button |= id.indexOf("employment_application_dance") >= 0;
  //   clicked_coach_button |= id.indexOf("employment_application_swim") >= 0;
  //   clicked_coach_button |= id.indexOf("employment_application_tag") >= 0;
  //   if (clicked_coach_button) {
  //     at_least_one_is_checked = $('#employment_application_gymnastics').is(':checked');
  //     at_least_one_is_checked |= $('#employment_application_dance').is(':checked');
  //     at_least_one_is_checked |= $('#employment_application_swim').is(':checked');
  //     at_least_one_is_checked |= $('#employment_application_tag').is(':checked');
  //     if (at_least_one_is_checked) {
  //       $('#coach_questions').show();
  //       return $("#coach_questions textarea").attr("required", true);
  //     } else {
  //       $('#coach_questions').hide();
  //       return $("#coach_questions textarea").removeAttr("required");
  //     }
  //   } else if (id.indexOf("employment_application_hospitality") >= 0) {
  //     if (button.is(':checked')) {
  //       $('#hospitality_questions').show();
  //       return $("#hospitality_questions textarea").attr("required", true);
  //     } else {
  //       $('#hospitality_questions').hide();
  //       return $("#hospitality_questions textarea").removeAttr("required");
  //     }
  //   }
  // };




  // $('#coach_questions').hide();
  // $('#hospitality_questions').hide();
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
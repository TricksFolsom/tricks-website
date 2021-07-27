// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery3
//= require jquery-ui/widgets/datepicker
//= require jquery_ujs
//= require jquery.minicolors
//= require foundation
//= require_directory .

/*global $*/

$(function() { $(document).foundation(); });

$(window).on("load", function() {
  $(".load-hidden").each(function() {
    $(this).removeClass("load-hidden");
  });
  
  if ($(document).height() <= $(window).height()){
    // content does not fill page, add a buffer to cover the bottom of the page
    var bottom = $("#footer").offset().top + $("#footer").height();
    var height = $(window).height() - bottom;
    var elem = document.createElement('div');
    elem.style.cssText = 'position: absolute; top: '+bottom+'px; width: 100%; height: '+height+'px; z-index: 100; background-color: #fff;';
    document.body.appendChild(elem);
  }
});

$(function() {
  // update info based on session variable for location
  updateLocation(sessionStorage.getItem('location'));

  // when a location button is clicked
  $('.location-button').on('click', function(event) {
    event.preventDefault();
    updateLocation(event.target.text);
  });

  $('form').submit(function(event) {
    var show_uploading_overlay = true;
    if (typeof $(this).data('confirm') != 'undefined') {
      event.stopImmediatePropagation();
      if (!confirm($(this).data('confirm'))) {
        event.preventDefault();
        show_uploading_overlay = false;
      }
    }

    if (show_uploading_overlay) {
      $("input:file").each(function(index) {
        if ($(this).val() != "")
          $("#uploading_modal_hidden_trigger").trigger('click');
        return;
      });
    }
  });
});

function resetLocationButtons() {
  $('.location-button').each(function(i, obj) {
    $(obj).removeClass('active');
  });

  $('.footer-location-information').each(function(i, obj) {
    $(obj).hide();
  });

  $('.location-classes-information').each(function(i, obj) {
    $(obj).hide();
  });

  $('.location-schedule-pdf').each(function(i, obj) {
    $(obj).hide();
  });
  $('#choose_program_modal').hide();
  $('.program-button#swim').fadeOut(300);
  console.log("Reseting location buttons")
  $('.program-button#school-age_dance').fadeIn(300);
  $('.program-button#preschool_dance').fadeIn(300);
}

function updateLocation(loc) {
  resetLocationButtons();
  if (loc == null || loc == "null") {
    $('.footer-location-information#NONE').show();
    return;
  }
  var loc = convertToShortName(loc);

  sessionStorage.setItem('location', loc);

  $('.location-button#' + loc).addClass('active');
  $('.footer-location-information#' + loc).show();
  $('.location-classes-information#' + loc).show();
  $('.location-schedule-pdf#' + loc).show();
  $('#choose_program_modal').show();
  if (loc == "FOL") {
    $('.program-button#swim').fadeIn(300);
  }
  if (loc == "SAC") {
    $('.program-button#school-age_dance').fadeOut(300);
    $('.program-button#preschool_dance').fadeOut(300);
  }
  $('.party_price').hide();
  $('.NONE_price').hide();
  $('.GB_price').hide();
  $('.FOL_price').hide();
  $('.SAC_price').hide();
  if ($('.' + loc + '_price').text() != "") {
    $('.' + loc + '_price').show();
    $('.party_price').show();
  }
}

function convertToShortName(loc) {
  switch (loc) {
    case "Granite Bay":
      return "GB";
    case "Folsom":
      return "FOL";
    case "Sacramento":
      return "SAC";
  }
  return loc;
}

function convertToFullName(loc) {
  switch (loc) {
    case "GB":
      return "Granite Bay";
    case "FOL":
      return "Folsom";
    case "SAC":
      return "Sacramento";
  }
  return loc;
}

$(function() {
  $("#comments_table th a, #comments_table .pagination a").on("click", function() {
    $.getScript(this.href);
    return false;
  });
  $("#comments_search input").keyup(function() {
    $.get($("#comments_search").attr("action"), $("#comments_search").serialize(), null, "script");
    return false;
  });
});

$(function() {
  $("#quotes_table th a, #quotes_table .pagination a").on("click", function() {
    $.getScript(this.href);
    return false;
  });
  $("#quotes_search input").keyup(function() {
    $.get($("#quotes_search").attr("action"), $("#quotes_search").serialize(), null, "script");
    return false;
  });
});

$(function() {
  $("#users_table th a, #users_table .pagination a").on("click", function() {
    $.getScript(this.href);
    return false;
  });
  $("#users_search input").keyup(function() {
    $.get($("#users_search").attr("action"), $("#users_search").serialize(), null, "script");
    return false;
  });
});

$(function() {
  $("#schedules_table th a, #schedules_table .pagination a").on("click", function() {
    $.getScript(this.href);
    return false;
  });
  $("#schedules_search input").keyup(function() {
    $.get($("#schedules_search").attr("action"), $("#schedules_search").serialize(), null, "script");
    return false;
  });
});

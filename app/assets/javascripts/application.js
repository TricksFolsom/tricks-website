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
        // If there are files to upload:
        if ($(this).val() != ""){
          // Show the modal that signifies files are being uploaded
          $("#uploading_modal_hidden_trigger").trigger('click');
        }
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
  // console.log("Reseting location buttons")
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
    case "Folsom":
      return "FOL";
    case "Sacramento":
      return "SAC";
  }
  return loc;
}

function convertToFullName(loc) {
  switch (loc) {
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

// Handle auto text resizing:
const autoSizeText = async function() {
  const elements = $('.resize');
  if (elements.length <= 0) {
    console.log("No elements found that need resizing.");
    return;
  }

  // 0.7 is used because that is the ratio of the squares diagonal to its side. And since we need the square to
  // fit inside the bubble (whose diameter is the same as the squares diagonal) we have to scale our scroll area
  // by this ratio.
  const magic_scaling_number = 0.7;

  // Loop over all elements that have requested a text resize
  for (let i = 0; i < elements.length; i++) {
    const element = elements[i];
    
    // .resize elements have a starting font-size of 0
    let current_test_size = 30;

    const max_size = element.scrollWidth * magic_scaling_number;
    const text_box = element.children[0];

    // add margins to the side that fill in based on the magic_scaling_number
    $(text_box).css('margin', "0 " + ((1 - magic_scaling_number) / 2) * 100 + "%");

    let has_overflowed = false;
    const resizeText = function() {
      // Set font size based on current test size (determined from previous loops test sizes)
      $(element).css('font-size', current_test_size + "px");
      console.log("testing font size: " + current_test_size);

      // console.log("maxSize: " + max_size + " | scrollWidth: " + text_box.scrollWidth + " | clientWidth: " + text_box.clientWidth + " | offsetWidth: " + text_box.offsetWidth);
      // console.log("maxSize: " + max_size + " | scrollHeight: " + text_box.scrollHeight + " | clientHeight: " + text_box.clientHeight + " | offsetHeight: " + text_box.offsetHeight);
      const is_overflowing =
          text_box.scrollWidth > text_box.clientWidth ||    // verifies no horizontal overflow
          text_box.clientWidth > max_size ||                // verifies that the full width fits in the bubble
          text_box.scrollHeight > text_box.clientHeight ||  // verifies no vertical overflow (probably has no impact on this scenario)
          text_box.clientHeight > max_size;                 // verifies height does not exceed the bubble
          
      // console.log("min: " + min_font_size + " | max: " + max_font_size + " | current: " + current_test_size);

      // The idea here is to scale up until we overflow, then scale down until we are not overflowing anymore.
      if (is_overflowing) {
        // text is out of bounds, shrink by 0.5
        current_test_size = current_test_size - 0.5;
        has_overflowed = true;
      } else if (!has_overflowed) {
        // text doesn't go out of bounds yet, add 10
        current_test_size = current_test_size + 5;
      } else {
        console.warn("Decided on font size: " + current_test_size)
        return;
      }
      if (max_size > 0){
        resizeText();
      }
    };

    resizeText();
  }
};

$(document).ready(function() {
  autoSizeText();
});

let resize_timeout;
$(window).resize(function() {
  clearTimeout(resize_timeout);
  resize_timeout = setTimeout(() => {
    autoSizeText();
  }, 500);
});
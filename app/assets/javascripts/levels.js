// Loads in parties from JackRabbit upon request
jQuery(function() {
  $('.level_details').show();

  return $('.accordion-title.level-panel').on('click', function(event) {
    var level_id;
    event.preventDefault();
    level_id = $(event.target).data("id");
    return $.ajax({
      url: '/levels/jr_request/' + level_id,
      success: function(html) {
        $('.level-classes#' + level_id).html(html);
        updateLocation(sessionStorage.getItem('location'));
      }
    });
  });
});
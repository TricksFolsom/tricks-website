// Loads in parties from JackRabbit upon request
jQuery(function() {
  return $('.accordion-title.party-panel').on('click', function(event) {
    var party_id;
    event.preventDefault();
    party_id = $(event.target).data("id");
    return $.ajax({
      url: '/parties/jr_request/' + party_id,
      success: function(html) {
        $('.available-parties').html(html);
        updateLocation(sessionStorage.getItem('location'));
      }
    });
  });
});
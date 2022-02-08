var autoSizeText;

autoSizeText = function() {
  const elements = $('.resize');
  if (elements.length <= 0) {
    return;
  }

  // 0.7 is used because that is the ratio of the squares diagonal to its side. And since we need the square to
  // fit inside the bubble (whose diameter is the same as the squares diagonal) we have to scale our scroll area
  // by this ratio. BUT because words are funny, and they do weird layouts, we grow this a bit to try and fill
  // the circle with text. At 0.7 it is GUARANTEED all text will be in the bubble, but a lot of the time it looks
  // like it is just too small.
  const magic_scaling_number = 0.7 + 0.05;
  let results = [];

  // Loop over all elements that have requested a text resize
  for (let i = 0; i < elements.length; i++) {
    const element = elements[i];
    results.push((function(element) {
      let min_font_size = 0;
      let max_font_size = parseInt($(element).data("maxFontSize"));

      // .resize elements have a starting font-size of 0
      let current_test_size = 0;

      const max_size = element.scrollWidth * magic_scaling_number;

      const resizeText = function() {
        const text_box = element.children[0];
        // console.log("scrollWidth: " + text_box.scrollWidth + " | clientWidth: " + text_box.clientWidth + " | offsetWidth: " + text_box.offsetWidth);
        // console.log("scrollHeight: " + text_box.scrollHeight + " | clientHeight: " + text_box.clientHeight + " | offsetWidth: " + text_box.offsetHeight);
        const is_overflowing =
            text_box.scrollWidth > text_box.clientWidth || // verifies no horizontal overflow
            text_box.clientWidth > max_size || // verifies that the full width fits in the bubble
            text_box.scrollHeight > text_box.clientHeight || // verifies no vertical overflow (probably has no impact on this scenario)
            text_box.clientHeight > max_size; // verifies height does not exceen the bubble
            
        if (is_overflowing) {
          // text is out of bounds, go half the distance back towards previous value (min_font_size)
          max_font_size = current_test_size;
          current_test_size = current_test_size + (min_font_size - current_test_size) / 2;
        } else {
          // text doesn't go out of bounds yet, add half the amount towards max and current value and try again
          min_font_size = current_test_size;
          current_test_size = current_test_size + (max_font_size - current_test_size) / 2;
        }
        // add margins to the side that fill in based on the magic_scaling_number
        $(text_box).css('margin', "0 " + ((1 - magic_scaling_number) / 2) * 100 + "%");
        $(element).css('font-size', current_test_size);
      };

      // uncomment this to be able to watch how it resizes
      // setInterval(() => {
      //   if (Math.abs(max_font_size - min_font_size > 1)) {
      //     resizeText();
      //   }
      // }, 500)

      // if the gap between min and max is too big, resize again.
      while (Math.abs(max_font_size - min_font_size) > 0.7) {
          resizeText();
      }
    })(element));
  }
  return results;
};

$(document).ready(function() {
  return autoSizeText();
});

$(window).resize(function() {
  return autoSizeText();
});
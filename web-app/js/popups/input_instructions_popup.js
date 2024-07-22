$(document).ready(function(){
  var wrapper_div = 'popup_inputInstructions';
  var div_bg = 'input_instructions_bg';

  $(".popup_btn_input_instructions").click(function(){
    centerPopup(wrapper_div,div_bg);
    loadPopup(wrapper_div,div_bg);
  });

  $("#close_inputInstructions").click(function(){
    disablePopup(wrapper_div,div_bg);
  });
});
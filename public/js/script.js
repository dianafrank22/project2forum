"use strict";
$(document).ready(function() {

$('.all_categories').each(function () {
  var colors = ["#107fc3","#4b5760","#9a3896", "#82b9e3", "#17451c", "#601a36"];                
  var rand = Math.floor(Math.random()*colors.length);           
  $(this).css("background-color", colors[rand]);
});	


$(".all_categories").hover(
    function() {
        $(this).css("background-color", "#edeeae")
    }, 
    function() {
    	var colors = ["#107fc3","#4b5760","#9a3896", "#82b9e3", "#17451c", "#601a36"];                
  		var rand = Math.floor(Math.random()*colors.length);           
  		$(this).css("background-color", colors[rand]);
      
    }
);

});





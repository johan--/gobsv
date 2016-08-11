$(function(){
  $('button', '.item').on('click', function(e){
    e.preventDefault();
    e.stopPropagation();
    $(this).prev('input').click();
    $('.item').removeClass('active');
    $(this).closest('.item').addClass('active');
  });
});

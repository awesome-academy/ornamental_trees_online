$(document).ready(function () {
  changed();

  $("select").change(function () {
    changed();
  });

  function changed(){
    totalPrice = 0;
    price = $(".price");
    quantity = $(".quantity select");

    for (var i = 0; i < price.length; i++){
      totalPrice += parseFloat(price.eq(i).text()) * parseFloat(quantity.eq(i).val());
    }
    $("#total").html(totalPrice);
    $("#total").append(" $"); 
  }
});

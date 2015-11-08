$ ->
  $(".product-movement-kind input").on "click", ->
    if $(".product-movement-kind input:checked").attr("id") == "inv_product_movement_kind_out"
      $("#inv_product_movement_cause_purchase").closest(".radio").hide()
      $("#inv_product_movement_cause_transfer").closest(".radio").hide()
      $(".product-movement-cause input:visible:first").trigger("click")
      $(".product-movement-cause input:visible:first").trigger("click")
    else
      $(".product-movement-cause .radio").show()
  $(".product-movement-kind input:checked").trigger("click")

  $(".product-movement-cause input").on "click", ->
    if $(".product-movement-cause input:checked").attr("id") == "inv_product_movement_cause_transfer"
      $("#inv_product_movement_warehouse_from").closest(".form-group").show()
    else
      $("#inv_product_movement_warehouse_from").closest(".form-group").hide()

  $(".product-movement-cause input:checked").trigger("click")

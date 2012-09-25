$ ->
  $("[data-dismiss=alert]").click ->
    $(@).parent(".alert").hide()
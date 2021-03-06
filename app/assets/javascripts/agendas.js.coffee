class Agenda
  constructor: (@id)->

  getHtml: (date)->
    $.ajax(
      url: "/agendas/#{@id}"
      data:
        date: date
    ).done (data) ->
      $("div#agenda").html data


class AgendaApp
  constructor: (@today)->
    @btnConfigure = $("a#btn-configure")
    @selectDate = $("input#date")
    @selectDate.hide()
    $("select#doctor").change (event) =>
      if $("select#doctor option:selected").val() != ""
        @currentAgenda = new Agenda($("select#doctor option:selected").val())
        @currentAgenda.getHtml(@today)


        @btnConfigure.attr("disabled",false)
        @selectDate.show()
        @selectDate.change (event) =>
          @currentAgenda.getHtml($("input#date").val())
      else
        @btnConfigure.attr("disabled", true)
        @selectDate.hide()
        @currentAgenda = null
        $("div#agenda").html ""
    $("a#btn-configure").on 'click', (e)->
      $.ajax(
          url: "/agendas/" + $("select#doctor option:selected").val() + "/edit"
        ).done (data)->
          $("div#agenda").html(data)
          $('.timepicker').timepicker({minuteStep: 5, showMeridian: false, defaultTime: false})

window.AgendaApp = AgendaApp

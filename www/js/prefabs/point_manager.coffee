class Prefab.PointManager extends Phaser.Group
  colors: 
    selected: 0xFFFF33

  setCustom: ->
    @.setAll('anchor', new Phaser.Point(0.5, 0.5))
    @.setAll('inputEnabled', true)

    @.forEach(@.setEvents, @)

  setEvents: (point)->  
    point.events.onInputUp.add(@.onInputUp, @)

  onInputUp: (point)->
    console.log point.alpha
    if point.selected
      point.selected = false
      point.tint = 0xffffff
    else
      point.selected = true
      point.tint = @colors.selected

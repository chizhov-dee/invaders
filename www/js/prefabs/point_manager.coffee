class Prefab.PointManager extends Phaser.Group
  colors: 
    selected: 0xFFFF33

  setCustom: ->
    @.setAll('anchor', new Phaser.Point(0.5, 0.5))
    #@.setAll('scale', new Phaser.Point(0.5, 0.5))

    @.setAll('alpha', 0.2)

  #   @.forEach(@.setEvents, @)

  # setEvents: (point)->  
  #   point.events.onInputUp.add(@.onInputUp, @)

  # onInputUp: (point)->
  #   console.log point.alpha
  #   if point.selected
  #     point.selected = false
  #     point.tint = 0xffffff
  #   else
  #     point.selected = true
  #     point.tint = @colors.selected

  addPoints: (points)->
    for point in points
      @.add(new Phaser.Sprite(@game, (point.x || 0) + 16, (point.y || 0) + 16, 'point1_32'))

    @.setCustom()  
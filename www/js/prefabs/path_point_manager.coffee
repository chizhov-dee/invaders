class Prefab.PathPointManager extends Phaser.Group
  points: []
  pointCountMax: 10
  colors: 
    path: 0x40FF00
    point: 0x40FF00

  constructor: ->
    super

    # for i in [0...@pointCountMax]
    #   @.add(@.createPoint())

  createPoint: (x, y)->
    point = new Phaser.Graphics(@game, 300, 300)
    point.id = @game.rnd.integer()
    point.beginFill(@colors.point, 1)
    point.lineStyle(1, @colors.point)
    point.drawCircle(0, 0, 5)
    point.endFill()
    #point.exists = false

    point.inputEnabled = true

    point.events.onInputUp.add(@.onInputUp, @)

    point

  onInputUp: (point)->
    console.log point.id 



  draw: ->
    point.beginFill(colors.point, 1)
    point.lineStyle(1, colors.point)
    point.drawCircle(0, 0, 5)
    point.endFill()




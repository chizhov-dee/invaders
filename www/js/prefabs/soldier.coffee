class Prefab.Soldier extends Phaser.Sprite
  colors: []

  constructor: (game, weapon, color)->
    super(game, 0, 0, 'soldiers', "soldier_#{color}_#{weapon}.png")

    @blendMode = 1

    #@soldier.tint = 0x848484

    @game.physics.enable(@, Phaser.Physics.ARCADE)

    @anchor.setTo(0.5, 0.5)

    @inputEnabled = true

    @events.onInputUp.add(@.onInputUp, @)

    @pointer = null

    @selected = false

    @targetPointer = new Phaser.Pointer(0, 0)

  onInputUp: (e)->
    @selected = true

    #console.log @pointer = new Phaser.Pointer(@game, 1)

  update: ->
    if @selected && @game.input.mousePointer.isDown
      console.log @targetPointer.x = @game.input.activePointer.x
      console.log @targetPointer.y = @game.input.activePointer.y
      
      @selected = false

      @rotation = @game.physics.arcade.moveToXY(@, @targetPointer.x, @targetPointer.y)

      
    if Math.round(@game.physics.arcade.distanceToXY(@, @targetPointer.x, @targetPointer.y)) == 0
      @body.velocity.x = 0
      @body.velocity.y = 0
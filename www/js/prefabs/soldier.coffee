class Prefab.Soldier extends Phaser.Sprite
  defaultTint: null
  isEnemy: false # свой или враг

  colors: 
    gray: 0xA4A4A4
    green: 0x688A08
    black: 0x1C1C1C
    blue: 0x58ACFA
    brown: 0xD2BF4E

  constructor: (game, weapon_type, color, isEnemy)->
    super(game, 0, 0, 'soldiers', "soldier_#{ weapon_type }.png")

    @anchor.setTo(0.5, 0.5)

    @defaultTint = @colors[color]

    @tint = @defaultTint

    @game.physics.enable(@, Phaser.Physics.ARCADE)

    @body.collideWorldBounds = true

    @isEnemy = isEnemy if isEnemy?

    unless @isEnemy
      @unitController = new Controller.UnitController(@)

      @inputEnabled = true

  update: ->
    super

    @unitController?.update()


  postUpdate: ->
    super

    @unitController?.postUpdate()

#Phaser.Utils.mixinPrototype(Prefab.Soldier.prototype, Controller.UnitController.prototype)    
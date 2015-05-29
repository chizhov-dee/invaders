class Soldier extends Phaser.Sprite
  defaultTint: null

  colors: 
    gray: 0xA4A4A4
    green: 0x688A08
    black: 0x1C1C1C
    blue: 0x58ACFA
    brown: 0xD2BF4E

  snapX: null
  snapY: null 
  pointStep: 5

  constructor: (game, weapon_type, color, isEnemy)->
    super(game, 0, 0, 'soldiers', "soldier_#{ weapon_type }.png")

    @anchor.setTo(0.5, 0.5)
    @pivot = new Phaser.Point(-5, 0)

    @defaultTint = @colors[color]

    @tint = @defaultTint  

  #   unless @isEnemy
  #     @unitController = new Controller.UnitController(@)

  #     @inputEnabled = true

  # update: ->

  #   @unitController?.update()
   

  #postUpdate: ->
    
    
    

    #@unitController?.postUpdate()

#Phaser.Utils.mixinPrototype(Prefab.Soldier.prototype, Controller.UnitController.prototype)    

module.exports = Soldier
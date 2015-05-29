Phaser = require 'Phaser'

class Game extends Phaser.State
  constructor: -> super

  create: ->
    @cameraController = new CameraController(@game)
        # назначаем физику
    @physics.startSystem(Phaser.Physics.ARCADE)

    #@tile_selected = false

    @.addMap()

    @pathPointManager = new Prefab.PathPointManager(@game, @map)

    @pathPointManager.addPoints(@map.objects.PathPoints)

    @soldiers = new Prefab.Soldiers(@game, @pathPointManager)

    @soldiers.addSoldier(48, 48)

    @soldiers.addSoldier(176, 400)




  addMap: ->
    # добавляем тайловую карту
    @map = @game.add.tilemap('main')

    @map.addTilesetImage('gridtiles', 'tiles')

    @ground = @map.createLayer('Ground')

    #@map.setCollisionByExclusion([]) # назначаем колизион на все тайлы
    @walls = @map.createLayer('Walls')

    @ground.resizeWorld()


  
  update: ->
    @cameraController.update()
    

module.exports = Game


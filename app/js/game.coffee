# globals libraries
_ = require 'underscore'

Phaser = require 'Phaser'

CameraController = require('./controllers/camera_controller.coffee')
PathPointManager = require('./prefabs/path_point_manager.coffee')
Soldiers = require('./prefabs/soldiers.coffee')


class Game extends Phaser.State
  constructor: -> super

  create: ->
    @cameraController = new CameraController(@game)
        # назначаем физику
    @physics.startSystem(Phaser.Physics.ARCADE)

    @.addMap()

    @pathPointManager = new PathPointManager(@game, @map)

    @pathPointManager.addPoints(@map.objects.PathPoints)

    @soldiers = new Soldiers(@game, @pathPointManager)

    @soldiers.addSoldier(48, 48)

#    @soldiers.addSoldier(176, 400)


  addMap: ->
    # добавляем тайловую карту
    @map = @game.add.tilemap('main')

    @map.addTilesetImage('gridtiles', 'tiles')

    @ground = @map.createLayer('Ground')

    @walls = @map.createLayer('Walls')

    @ground.resizeWorld()

  update: ->
    @cameraController.update()
    

module.exports = Game


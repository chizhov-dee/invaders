class Scene.Main extends Phaser.State
  map: null

  preload: ->
    # maps data load
    @game.load.tilemap('main', 'maps/main.json', null, Phaser.Tilemap.TILED_JSON)  
    @game.load.image('tiles', 'img/gridtiles.png')
    @game.load.image('point_32', 'img/point_32.png')
    @game.load.image('point1_32', 'img/point1_32.png')

    #@game.load.image('p_green', 'img/p_points/p_green.png')

    @game.load.atlasJSONHash('soldiers', 'img/soldiers.png', 'js/sprites/soldiers.json')
  

  create: ->
    @cameraController = new Controller.CameraController(@game)
        # назначаем физику
    @physics.startSystem(Phaser.Physics.ARCADE)

    #@tile_selected = false

    @.addMap()

    @pathPointManager = new Prefab.PathPointManager(@game, @map)

    @pathPointManager.addPoints(@map.objects.PathPoints)

    @soldiers = new Prefab.Soldiers(@game, @pathPointManager)

    @soldiers.addSoldier(48, 48)

    @soldiers.addSoldier(112, 112)




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

    # if @game.input.mousePointer.isDown
    #   if !@tile_selected
    #     @tile_selected = true
    #     console.log @game.input.mousePointer.worldX
    #     tile = @map.getTileWorldXY(@game.input.mousePointer.worldX, @game.input.mousePointer.worldY, 32, 32, 'PathPoints')

    #     if tile
    #       console.log coords = _.map(@.getNeighboringTiles(tile.x, tile.y, 'PathPoints', 5), (t)-> [t.x, t.y])

    #       for c in coords  
    #         @map.putTile(@tile, c[0], c[1], @operatedPoints)

    # else
    #   @tile_selected = false      


    #@game.physics.arcade.collide(@soldier, @layer, ()=> console.log 'collide')

    #@unitController.update()

    # @soldier.body.velocity.x = 0
    # @soldier.body.velocity.y = 0
    # @soldier.body.angularVelocity = 0

    # if @cursors.left.isDown
    #   @soldier.body.angularVelocity = -200
    # else if @cursors.right.isDown
    #   @soldier.body.angularVelocity = 200

    # if @cursors.up.isDown
    #   @game.physics.arcade.velocityFromAngle(@soldier.angle, 150, @soldier.body.velocity)
    
    

      
  render: ->
    @cameraController.render()
    # для дебага

   # @game.debug.body(@soldier)

    

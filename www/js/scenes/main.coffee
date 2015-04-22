class Scene.Main extends Phaser.State
  map: null

  preload: ->
    # maps data load
    @game.load.tilemap('main', 'maps/main.json', null, Phaser.Tilemap.TILED_JSON)  
    @game.load.image('tiles', 'img/gridtiles.png')
    @game.load.image('point_32', 'img/point_32.png')
    

    # @game.load.image('green_path', 'img/green_path.png')
    # @game.load.image('red_path', 'img/red_path.png')
    # @game.load.image('blue_path', 'img/blue_path.png')

    # @game.load.image('point', 'img/point.png')

    @game.load.atlasJSONHash('soldiers', 'img/soldiers.png', 'js/sprites/soldiers.json')
  

  create: ->
    @cameraController = new Controller.CameraController(@game)
        # назначаем физику
    @physics.startSystem(Phaser.Physics.ARCADE)

    @.addMap()


    @soldier = new Prefab.Soldier(@game, 'revolver', 'brown')

    @soldier.reset(100, 100)



    @game.add.existing(@soldier)

    @physics.enable(@soldier, Phaser.Physics.ARCADE)

    # @soldiers = new Prefab.Soldiers(@game, @game.world, 'Soldiers', false, true, Phaser.Physics.ARCADE)

    # @soldiers.createSoldier()

    @cursors = @game.input.keyboard.createCursorKeys()

    #@unitController = new Controller.UnitController(@soldier)


  addMap: ->
    # добавляем тайловую карту
    @map = @game.add.tilemap('main')

    @map.addTilesetImage('gridtiles', 'tiles')

    @ground = @map.createLayer('Ground')

    #@map.setCollisionByExclusion([]) # назначаем колизион на все тайлы
    @walls = @map.createLayer('Walls')

    @point_manager = new Prefab.PointManager(@game, @game.world, 'PointManager')

    @points_layer = @map.createFromObjects('Points', 123, 'point_32', null, true, false, @point_manager)

    @point_manager.setCustom()

    @ground.resizeWorld()
      
  update: ->
    @cameraController.update()

    #

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

    

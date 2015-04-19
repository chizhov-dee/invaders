class Scene.Main extends Phaser.State
  preload: ->
    # maps data load
    @game.load.tilemap('main', 'maps/main.json', null, Phaser.Tilemap.TILED_JSON)  
    @game.load.image('tiles', 'img/gridtiles.png')
    @game.load.atlasJSONHash('soldiers', 'img/soldiers.png', 'js/sprites/soldiers.json')
  

  create: ->
    @cameraController = new Controller.CameraController(@game)
        # назначаем физику
    @physics.startSystem(Phaser.Physics.ARCADE)

    @.addMap()


    @soldier = new Prefab.Soldier(@game, 'revolver', 'brown')

    @soldier.reset(100, 100)

    @game.add.existing(@soldier)

    @soldier1 = new Prefab.Soldier(@game, 'ak', 'green')

    @soldier1.reset(200, 200)

    @game.add.existing(@soldier1)

  addMap: ->
    # добавляем тайловую карту
    map = @game.add.tilemap('main')

    map.addTilesetImage('gridtiles', 'tiles')

    map.setCollisionByExclusion([]) # назначаем колизион на все тайлы

    @layer = map.createLayer('Bounds')

    @layer.resizeWorld()
       
  
  update: ->
    @cameraController.update()
    

      
  render: ->
    @cameraController.render()
    # для дебага

    #@game.debug.spriteInfo(@soldier, 300, 32);

    

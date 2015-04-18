class Scene.Main extends Phaser.State
  preload: ->
    # maps data load
    @game.load.tilemap('main', 'maps/main.json', null, Phaser.Tilemap.TILED_JSON)  
    @game.load.image('tiles', 'img/gridtiles.png')
    @game.load.atlasJSONHash('soldiers', 'img/soldiers.png', 'js/sprites/soldiers.json')
  

  create: ->
    @game.plugins.add(new Controller.CameraController(@game))

        # назначаем физику
    @physics.startSystem(Phaser.Physics.ARCADE)

    @.addMap()


    @soldier = new Prefab.Soldier(@game, 'revo', 'green')

    @soldier.reset(100, 100)

    @game.add.existing(@soldier)

  addMap: ->
    # добавляем тайловую карту
    map = @game.add.tilemap('main')

    map.addTilesetImage('gridtiles', 'tiles')

    map.setCollisionByExclusion([]) # назначаем колизион на все тайлы

    @layer = map.createLayer('Bounds')

    @layer.resizeWorld()
       
  
  update: ->
    

      
  render: ->
    # для дебага

    @game.debug.spriteInfo(@soldier, 300, 32);

    

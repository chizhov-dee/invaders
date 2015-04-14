class Scene.Main extends Phaser.State
  preload: ->
    # maps data load
    @game.load.tilemap('main', 'maps/main.json', null, Phaser.Tilemap.TILED_JSON)  
    @game.load.image('tiles', 'img/gridtiles.png')
    @game.load.atlasJSONHash('soldiers', 'img/soldiers.png', 'js/sprites/soldiers.json')
  

  create: ->
        # назначаем физику
    @physics.startSystem(Phaser.Physics.ARCADE)

    # добавляем тайловую карту
    map = @game.add.tilemap('main')

    map.addTilesetImage('gridtiles', 'tiles')

    map.setCollisionByExclusion([]) # назначаем колизион на все тайлы

    @layer = map.createLayer('Bounds')

    @layer.resizeWorld()

    @soldier = new Prefab.Soldier(@game, 'soldiers', 'soldier.png')

    @soldier.reset(100, 100)

    @physics.enable(@soldier, Phaser.Physics.ARCADE)

    @soldier.anchor.setTo(0.5, 0.5)

    @soldier.blendMode = PIXI.blendModes.NEAREST

    @soldier.tint = 0xF0F0F0

    @game.world.add(@soldier)

    @game.camera.follow(@soldier)

    
  

  update: ->
    

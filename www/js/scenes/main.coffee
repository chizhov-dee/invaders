class Scenes.Main extends Phaser.State
  constructor: (game)->

  preload: ->
    @game.load.tilemap('main', 'maps/main.json', null, Phaser.Tilemap.TILED_JSON)  

    @game.load.image('tiles', 'img/gridtiles.png')

    @game.load.image('soldier', 'img/soldier.png')

    @game.load.image('bullet', 'img/bullet.png')

  create: ->
    @physics.startSystem(Phaser.Physics.ARCADE)

    map = @game.add.tilemap('main')

    map.addTilesetImage('gridtiles', 'tiles')

    map.setCollisionByExclusion([]) # назначаем коллайд на все тайлы

    @layer = map.createLayer('FirstLayer')

    @layer.resizeWorld()

    @soldier = @game.add.sprite(200, 200, 'soldier')

    @soldier.anchor.setTo(0.5, 0.5)

    @physics.enable(@soldier, Phaser.Physics.ARCADE)

    @soldier.body.collideWorldBounds = true

    @game.camera.follow(@soldier)

  update: ->
    @game.physics.arcade.collide(@soldier, @layer)

    @soldier.body.velocity.x = 0
    @soldier.body.velocity.y = 0
    @soldier.body.angularVelocity = 0

    if @game.input.keyboard.isDown(Phaser.Keyboard.LEFT)
      @soldier.body.angularVelocity = -100
    else if @game.input.keyboard.isDown(Phaser.Keyboard.RIGHT)  
      @soldier.body.angularVelocity = 100

    if @game.input.keyboard.isDown(Phaser.Keyboard.UP)  
      @game.physics.arcade.velocityFromAngle(@soldier.angle, 150, @soldier.body.velocity)
      

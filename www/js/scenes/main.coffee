class Scene.Main extends Phaser.State
  constructor: (game)->

  preload: ->
    @game.load.tilemap('main', 'maps/main.json', null, Phaser.Tilemap.TILED_JSON)  

    @game.load.image('tiles', 'img/gridtiles.png')

    @game.load.image('soldier', 'img/soldier.png')

    @game.load.image('bullet', 'img/bullet.png')

    @game.load.image('gunner', 'img/gunner.png')

    @game.load.image('gunner_bullet', 'img/gunner_bullet.png')

    @game.load.spritesheet('explode', 'img/explode.png', 128, 128)
    @game.load.spritesheet('blood', 'img/blood.png', 150, 150)

  create: ->
    # назначаем физику
    @physics.startSystem(Phaser.Physics.ARCADE)


    # добавляем тайловую карту
    map = @game.add.tilemap('main')

    map.addTilesetImage('gridtiles', 'tiles')

    map.setCollisionByExclusion([135]) # назначаем колизион на все тайлы

    @layer = map.createLayer('FirlstLayer')

    @layer.resizeWorld()


    # создаем игрока солдата 
    @soldier = @game.add.sprite(200, 200, 'soldier')
    @soldier.anchor.setTo(0.5, 0.5)
    @physics.enable(@soldier, Phaser.Physics.ARCADE)
    @soldier.body.collideWorldBounds = true
    
    @game.camera.follow(@soldier)

    @soldier.weapon = new Prefab.Weapon(@game, @game.world, 'Weapon', false, true, Phaser.Physics.ARCADE)
    @soldier.weapon.charge('bullet')


    # создаем стрелка

    @gunner = @game.add.sprite(600, 800, 'gunner')
    @gunner.anchor.setTo(0.5, 0.5)
    @gunner.hp = 10
    @physics.enable(@gunner, Phaser.Physics.ARCADE)
    @gunner.weapon = new Prefab.Weapon(@game, @game.world, 'Weapon', false, true, Phaser.Physics.ARCADE)
    @gunner.weapon.charge('bullet')

    @gunner.weapon.fireDelay = 2000


    @explosion = @game.add.sprite(0, 0, 'explode')
    @explosion.animations.add('explosion')
    @explosion.visible = false
    @explosion.anchor.setTo(0.5, 0.5)

    @blood = @game.add.sprite(0, 0, 'blood')
    @blood.animations.add('blood')
    @blood.visible = false
    @blood.anchor.setTo(0.5, 0.5)


    # регистрируем управление
    @cursors = @game.input.keyboard.createCursorKeys()
    
    @fireButton = @game.input.keyboard.addKey(Phaser.Keyboard.SPACEBAR)

  update: ->
    @game.physics.arcade.collide(@soldier, @layer)

    @game.physics.arcade.overlap(@soldier.weapon, @layer, @.onWeaponAndLayerOverlap, null, @)
    @game.physics.arcade.overlap(@gunner, @soldier.weapon, @.onWeaponAndGunnerOverlap, null, @)
    @game.physics.arcade.overlap(@soldier, @gunner.weapon, @.onWeaponAndSoldierOverlap, null, @)

    @soldier.body.velocity.x = 0
    @soldier.body.velocity.y = 0
    @soldier.body.angularVelocity = 0

    if @cursors.left.isDown
      @soldier.body.angularVelocity = -200
    else if @cursors.right.isDown
      @soldier.body.angularVelocity = 200

    if @cursors.up.isDown
      @game.physics.arcade.velocityFromAngle(@soldier.angle, 150, @soldier.body.velocity)

    if @fireButton.isDown
      @soldier.weapon.fire(@soldier) if @soldier.alive

   
    if @game.physics.arcade.distanceBetween(@soldier, @gunner) < 300
      @.setGunnerRotationBySoldier(@game.physics.arcade.angleBetween(@gunner, @soldier) )

      @gunner.weapon.fire(@gunner) if @gunner.alive

  setGunnerRotationBySoldier: (rotation)->
    console.log rotation

    return if @gunner.rotation == rotation

    if @gunner.rotation > rotation
      @gunner.rotation -= 0.01
    else
      @gunner.rotation += 0.01
        

  
  onWeaponAndLayerOverlap: (bullet, layer)->
    bullet.kill()

  onWeaponAndGunnerOverlap: (gunner, bullet)->
    if bullet.exists 
      bullet.kill()
      @gunner.hp -= 1

      console.log @gunner.hp
      
      if @gunner.hp <= 0
        @gunner.kill()   
        @explosion.reset(@gunner.x, @gunner.y)  
        @explosion.visible = true
        @explosion.play('explosion', 30, false, true)

  onWeaponAndSoldierOverlap: (soldier, bullet)->
    soldier.kill()
    bullet.kill()    

    unless soldier.alive
      @blood.reset(soldier.x, soldier.y)  
      @blood.visible = true
      @blood.play('blood', 30, false, true)  
       




      

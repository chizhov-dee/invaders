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

    @tile_selected = false

    @.addMap()

    # @point_manager = new Prefab.PointManager(@game, @game.world, 'PointManager')

    # @point_manager.addPoints(@map.objects.Points)


    @soldier = new Prefab.Soldier(@game, 'revolver', 'brown')

    #@soldier.reset(100, 100)



    @game.add.existing(@soldier)

    @physics.enable(@soldier, Phaser.Physics.ARCADE)

    # @soldiers = new Prefab.Soldiers(@game, @game.world, 'Soldiers', false, true, Phaser.Physics.ARCADE)

    # @soldiers.createSoldier()

    @cursors = @game.input.keyboard.createCursorKeys()

    #@unitController = new Controller.UnitController(@soldier)

    @soldier.reset(@map.objects.SpecialPoints[0].x + 16, @map.objects.SpecialPoints[0].y + 16)


  onTestInputUp: ->
    console.log 111111111  


  addMap: ->
    # добавляем тайловую карту
    @map = @game.add.tilemap('main')

    @map.addTilesetImage('gridtiles', 'tiles')

    #@map.addTilesetImage('p_green', 'p_green')

    @ground = @map.createLayer('Ground')

    #@map.setCollisionByExclusion([]) # назначаем колизион на все тайлы
    @walls = @map.createLayer('Walls')

    @ground.resizeWorld()

    #@points = @map.createLayer('Points')

    # @points.setTexture()

    #console.log @points.children

    # @points = @game.add.group(null, 'Points')

    # @map.createFromTiles([141], null, '', 'Points', @points)

    # console.log @points.children

    # console.log @map.getTile(3, 3, 'PathPoints')

    # @ground.inputEnabled = true

    # console.log @ground.input

    # @ground.priorityID = 100

    # @ground.events.onInputDown.add(@.onTestInputUp, @)

    @operatedPoints = @map.createBlankLayer('OperatedPoints', @map.width, @map.height, 32, 32)

    @tile = new Phaser.Tile(null, 71, 3, 3, 32, 32)

    

    



  testInput: (e)->
    console.log e

  getNeighboringTiles: (x, y, layer, step)->
    time = Date.now()
    step ?= 1

    tiles = []

    currentPool = []

    startX = x
    startY = y

    getTiles = (x, y)=>  
      pool = []

      # unless (startX == x - 1 && startY == y - 1)
      #   tile = @map.getTile(x - 1, y - 1, layer) 

      #   pool.push(tile) if tile?.index > 0

      unless (startX == x && startY == y - 1)
        tile = @map.getTile(x, y - 1, layer)

        pool.push(tile) if tile?.index > 0

      # unless (startX == x + 1 && startY == y - 1)
      #   tile = @map.getTile(x + 1, y - 1, layer)

      #   pool.push(tile) if tile?.index > 0

      unless (startX == x + 1 && startY == y)
        tile = @map.getTile(x + 1, y, layer)

        pool.push(tile) if tile?.index > 0

      # unless (startX == x + 1 && startY == y + 1)
      #   tile = @map.getTile(x + 1, y + 1, layer)

      #   pool.push(tile) if tile?.index > 0

      unless (startX == x && startY == y + 1)
        tile = @map.getTile(x, y + 1, layer)

        pool.push(tile) if tile?.index > 0

      # unless (startX == x - 1 && startY == y + 1)
      #   tile = @map.getTile(x - 1, y + 1, layer)

      #   pool.push(tile) if tile?.index > 0

      unless (startX == x - 1 && startY == y)
        tile = @map.getTile(x - 1, y, layer)

        pool.push(tile) if tile?.index > 0  

      pool

    for i in [1..step]
      if i == 1
        currentPool = getTiles(startX, startY)
      else
        result = []

        console.log currentPool.length

        for tile in currentPool
          result = result.concat(getTiles(tile.x, tile.y))

        currentPool = _.difference(_.uniq(result), tiles)

      tiles = tiles.concat(currentPool) 

    console.log (Date.now() - time) / 1000

    _.uniq(tiles)
    
      
  update: ->
    @cameraController.update()

    if @game.input.mousePointer.isDown
      if !@tile_selected
        @tile_selected = true
        console.log @game.input.mousePointer.worldX
        tile = @map.getTileWorldXY(@game.input.mousePointer.worldX, @game.input.mousePointer.worldY, 32, 32, 'PathPoints')

        if tile
          console.log coords = _.map(@.getNeighboringTiles(tile.x, tile.y, 'PathPoints', 5), (t)-> [t.x, t.y])

          for c in coords  
            @map.putTile(@tile, c[0], c[1], @operatedPoints)

    else
      @tile_selected = false      


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

    

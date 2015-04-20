class Controller.UnitController
  # перед включение контроллера у игрового объекта нужно установить inputEnabled = true

  selected: false
  targetGraphicPath: null # графический объект путь
  targetPoints: [] # точки куда надо пересметить объект
  pathPointManager: null

  colors:
    selected: 0x40FF00

  # points: 
  #   x: [50, 100, 350, 450, 100]
  #   y: [50, 100, 210, 305, 200]

  # pi: 0
  # path: []  
  
  # @gameObject это игровой объект над которым выполняется управление
  constructor: (@gameObject)->
    @targetGraphicPath = new Phaser.Graphics(@gameObject.game, @gameObject.position.x, @gameObject.position.y)

     

    #@gameObject.game.physics.enable(@targetGraphicPath, Phaser.Physics.ARCADE)

    @gameObject.game.add.existing(@targetGraphicPath) 

    #@pathPointManager = new Prefab.PathPointManager(@gameObject.game, @gameObject.game.world, 'PathPointManager', false)

    @.setupEventListeners() 
    
    # @gameObject.game.bmd = @gameObject.game.add.bitmapData(@gameObject.game.width, @gameObject.game.height)
    # @gameObject.game.bmd.addToWorld()

    #@path = @.generatePath(@points)

  generatePathByPoints: (points)->
    path = []
    speed = 1

    for p in [1...points.x.length]
      result = 
      
      x = speed / @gameObject.game.math.distance(points.x[p - 1], points.y[p - 1], points.x[p], points.y[p])

      i = 0
      while i <= 1
        px = @gameObject.game.math.linearInterpolation([points.x[p - 1], points.x[p]], i)
        py = @gameObject.game.math.linearInterpolation([points.y[p - 1], points.y[p]], i)  

        path.push(x: px, y: py)  
        @gameObject.game.bmd.rect(px, py, 1, 1, 'rgba(255, 255, 255, 1)')

        i += x

    path    

  setupEventListeners: ->  
    @gameObject.events.onInputUp.add(@.onInputUp, @)

  onInputUp: ->
    console.log 'onInputUp'
    if @selected
      @selected = false
      @gameObject.tint = @gameObject.defaultTint  
    else
      @selected = true
      @gameObject.tint = @colors.selected  


  onInputDown: ->
    return unless @selected

    console.log 'onInputDown'
  


  # distanceBetween: ->
  #   @gameObject.game.physics.arcade.distanceToXY(@gameObject, @targetPoint.x, @targetPoint.y)

  # createTargetPoint: ->  
  #   targetPoint = new Phaser.Graphics(@gameObject.game, @gameObject.game.input.activePointer.worldX, @gameObject.game.input.activePointer.worldY)
    
  #   @gameObject.game.add.existing(targetPoint)

  #   targetPoint.beginFill(0x40FF00, 1)
  #   targetPoint.lineStyle(1, 0x40FF00)
  #   targetPoint.drawCircle(0, 0, 5)
  #   targetPoint.endFill()

  #   targetPoint

  update: ->  

    # return if @pi >= @path.length

    # @gameObject.rotation = @gameObject.game.math.angleBetween(@gameObject.x, @gameObject.y, @path[@pi].x, @path[@pi].y)

    # @gameObject.x = @path[@pi].x
    # @gameObject.y = @.path[@pi].y

    # @pi += 1



    #return unless @selected

    #if @selected && @gameObject.game.input.mousePointer.isDown


    # if @selected && @gameObject.game.input.mousePointer.isDown
    #   @targetPoint = @.createTargetPoint()
      
    #   #new Phaser.Point(@gameObject.game.input.activePointer.worldX, @gameObject.game.input.activePointer.worldY)
      
    #   @selected = false

    #   @gameObject.tint = @gameObject.defaultTint

    #   @gameObject.rotation = @gameObject.game.physics.arcade.moveToXY(@gameObject, @targetPoint.x, @targetPoint.y)
      
    # if @targetPoint? && Math.round(@.distanceBetween()) in [0..5]
    #   @targetPoint = null
      
    #   @gameObject.body.velocity.x = 0
    #   @gameObject.body.velocity.y = 0


  postUpdate: ->
    @targetGraphicPath.clear()

    if @selected
      if @gameObject.map.getTileWorldXY(@gameObject.game.input.mousePointer.worldX, @gameObject.game.input.mousePointer.worldY)?.canCollide
        color = 0xFF0000
      else
        color = 0x40FF00

      @targetGraphicPath.lineStyle(1, color)
      @targetGraphicPath.moveTo(@gameObject.position.x, @gameObject.position.y)
      @targetGraphicPath.lineTo(@gameObject.game.input.mousePointer.worldX, @gameObject.game.input.mousePointer.worldY)  
        

    # if @targetPoint? && Math.round(@.distanceBetween()) != 0
    #   @targetGraphicPath.lineStyle(1, 0x40FF00)
    #   @targetGraphicPath.moveTo(@gameObject.position.x, @gameObject.position.y)
    #   @targetGraphicPath.lineTo(@targetPoint.x, @targetPoint.y)  
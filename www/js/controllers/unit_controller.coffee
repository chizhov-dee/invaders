class Controller.UnitController
  # перед включение контроллера у игрового объекта нужно установить inputEnabled = true

  selected: false
  targetGraphicPath: null # графический объект путь
  targetPoint: null # точка куда надо пересметить объект

  colors:
    selected: 0x40FF00
  
  # @gameObject это игровой объект над которым выполняется управление
  constructor: (@gameObject)->
    @targetGraphicPath = new Phaser.Graphics(@gameObject.game, @gameObject.position.x, @gameObject.position.y)

    @gameObject.game.add.existing(@targetGraphicPath)  

    @.setupEventListeners() 

  setupEventListeners: ->  
    @gameObject.events.onInputUp.add(@.onInputUp, @)

  onInputUp: ->
    console.log 'onInputUp'
    @selected = true
    @gameObject.tint = @colors.selected  

  distanceBetween: ->
    @gameObject.game.physics.arcade.distanceToXY(@gameObject, @targetPoint.x, @targetPoint.y)

  update: ->
    if @selected && @gameObject.game.input.mousePointer.isDown
      @targetPoint = new Phaser.Point(@gameObject.game.input.activePointer.worldX, @gameObject.game.input.activePointer.worldY)
      
      @selected = false

      @gameObject.tint = @gameObject.defaultTint

      @gameObject.rotation = @gameObject.game.physics.arcade.moveToXY(@gameObject, @targetPoint.x, @targetPoint.y)
      
    if @targetPoint? && Math.round(@.distanceBetween()) in [0..5]
      @targetPoint = null
      
      @gameObject.body.velocity.x = 0
      @gameObject.body.velocity.y = 0

  postUpdate: ->
    @targetGraphicPath.clear()

    if @targetPoint? && Math.round(@.distanceBetween()) != 0
      @targetGraphicPath.lineStyle(1, 0x40FF00)
      @targetGraphicPath.moveTo(@gameObject.position.x, @gameObject.position.y)
      @targetGraphicPath.lineTo(@targetPoint.x, @targetPoint.y)  
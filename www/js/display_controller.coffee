class Controller.DisplayController
  constructor: (@game)-> 
    @last_mouse_point = new Phaser.Point(0, 0)
  
  update: ->
    if @game.input.mousePointer.isDown
      @game.camera.x += @last_mouse_point.x - @game.input.mousePointer.position.x if @last_mouse_point.x != 0
      @game.camera.y += @last_mouse_point.y - @game.input.mousePointer.position.y if  @last_mouse_point.y != 0

      @last_mouse_point.x = @game.input.mousePointer.position.x    
      @last_mouse_point.y = @game.input.mousePointer.position.y

    else
      @last_mouse_point.x = 0
      @last_mouse_point.y = 0  
      
  render: ->
    @game.debug.cameraInfo(@game.camera, 32, 32)  
class CameraController
  lastMousePoint: null

  constructor: (@game)-> 
    @lastMousePoint = new Phaser.Point(0, 0)
  
  update: ->
    if @game.input.mousePointer.isDown
      @game.camera.x += @lastMousePoint.x - @game.input.mousePointer.position.x if @lastMousePoint.x != 0
      @game.camera.y += @lastMousePoint.y - @game.input.mousePointer.position.y if  @lastMousePoint.y != 0

      @lastMousePoint.x = @game.input.mousePointer.position.x    
      @lastMousePoint.y = @game.input.mousePointer.position.y

    else
      @lastMousePoint.x = 0
      @lastMousePoint.y = 0  
      
  render: ->
    #@game.debug.cameraInfo(@game.camera, 0, 0)  


module.exports = CameraController 
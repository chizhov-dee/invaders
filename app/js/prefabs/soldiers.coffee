Soldier = require './soldier.coffee'

class Soldiers extends Phaser.Group
  colors:
    selected: 0x40FF00

  path: null  
  pathIndex: 0

  selectedUnit: null

  constructor: (game, @pathPointManager)->
    super(game, game.world, 'Soldiers', false, true, Phaser.Physics.ARCADE)
  
  addSoldier: (x, y)->
    unit = new Soldier(@game, 'revolver', 'brown')

    unit.inputEnabled = true

    unit.events.onInputUp.add(@.onInputUp, @)

    unit.events.onMoveByPath = new Phaser.Signal()
    unit.events.onMoveByPath.add(@.onMoveByPath, @)

    @.add(unit)

    unit.reset(x, y)

    @pathPointManager.addUnitByWorldXY(unit, x, y)

  onMoveByPath: (unit, points)->

    console.log 'onMoveByPath'  
    console.log unit
    console.log points

    x = []
    y = []

    for p in points
      x.push(p[0])
      y.push(p[1])

    @path = @.generatePath(x: x, y: y)   

  onInputUp: (unit)->
    console.log [unit.snapX, unit.snapY]
    @pathPointManager.deactivateAllPoints()

    if unit.selected
      @.deselectUnit(unit)
    else
      @.deselectAllUnits()

      @.selectUnit(unit)

      @pathPointManager.activatePointsBy(unit)

  selectUnit: (unit)->
    @selectedUnit = unit
    unit.selected = true
    unit.tint = @colors.selected

  deselectUnit: (unit)->  
    @selectedUnit = null
    unit.selected = false
    unit.tint = unit.defaultTint # сброс
        
  deselectAllUnits: ->
    @selectedUnit = null
    @.deselectUnit(child) for child in @children

  generatePath: (points)->
    path = []
    speed = 1

    for p in [1...points.x.length]
      result = 
      
      x = speed / @game.math.distance(points.x[p - 1], points.y[p - 1], points.x[p], points.y[p])

      i = 0
      while i <= 1
        px = @game.math.linearInterpolation([points.x[p - 1], points.x[p]], i)
        py = @game.math.linearInterpolation([points.y[p - 1], points.y[p]], i)  

        path.push(x: px, y: py)  

        i += x

    path     

  resetPath: ->
    @path = null
    @pathIndex = 0  
      

  update: ->
    super

    if @selectedUnit && @path? && @pathIndex < @path.length
      if @pathIndex != 0
        @selectedUnit.rotation = @game.math.angleBetween(@selectedUnit.x, @selectedUnit.y, @path[@pathIndex].x, @path[@pathIndex].y)

        
        @selectedUnit.x = @path[@pathIndex].x
        @selectedUnit.y = @.path[@pathIndex].y

      @pathIndex += 1

      if @pathIndex >= @path.length 
        @.resetPath() 

        @.deselectUnit(@selectedUnit)



module.exports = Soldiers



      
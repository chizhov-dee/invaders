class Prefab.PathPointManager extends Phaser.Group
  pointSize: 32
  pointOffset: 16
  colors: 
    selected: 0xFFFF33

  points: []  
  activePoints: []
  selectedUnit: null

  constructor: (game, map)->
    super(game, game.world, 'PointManager')  

    for i in [0...map.width]
      @points.push(new Array(map.height))



  addPoints: (points)->
    for point in points
      sprite = new Phaser.Sprite(@game, (point.x || 0) + @pointOffset, (point.y || 0) + @pointOffset, 'point1_32')
      
      [sprite.snapX, sprite.snapY] = @.getSnapCoordinates(sprite)

      @points[sprite.snapX][sprite.snapY] = sprite
      
      @.add(sprite)

    @.setCustom()  

  setCustom: ->
    @.setAll('anchor', new Phaser.Point(0.5, 0.5))

    @.setAll('alpha', 0)
    
    @.forEach(@.setEvents, @)

  setEvents: (point)->  
    point.events.onInputDown.add(@.onInputDown, @)

  onInputDown: (point)->
    return unless @selectedUnit

    console.log [point.snapX, point.snapY]

    for p in @activePoints
      p.alpha = 0

    path = @.generatePath(point)

    @activePoints = []

    for p in path
      p.alpha = 0.5

  generatePath: (point)->
    path = []
    nearestPoint = null

    startX = @selectedUnit.snapX
    startY = @selectedUnit.snapY

    endX = point.snapX
    endY = point.snapY


    getNearestPoint = (x, y)=>  
      pool = []

      # передняя
      unless (startX == x && startY == y - 1)
        point = @.findAndRemoveInActivePoints(x, y - 1)

        pool.push(point) if point?

      # задняя
      unless (startX == x && startY == y + 1)
        point = @.findAndRemoveInActivePoints(x, y + 1)

        pool.push(point) if point?  

      # правая
      unless (startX == x + 1 && startY == y)
        point = @.findAndRemoveInActivePoints(x + 1, y)

        pool.push(point) if point? 

      # левая
      unless (startX == x - 1 && startY == y)
        point = @.findAndRemoveInActivePoints(x - 1, y)

        pool.push(point) if point?

      firstSortedPoints = _.sortBy(
        _.pairs(_.groupBy(pool, (p)=> @game.math.distance(endX, endY, p.snapX, p.snapY)))
        (p)-> parseFloat(p[0])
      )[0]

      if firstSortedPoints[1].length > 1
        # выбрать здесь
      else
        firstSortedPoints[1][0]
      

      _.sortBy(pool, (p)=> @game.math.distance(endX, endY, p.snapX, p.snapY))[0]

    while @activePoints.length > 0 && not (nearestPoint?.snapX == endX && nearestPoint?.snapY == endY)
      nearestPoint = (
        if nearestPoint?
          getNearestPoint(nearestPoint.snapX, nearestPoint.snapY)
        else
          getNearestPoint(startX, startY)
      )

      console.log [nearestPoint.snapX, nearestPoint.snapY]

      path.push(nearestPoint)

    path

  
  findAndRemoveInActivePoints: (x, y)->
    newPool = []
    resultPoint = null
    
    for point in @activePoints
      if !resultPoint? && point.snapX == x && point.snapY == y
        resultPoint = point
      else
        newPool.push(point)

    @activePoints = newPool    

    console.log @activePoints.length

    resultPoint      


  getSnapCoordinates: (point)->
    [
      @game.math.snapToFloor(point.x - @pointOffset, @pointSize) / @pointSize
      @game.math.snapToFloor(point.y - @pointOffset, @pointSize) / @pointSize
    ]

  addUnitByWorldXY: (unit, worldX, worldY)->
    [snapX, snapY] = @.getSnapCoordinates(new Phaser.Point(worldX, worldY))

    point = @.findPoint(snapX, snapY)

    point.unit = unit

    unit.snapX = snapX
    unit.snapY = snapY

  findPoint: (snapX, snapY)->
    @points[snapX]?[snapY]    

  # removeUnit: (unit)->
  #   point = @.findPoint(unit.snapX, unit.snapY)

  #   point.unit = null

  #   unit.snapX = null
  #   unit.snapY = null

  deactivateAllPoints: ->  
    @selectedUnit = null

    for point in @activePoints
      point.alpha = 0 
      point.inputEnabled = false

    @activePoints = []

  activatePointsBy: (unit)->  
    @selectedUnit = unit

    point = @.findPoint(unit.snapX, unit.snapY)

    @activePoints = @.getNeighboringPoints(point.snapX, point.snapY, unit.pointStep)

    for point in @activePoints
      point.alpha = 0.5
      point.inputEnabled = true


  getNeighboringPoints: (x, y, step)->
    time = Date.now()
    step ?= 1

    points = []

    currentPool = []

    startX = x
    startY = y

    getPoints = (x, y)=>  
      pool = []

      unless (startX == x && startY == y - 1)
        point = @.findPoint(x, y - 1)

        pool.push(point) if point? && not point.unit?

      unless (startX == x + 1 && startY == y)
        point = @.findPoint(x + 1, y)

        pool.push(point) if point? && not point.unit?

      unless (startX == x && startY == y + 1)
        point = @.findPoint(x, y + 1)

        pool.push(point) if point? && not point.unit?

      unless (startX == x - 1 && startY == y)
        point = @.findPoint(x - 1, y)

        pool.push(point) if point? && not point.unit?  

      pool

    for i in [1..step]
      if i == 1
        currentPool = getPoints(startX, startY)
      else
        result = []

        for point in currentPool
          result = result.concat(getPoints(point.snapX, point.snapY))

        currentPool = _.difference(_.uniq(result), points)

      points = points.concat(currentPool) 

    points = _.uniq(points)

    console.log (Date.now() - time) / 1000

    points
    
        
      


      
    
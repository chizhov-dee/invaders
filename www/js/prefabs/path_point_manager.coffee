class Prefab.PathPointManager extends Phaser.Group
  pointSize: 32
  pointOffset: 16
  colors: 
    selected: 0xFFFF33

  points: []  
  activePoints: []

  constructor: (game, map)->
    super(game, game.world, 'PointManager')  

    for i in [0...map.width]
      @points.push(new Array(map.height))


  setCustom: ->
    @.setAll('anchor', new Phaser.Point(0.5, 0.5))

    @.setAll('alpha', 0)

    @.setAll('inputEnabled', true)
    
  #   @.forEach(@.setEvents, @)

  # setEvents: (point)->  
  #   point.events.onInputUp.add(@.onInputUp, @)

  # onInputUp: (point)->
  #   console.log [point.x, point.y]

  #   console.log @.getSnapCoordinates(point)

  #   if point.selected
  #     point.selected = false
  #     point.alpha = 0
  #   else
  #     point.selected = true
  #     point.alpha = 1

  #   console.log point.alpha  

  addPoints: (points)->
    for point in points
      sprite = new Phaser.Sprite(@game, (point.x || 0) + @pointOffset, (point.y || 0) + @pointOffset, 'point1_32')
      
      [sprite.snapX, sprite.snapY] = @.getSnapCoordinates(sprite)

      @points[sprite.snapX][sprite.snapY] = sprite
      
      @.add(sprite)

    @.setCustom()  

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
    point.alpha = 0 for point in @activePoints

    @activePoints = []

  activatePointsBy: (unit)->  
    point = @.findPoint(unit.snapX, unit.snapY)

    @activePoints = @.getNeighboringPoints(point.snapX, point.snapY, unit.pointStep)

    point.alpha = 0.5 for point in @activePoints


  getNeighboringPoints: (x, y, step)->
    time = Date.now()
    step ?= 1

    points = []

    currentPool = []

    startX = x
    startY = y

    getPoints = (x, y)=>  
      pool = []

      # unless (startX == x - 1 && startY == y - 1)
      #   tile = @map.getTile(x - 1, y - 1, layer) 

      #   pool.push(tile) if tile?.index > 0

      unless (startX == x && startY == y - 1)
        console.log point = @.findPoint(x, y - 1)

        pool.push(point) if point? && not point.unit?

      # unless (startX == x + 1 && startY == y - 1)
      #   tile = @map.getTile(x + 1, y - 1, layer)

      #   pool.push(tile) if tile?.index > 0

      unless (startX == x + 1 && startY == y)
        console.log point = @.findPoint(x + 1, y)

        pool.push(point) if point? && not point.unit?

      # unless (startX == x + 1 && startY == y + 1)
      #   tile = @map.getTile(x + 1, y + 1, layer)

      #   pool.push(tile) if tile?.index > 0

      unless (startX == x && startY == y + 1)
        console.log point = @.findPoint(x, y + 1)

        pool.push(point) if point? && not point.unit?

      # unless (startX == x - 1 && startY == y + 1)
      #   tile = @map.getTile(x - 1, y + 1, layer)

      #   pool.push(tile) if tile?.index > 0

      unless (startX == x - 1 && startY == y)
        console.log point = @.findPoint(x - 1, y)

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

    console.log (Date.now() - time) / 1000

    _.uniq(points)
    
        
      


      
    
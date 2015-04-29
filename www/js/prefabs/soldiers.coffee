class Prefab.Soldiers extends Phaser.Group
  colors:
    selected: 0x40FF00

  constructor: (game, @pathPointManager)->
    super(game, game.world, 'Soldiers', false, true, Phaser.Physics.ARCADE)
  
  addSoldier: (x, y)->
    unit = new Prefab.Soldier(@game, 'revolver', 'brown')

    unit.inputEnabled = true

    unit.events.onInputUp.add(@.onInputUp, @)

    @.add(unit)

    unit.reset(x, y)

    @pathPointManager.addUnitByWorldXY(unit, x, y)

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
    unit.selected = true
    unit.tint = @colors.selected

  deselectUnit: (unit)->  
    unit.selected = false
    unit.tint = unit.defaultTint # сброс
        
  deselectAllUnits: ->
    @.deselectUnit(child) for child in @children






      
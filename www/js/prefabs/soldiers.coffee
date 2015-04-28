class Prefab.Soldiers extends Phaser.Group
  colors:
    selected: 0x40FF00

  constructor: (game, @pathPointManager)->
    super(game, game.world, 'Soldiers', false, true, Phaser.Physics.ARCADE)
  
  addSoldier: (x, y)->
    soldier = new Prefab.Soldier(@game, 'revolver', 'brown')

    soldier.inputEnabled = true

    soldier.events.onInputUp.add(@.onInputUp, @)

    @.add(soldier)

    soldier.reset(x, y)

    @pathPointManager.addUnitByWorldXY(soldier, x, y)

  onInputUp: (unit)->
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






      
class Prefab.Soldiers extends Phaser.Group

  createSoldier: ->
    soldier = new Prefab.Soldier(@game, 'revolver', 'brown')
    soldier.reset(100, 100)

    @.add(soldier)

    soldier.body.collideWorldBounds = true

  collideCallback: (soldier, object)=>  
    console.log soldier
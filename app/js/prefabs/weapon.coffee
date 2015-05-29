class Prefab.Weapon extends Phaser.Group
  fireTime: 0
  fireDelay: 200
  maxBulletsSize: 10

  charge: (type)->
    for i in [0...@.maxBulletsSize]
      @.add(new Prefab.Bullet(@game, type), true)    

  fire: (owner)->
    return if @game.time.now < @fireTime
    console.log 'fire weapon'

    @.getFirstExists(false)?.fire(owner.x, owner.y, owner.angle, 500)

    @fireTime = @game.time.now + @fireDelay
    
class Prefab.Bullet extends Phaser.Sprite
  constructor: (game, key)->
    super(game, 0, 0, key)

    @id = Math.round(Math.random(10000000) * 10000000)

    @texture.baseTexture.scaleMode = PIXI.scaleModes.NEAREST

    @anchor.set(0.5)

    @checkWorldBounds = true
    @outOfBoundsKill = true
    @exists = false

    @events.onKilled.add(@.onKilled, @)

  fire: (x, y, angle, speed)->  
    console.log 'fire bullet'

    @reset(x, y)
    @scale.set(1)

    @game.physics.arcade.velocityFromAngle(angle, speed, @body.velocity)

    @angle = angle

  onKilled: (e)->
    console.log "killed #{@id} button"
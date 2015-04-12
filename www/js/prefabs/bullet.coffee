class Prefabs.Bullet extends Phaser.Sprite
  constructor: (game, key)->
    super(game, 0, 0, key)

    @texture.baseTexture.scaleMode = PIXI.scaleModes.NEAREST

    @anchor.set(0.5)

    @checkWorldBounds = true
    @outOfBoundsKill = true
    @exists = false

    @tracking = false
    @scaleSpeed = 0

  fire: (x, y, angle, speed, gx, gy)->  
    gx = gx || 0;
    gy = gy || 0;

    @reset(x, y)
    @scale.set(1)

    @game.physics.arcade.velocityFromAngle(angle, speed, this.body.velocity)

    @angle = angle

    @body.gravity.set(gx, gy) # под сомнением

  update: ->
    if @tracking
      @rotation = Math.atan2(@body.velocity.y, @body.velocity.x) # под сомнением

    if @scaleSpeed > 0
      @scale.x += @scaleSpeed
      @scale.y += @scaleSpeed

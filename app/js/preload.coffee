#Parse = require 'Parse'
Phaser = require 'Phaser'

config = require './config.coffee'

class Preload extends Phaser.State
  constructor: -> super

  preload: ->
    # # Show loading screen
    # @load.setPreloadSprite @add.sprite @game.world.centerX - 160, @game.world.centerY - 16, 'preloadBar'

    # # Initialize Parse
    # Parse.initialize '[Application ID]', '[JavaScript Key]'
    # Parse.Analytics.track 'load', {
    #   language: window.navigator.language,
    #   platform: window.navigator.platform
    # }

    # # Set up game defaults
    # @stage.backgroundColor = 'black'

    # # Load game assets
    # @load.pack 'main', config.pack

    @game.load.tilemap('main', 'assets/maps/main.json', null, Phaser.Tilemap.TILED_JSON)  
    @game.load.image('tiles', 'assets/images/gridtiles.png')
    @game.load.image('point_32', 'assets/images/point_32.png')

    @game.load.atlasJSONHash('soldiers', 'assets/images/soldiers.png', 'assets/soldiers.json')

  create: ->
    @state.start 'Game'

module.exports = Preload
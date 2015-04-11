class Game
  constructor: ->
    @.bindEvents()

  bindEvents: ->
    document.addEventListener('deviceready', @.onDeviceReady, false)

  onDeviceReady: =>
    @.receivedEvent('deviceready')

    @.run()

  run: ->
    @phaserGame = new Phaser.Game(640, 480, Phaser.CANVAS, 'game')

    @phaserGame.state.add('Main_Scene', Scenes.Main, true)


  receivedEvent: (id)->
    console.log('Received Event: ' + id)


new Game()


    
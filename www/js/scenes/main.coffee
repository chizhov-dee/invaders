class Scenes.Main extends Phaser.State
  constructor: (game)->

  preload: ->
    @game.load.tilemap('main', 'maps/main.json', null, Phaser.Tilemap.TILED_JSON)  

    @game.load.image('tiles', 'img/gridtiles.png')

  create: ->
    map = @add.tilemap('main')

    map.addTilesetImage('gridtiles', 'tiles')

    console.log layer = map.createLayer('FirstLayer')

    layer.resizeWorld()

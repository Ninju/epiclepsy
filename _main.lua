local menu = {
  title = "",
  buttonMargin = 0,
  group = display.newGroup(),
  addButton = function( text, options )
    
  end,

}

menu.title = "EpicLepsy"

menu.addButton( "Play", { scene = game } )
menu.addButton( "Help", { scene = help } )
menu.addButton( "Instructions", { scene = instructions } )

menu.titlePosition.x = display.stageWidth / 2
menu.titlePosition.y = 100

menu.buttonsStartAt.y = 200
menu.buttonsStartAt.x = display.stageWidth / 2
menu.buttonMargin = 40

menu.buttonStyle = function()
  return display.newRoundedRect( 0, 0, display.stageWidth / 3, 20 )
end


menu:draw()

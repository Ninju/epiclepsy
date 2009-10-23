menu = display.newGroup()
game = display.newGroup()
instructions = display.newGroup()

-- Utilities
local selectScene = function( scene )
  local scenes = { menu, game, instructions }
  for i = 1, #scenes do
    scenes[ i ].isVisible = scenes[ i ] == scene
  end
end

local createButton = function( options )
  local newButton = display.newRoundedRect( 0, 0, options.width, options.height, options.height / 3 )
  newButton.x = options.x
  newButton.y = options.y
  newButton:setFillColor( 30, 30, 200 )

  buttonText = display.newText( options.text, 0, 0, nil, options.height / 2 )
  buttonText.x = options.x
  buttonText.y = options.y
  buttonText:setTextColor( 255, 255, 255 )

  return newButton, buttonText
end
-- End Utilities

-- Menu Setup
menu.title = display.newText( "Epic Lepsy", 0, 0, nil, 30 )
menu.title.x = display.stageWidth / 2
menu.title.y = 100
menu.title:setTextColor( 255, 255, 255 )

menu.createButton = function( self, text, callback )
  local newButton, buttonText = createButton{
    x = display.stageWidth / 2,
    y = 200 + ( self.numChildren - 1 ) * 30,
    text = text,
    width = 150,
    height = 30
  }

  self:insert( newButton )
  self:insert( buttonText )

  newButton:addEventListener( "tap", callback )
end

local menuSelectSceneCallback = function( scene )
  return( function()
    selectScene( scene )
  end )
end

menu:insert( menu.title )
menu:createButton( "Play", menuSelectSceneCallback( game ) )
menu:createButton( "Instructions", menuSelectSceneCallback( instructions ) )
menu:createButton( "Options", function() end )
-- End Menu Setup

-- Instructions setup
instructions.title = display.newText( "Instructions", 0, 0, nil, 30 )
instructions.title.x = display.stageWidth / 2
instructions.title.y = 50
instructions.title:setTextColor( 255, 255, 255 )

instructions.text = display.newText( "try not to have a seizure", 0, 0, nil, 15 )
instructions.text.x = display.stageWidth / 2
instructions.text.y = 100
instructions.text:setTextColor( 255, 255, 255 )

instructions.backButton, instructions.backButtonText = createButton{
  text = "Back",
  x = display.stageWidth - 45,
  y = display.stageHeight - 30,
  width = 50,
  height = 20
} 

instructions.backButton:addEventListener( "tap", menuSelectSceneCallback( menu ) )

instructions:insert( instructions.title )
instructions:insert( instructions.text )
instructions:insert( instructions.backButton )
instructions:insert( instructions.backButtonText )
-- End instructions


-- Game Setup
local background = display.newRect( 0, 0, display.stageWidth, display.stageHeight )
background.flashRate = 1000
background.isWhite = true
background.colorLastChanged = nil

background.colorLastChangedAt = function( self )
  return self.colorLastChanged or system.getTimer()
end

background.flash = function( self )
  if self.isWhite then
    self:setFillColor( 0, 0, 0 )
  else
    self:setFillColor( 255, 255, 255 )
  end

  self.isWhite = not self.isWhite
  self.colorLastChanged = system.getTimer()
end

timer.performWithDelay( 1000, function() background:flash() end, 0 )
game:insert( background )
-- End

Runtime:addEventListener( "system", function( event )
  if event.type == "applicationStart" then
    selectScene( menu )
  end
end )


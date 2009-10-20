menu = display.newGroup()
game = display.newGroup()
instructions = display.newGroup()

-- Utilities
local scenes = { menu, game, instructions }

local selectScene = function( scene )
  for i = 1, #scenes do
    scenes[ i ].isVisible = scenes[ i ] == scene
  end
end
-- end Utilities

-- Menu Setup
menu.title = display.newText( "Epic Lepsy", 0, 0, nil, 30 )
menu.title.x = display.stageWidth / 2
menu.title.y = 100
menu.title:setTextColor( 255, 255, 255 )

menu.createButton = function( self, text, callback )
  local newButton = display.newRoundedRect( 0, 0, 150, 30, 10 )
  local buttonText = display.newText( text, 0, 0, nil, 15 )
  
  newButton:setFillColor( 200, 200, 200 )
  buttonText:setTextColor( 0, 0, 0 )

  buttonText.x = display.stageWidth / 2
  buttonText.y = 200 + ( self.numChildren - 1 ) * 30

  newButton.x = display.stageWidth / 2
  newButton.y = 200 + ( self.numChildren - 1 ) * 30

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
local instructionsTitle = display.newText( "Instructions", 0, 0, nil, 30 )
instructionsTitle.x = display.stageWidth / 2
instructionsTitle.y = 50
instructionsTitle:setTextColor( 255, 255, 255 )

local instructionsText = display.newText( "try not to have a seizure", 0, 0, nil, 15 )
instructionsText.x = display.stageWidth / 2
instructionsText.y = 100
instructionsText:setTextColor( 255, 255, 255 )

local backButton = display.newRoundedRect( 0, 0, 50, 20, 5 )
backButton.x = display.stageWidth - 45
backButton.y = display.stageHeight - 30
backButton:setFillColor( 255, 255, 255 )

local backButtonText = display.newText( "Back", 0, 0, nil, 15 )
backButtonText.x = display.stageWidth - 45
backButtonText.y = display.stageHeight - 30
backButtonText:setTextColor( 0, 0, 0 )

backButton:addEventListener( "tap", menuSelectSceneCallback( menu ) )

instructions:insert( instructionsTitle )
instructions:insert( instructionsText )
instructions:insert( backButton )
instructions:insert( backButtonText )
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


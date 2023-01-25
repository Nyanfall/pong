local pd <const> = playdate
local gfx <const> = pd.graphics

import "gameScene"
import "menuScene"

class('GameResultScene').extends(gfx.sprite)

function GameResultScene:init()
    local text = "Game Over"
    local gameResultImage = gfx.image.new(gfx.getTextSize(text))

    gfx.pushContext(gameResultImage)
    gfx.drawText(text,0,0)
    gfx.popContext()
    local gameResultSprite = gfx.sprite.new(gameResultImage)
    gameResultSprite:moveTo(200, 120)
    gameResultSprite:add()

    self:add()
end

function GameResultScene:update()
    if pd.buttonJustPressed(pd.kButtonA) then
        SCENE_MANAGER:switchScene(GameScene)
    end
    
end
local pd <const> = playdate
local gfx <const> = playdate.graphics

import "gameScene"

class('MenuScene').extends(gfx.sprite)

menuPoints = {78,78, 148,118, 228,158} -- 1,2,3,4,5,6
selectorPos = 0

function MenuScene:init ()

    local selectorImage = gfx.image.new("images/jj")
    selectorPos = 1
    selectorSprite = gfx.sprite.new(selectorImage)
    selectorSprite:moveTo(menuPoints[selectorPos], menuPoints[selectorPos + 1])
    selectorSprite:add()
    
    local waterMarkText = "_Created by @Nyanfall _"
    local waterMarkImage = gfx.image.new(gfx.getTextSize(waterMarkText))
    gfx.pushContext(waterMarkImage)
    gfx.drawText(waterMarkText,0,0)

    local campaignText = "*Campaign*"
    local campaignImage = gfx.image.new(gfx.getTextSize(campaignText))
    gfx.pushContext(campaignImage)
    gfx.drawText(campaignText,0,0)

    local singleGameText = "*Single Game*"
    local singleGameImage = gfx.image.new(gfx.getTextSize(singleGameText))
    gfx.pushContext(singleGameImage)
    gfx.drawText(singleGameText,0,0)

    local howToPlayText = "*How to play*"
    local howToPlayImage = gfx.image.new(gfx.getTextSize(singleGameText))
    gfx.pushContext(howToPlayImage)
    gfx.drawText(howToPlayText,0,0)

    gfx.popContext()

    local waterMarkSprite = gfx.sprite.new(waterMarkImage)
    waterMarkSprite:moveTo(80, 230)
    waterMarkSprite:add()

    local campaignSprite = gfx.sprite.new(campaignImage)
    campaignSprite:moveTo(120, 80)
    campaignSprite:add()

    local singleGameSprite = gfx.sprite.new(singleGameImage)
    singleGameSprite:moveTo(200, 120)
    singleGameSprite:add()

    local howToPlaySprite = gfx.sprite.new(howToPlayImage)
    howToPlaySprite:moveTo(280, 160)
    howToPlaySprite:add()

    self:add()
end

function MenuScene:update ()
    if pd.buttonJustPressed(pd.kButtonA) then
        if selectorPos == 1 or selectorPos == 2 then 
            SCENE_MANAGER:switchScene(GameScene)
        else
            SCENE_MANAGER:switchScene(GameScene)
        end
    end
    if pd.buttonJustPressed(pd.kButtonDown) or pd.buttonJustPressed(pd.kButtonRight) then
        if selectorPos == 1 or selectorPos == 2 then
            if selectorPos == 2 then 
                selectorSprite:moveTo(menuPoints[5], menuPoints[6])
            else 
                selectorSprite:moveTo(menuPoints[3], menuPoints[4])
            end
            selectorPos += 1
            selectorSprite:add()
        else 
            selectorPos -= 2
            selectorSprite:moveTo(menuPoints[1], menuPoints[2])
            selectorSprite:add()
        end
    end
    if pd.buttonJustPressed(pd.kButtonUp) or pd.buttonJustPressed(pd.kButtonLeft) then
        if selectorPos == 2 or selectorPos == 3 then
            if selectorPos == 3 then 
                selectorSprite:moveTo(menuPoints[3], menuPoints[4])
            else 
                selectorSprite:moveTo(menuPoints[1], menuPoints[2])
            end 
            selectorSprite:add()
            selectorPos -= 1     
        else 
            selectorSprite:moveTo(menuPoints[5], menuPoints[6])
            selectorSprite:add()
            selectorPos += 2
        end
    end
end
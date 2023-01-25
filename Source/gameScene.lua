import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

import "gameResultScene"
import "menuScene"

local pd <const> = playdate
local gfx <const> = pd.graphics

local playerSprite = nil
local playerSpeed = 4
local playTimer = nil
local playTime = 30 * 1000
local coinSprite = nil
local score = 0

class("GameScene").extends(gfx.sprite)

function resetTimer()
	playTimer = pd.timer.new(playTime, playTime, 0, pd.easingFunctions.linear)
end

function moveCoin()
	local randX = math.random(40, 360)
	local randY = math.random(40, 200)
	coinSprite:moveTo(randX, randY)
end

function GameScene:init()
	math.randomseed(pd.getSecondsSinceEpoch())
	local playerImage = gfx.image.new("images/jj")
	playerSprite = gfx.sprite.new(playerImage)
	playerSprite:moveTo(200, 120)
	playerSprite:setCollideRect(0, 0, playerSprite:getSize())
	playerSprite:add()

	local coinImage = gfx.image.new("images/hh")
	coinSprite = gfx.sprite.new(coinImage)
	moveCoin()
	coinSprite:setCollideRect(0, 0, coinSprite:getSize())
	coinSprite:add()

	local backgroundImage = gfx.image.new("images/pool-base")
	gfx.sprite.setBackgroundDrawingCallback(
		function(x, y, width, height)
			gfx.setClipRect(x, y, width, height)
			backgroundImage:draw(7, 26)
			gfx.clearClipRect()
		end
	)
	resetTimer()
end

function GameScene:update()
	if playTimer.value == 0 then
		if pd.buttonIsPressed(pd.kButtonA) then
			resetTimer()
			moveCoin()
			score = 0
            SCENE_MANAGER:switchScene(GameResultScene)
		end
	else
        if pd.buttonJustPressed(pd.kButtonA) then
            SCENE_MANAGER:switchScene(GameResultScene)
        end
		if pd.buttonIsPressed(pd.kButtonUp) then
			playerSprite:moveBy(0, -playerSpeed)
		end
		if pd.buttonIsPressed(pd.kButtonDown) then
			playerSprite:moveBy(0, playerSpeed)
		end
		if pd.buttonIsPressed(pd.kButtonRight) then
			playerSprite:moveBy(playerSpeed, 0)
		end
		if pd.buttonIsPressed(pd.kButtonLeft) then
			playerSprite:moveBy(-playerSpeed, 0)
		end
		local collisions = coinSprite:overlappingSprites()
		if #collisions  >= 1 then
			moveCoin()
			score += 1
		end
	end

	pd.timer.updateTimers()

	gfx.sprite.update()

	gfx.drawText("time: " .. math.ceil(playTimer.value / 1000), 5, 5)
	gfx.drawText("score: " .. score, 320, 5)
end

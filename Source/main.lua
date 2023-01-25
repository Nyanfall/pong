import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

import "sceneManager"
import "gameScene"
import "gameResultScene"


local pd <const> = playdate
local gfx <const> = playdate.graphics

SCENE_MANAGER = SceneManager()
MenuScene()

function pd.update()
	pd.timer.updateTimers()
	gfx.sprite.update()
end

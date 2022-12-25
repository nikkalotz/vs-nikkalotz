-- Lua stuff
local squish = 50
function onCreate()
    makeLuaSprite('roblox', 'bg/roblox', -350, 50)
	scaleObject('roblox', 1.2, 1.2)
	makeLuaSprite('rhud', 'bg/robloxhud', -400, 900)
	scaleObject('rhud', 1.2, 1.2)
	setScrollFactor('rhud', 1.2, 1);
	
    addLuaSprite('roblox',  false)
    addLuaSprite('rhud',  true)
end
function onCreate()
	makeLuaSprite('backyard', 'bg/backyard', 0, 0);
	setLuaSpriteScrollFactor('backyard', 1, 1);
	scaleObject('backyard', 1, 1)
	addLuaSprite('backyard', false);
	close(true); 
end
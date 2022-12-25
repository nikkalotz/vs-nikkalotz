function onCreate()
	makeLuaSprite('backyard', 'bg/plush', -600, -300);
	setLuaSpriteScrollFactor('backyard', 1, 1);
	scaleObject('backyard', 2.2, 2.2)
    setProperty('backyard.antialiasing', false);
	addLuaSprite('backyard', false);
	close(true); 
end
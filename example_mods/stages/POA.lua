function onCreate()
    makeLuaSprite('fg', 'bg/NKground', -600, 300)
	scaleObject('fg', 1.2, 1.2)
	
    makeLuaSprite('tre', 'bg/NKtree', 140, 10)
	scaleObject('tre', 1.2, 1.2)
	
	makeLuaSprite('sky', 'bg/NKsky', -520, -200)
	scaleObject('sky', 1.2, 1.2)
	setScrollFactor('sky', 0.9, 0.9);
	
	makeLuaSprite('city', 'bg/NKcity', -620, 20)
	scaleObject('city', 0.7, 0.7)
	setScrollFactor('city', 0.7, 0.7);
	
	makeLuaSprite('fnfp', 'bg/pixels', -400, 100)
	scaleObject('fnfp', 7, 7)
	setScrollFactor('fnfp', 1, 1);
	setProperty('fnfp.antialiasing', false);
	setProperty('fnfp.alpha', 1);
	
	makeAnimatedLuaSprite('speaker', 'characters/byron_speaker', 570, 750);
	addAnimationByPrefix('speaker', 'bop', 'byron instance 1', 24, false);
	setScrollFactor('speaker', 1, 1);
	scaleObject('speaker', 1, 1);

    addLuaSprite('sky',  false)
	addLuaSprite('city',  false)
    addLuaSprite('fg',  false)
    addLuaSprite('tre',  false)
	addLuaSprite('speaker',  false)
	addLuaSprite('fnfp',  false)
end

function onBeatHit()
	if curBeat % 1 == 0 then
		objectPlayAnimation('speaker', 'bop', true);
	end
end

function onEvent(name, value1, value2)
	if name == 'bgchange' then
		setProperty('fnfp.alpha', 0.000001);
	end
end
	
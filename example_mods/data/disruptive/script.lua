-- trail script by Shadow Mario
timerStartedDad = false;

trailLength = 5;
trailDelay = 0.05;
curTrailDad = 0;

function onCreate()
    setProperty('skipCountdown', true)
	runTimer('timerTrailDad', trailDelay, 0);
	curTrailDad = 0;
end

function onUpdate(elapsed)
	doTweenY('opponentmove', 'dad', 60*math.sin(getSongPosition()/400), 0.05)
	
	if mustHitSection == true then
		setProperty("defaultCamZoom", 0.8)
		triggerEvent('Camera Follow Pos', '939', '579');
	end
	if mustHitSection == false then
		setProperty("defaultCamZoom", 0.7)
		triggerEvent('Camera Follow Pos', '362', '376');
	end
end

function onTimerCompleted(tag, loops, loopsLeft)
	num = curTrailDad;
	curTrailDad = curTrailDad + 1;
	color = getColorFromHex('080808');
	image = getProperty('dad.imageFile')
	frame = getProperty('dad.animation.frameName');
	x = getProperty('dad.x');
	y = getProperty('dad.y');
	scaleX = 1.3;
	scaleY = 1.3;
	offsetX = getProperty('dad.offset.x');
	offsetY = getProperty('dad.offset.y');

	if num - trailLength + 1 >= 0 then
		for i = (num - trailLength + 1), (num - 1) do
			setProperty('psychicTrailDad'..i..'.alpha', getProperty('psychicTrailDad'..i..'.alpha') - (0.6 / (trailLength - 1)));
		end
	end
	removeLuaSprite('psychicTrailDad'..(num - trailLength));

	if not (image == '') then
		makeAnimatedLuaSprite('psychicTrailDad'..num, image, x, y);
		setProperty('psychicTrailDad'..num..'.offset.x', offsetX);
		setProperty('psychicTrailDad'..num..'.offset.y', offsetY);
		setProperty('psychicTrailDad'..num..'.scale.x', scaleX);
		setProperty('psychicTrailDad'..num..'.scale.y', scaleY);
		setProperty('psychicTrailDad'..num..'.flipX', flipX);
		setProperty('psychicTrailDad'..num..'.alpha', 0.6);
		setProperty('psychicTrailDad'..num..'.color', color);
		setProperty('psychicTrailDad'..num..'.blend', add);
		addAnimationByPrefix('psychicTrailDad'..num, 'stuff', frame, 0, false);
		addLuaSprite('psychicTrailDad'..num, false);
	end
end
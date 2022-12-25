trailEnabledDad = false;
trailEnabledBF = false;
trailEnabledGF = false;
timerStartedDad = false;
timerStartedBF = false;
timerStartedGF = false;

trailLength = 5;
trailDelay = 0.05;

function onEvent(name, value1, value2)
	if name == "Toggle Trail" then
		if not (value1 == nil or value1 == '') and tonumber(value1) > 0 then
			if not timerStartedDad then
				runTimer('timerTrailDad', trailDelay, 0);
				timerStartedDad = true;
				runTimer('timerTrailGF', trailDelay, 0);
				timerStartedGF = true;
			end
			trailEnabledDad = true;
			trailEnabledGF = true;
			curTrailDad = 0;
			curTrailGF = 0;
		else
			trailEnabledDad = false;
			trailEnabledGF = false;
		end

		if not (value2 == nil or value2 == '') and tonumber(value2) > 0 then
			if not timerStartedBF then
				runTimer('timerTrailBF', trailDelay, 0);
				timerStartedBF = true;
			end
			trailEnabledBF = true;
			curTrailBF = 0;
		else
			trailEnabledBF = false;
			trailEnabledGF = false;
		end
	end
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'timerTrailDad' then
		createTrailFrame('Dad');
	end
	
	if tag == 'timerTrailGF' then
		createTrailFrame('GF');
	end

	if tag == 'timerTrailBF' then
		createTrailFrame('BF');
	end
end

curTrailDad = 0;
curTrailBF = 0;
curTrailGF = 0;
function createTrailFrame(tag)
	num = 0;
	color = -1;
	image = '';
	frame = 'BF idle dance';
	x = 0;
	y = 0;
	scaleX = 0;
	scaleY = 0;
	offsetX = 0;
	offsetY = 0;
	flipX = false;

	if tag == 'BF' then
		num = curTrailBF;
		curTrailBF = curTrailBF + 1;
		if trailEnabledBF then
			image = getProperty('boyfriend.imageFile')
			frame = getProperty('boyfriend.animation.frameName');
			x = getProperty('boyfriend.x');
			y = getProperty('boyfriend.y');
			scaleX = getProperty('boyfriend.scale.x'); 
			scaleY = getProperty('boyfriend.scale.y'); 
			offsetX = getProperty('boyfriend.offset.x');
			offsetY = getProperty('boyfriend.offset.y');
			flipX = getProperty('boyfriend.flipX')
		end
	elseif tag == 'GF' then
		num = curTrailGF;
		curTrailGF = curTrailGF + 1;
		if trailEnabledGF then
			image = getProperty('gf.imageFile')
			frame = getProperty('gf.animation.frameName');
			x = getProperty('gf.x');
			y = getProperty('gf.y');
			scaleX = getProperty('gf.scale.x'); 
			scaleY = getProperty('gf.scale.y'); 
			offsetX = getProperty('gf.offset.x');
			offsetY = getProperty('gf.offset.y');
			flipX = getProperty('gf.flipX')
		end
	else
		num = curTrailDad;
		curTrailDad = curTrailDad + 1;
		if trailEnabledDad then
			image = getProperty('dad.imageFile')
			frame = getProperty('dad.animation.frameName');
			x = getProperty('dad.x');
			y = getProperty('dad.y');
			scaleX = getProperty('dad.scale.x');
			scaleY = getProperty('dad.scale.y');
			offsetX = getProperty('dad.offset.x');
			offsetY = getProperty('dad.offset.y');
			flipX = getProperty('dad.flipX')
		end
	end

	if num - trailLength + 1 >= 0 then
		for i = (num - trailLength + 1), (num - 1) do
			setProperty('psychicTrail'..tag..i..'.alpha', getProperty('psychicTrail'..tag..i..'.alpha') - (0.6 / (trailLength - 1)));
		end
	end
	removeLuaSprite('psychicTrail'..tag..(num - trailLength));

	if not (image == '') then
		trailTag = 'psychicTrail'..tag..num;
		makeAnimatedLuaSprite(trailTag, image, x, y);
		setProperty(trailTag..'.offset.x', offsetX);
		setProperty(trailTag..'.offset.y', offsetY);
		setProperty(trailTag..'.scale.x', scaleX);
		setProperty(trailTag..'.scale.y', scaleY);
		setProperty(trailTag..'.flipX', flipX);
		setProperty(trailTag..'.alpha', 0.6);
		setProperty(trailTag..'.color', color);
		setBlendMode(trailTag, 'add');
		addAnimationByPrefix(trailTag, 'stuff', frame, 0, false);
		addLuaSprite(trailTag, false);
	end
end
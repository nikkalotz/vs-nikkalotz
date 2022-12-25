local moveOutTime = 3.7
function onCreatePost()

	if boyfriendName == 'dave' then
		setPropertyFromClass('GameOverSubstate', 'characterName', 'dave-dead');
		setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'daveDies');
	elseif boyfriendName == 'bf' then
		setPropertyFromClass('GameOverSubstate', 'characterName', 'bf-dead');
	elseif boyfriendName == 'oldbf' then
		setPropertyFromClass('GameOverSubstate', 'characterName', 'oldbf');
	elseif boyfriendName == 'playerNikk' then
		setPropertyFromClass('GameOverSubstate', 'characterName', 'nikk-dead');
		setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'nikkDies');
	else
		setPropertyFromClass('GameOverSubstate', 'characterName', 'bfNK-dead');
	end
	
    for i = 0, getProperty('unspawnNotes.length')-1 do 
	    setPropertyFromGroup('unspawnNotes', i, 'texture', 'NOTE_assets');
		setPropertyFromGroup('unspawnNotes', i, 'noteSplashTexture', 'noteSplashes');
    end
	
    authorName = '' .. getTextFromFile('data/authorNames/'..songName..'.txt')
	trueName = '' .. getTextFromFile('data/songNames/'..songName..'.txt')
	
	makeLuaSprite('BG', 'songBG', -550, 470)
	setObjectCamera('BG', 'other')
    addLuaSprite('BG', true)
    setScrollFactor('BG', 0, 0)
	
    makeLuaText('songText', "".. trueName, 380, -470, 500)
    setObjectCamera("songText", 'other');
    setTextColor('songText', '0xffffff')
    setTextSize('songText', 17);
    addLuaText("songText");
    setTextFont('songText', "pixel.otf")
    setTextAlignment('songText', 'left')
	
    makeLuaText('author', "".. authorName, 380, -670, 550)
    setObjectCamera("author", 'other');
    setTextColor('author', '0xffffff')
    setTextSize('author', 17);
    addLuaText("author");
    setTextFont('author', "pixel.otf")
    setTextAlignment('author', 'left')
	
	if songName == 'Reviewer' then
		setTextSize('songText', 14);
		setProperty('songText.y', 495);
	end
	
	setTextFont('timeTxt', "pixel.otf")

	makeLuaText('infobar','',0,0,0)
	setProperty('infobar.y',getProperty('scoreTxt.y'))
	setProperty('infobar.x',getProperty('scoreTxt.x')+420)
	setTextAlignment('infobar','CENTER')
	setTextSize('infobar', 18)

	if not hideHud then
		addLuaText('infobar');
	end
end

function onSongStart()
        doTweenX('bgTween', 'BG', -50, 1, 'quartIn')
        doTweenX('songTween', 'songText', 50, 1, 'quartIn') 
		doTweenX('creditTween', 'author', 50, 1, 'quartIn')
        runTimer('moveOut', moveOutTime + (stepCrochet * 0.004), 1)
end

function onUpdate(elasped)
	if hits < 1 and misses < 1 then
		setTextString('infobar','Score: 0 - Accuracy: 0% - Misses: 0 - Rank: F')
	else
		setTextString('infobar','Score: '..score..' - Accuracy: '..round(rating * 100, 2)..'% ['..ratingFC..'] - Misses: '..misses..' - Rank: '..ratingName)
		setProperty('infobar.x',getProperty('scoreTxt.x')+360)
	end
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'moveOut' then
        doTweenX('endBGTween', 'BG', -550, 1, 'smoothStepOut')
        doTweenX('endSongTween', 'songText', -370, 1, 'smoothStepOut')
		doTweenX('endCreditTween', 'author', -370, 1, 'smoothStepOut')
    end
end

function onTweenCompleted(tag)
    if tag == 'BGLeave' then
        removeLuaSprite('author', true)
        removeLuaSprite('BG', true)
        removeLuaText('songText', true)
    end
end

function round(x, n)
    n = math.pow(10, n or 0)
    x = x * n
    if x >= 0 then x = math.floor(x + 0.5) else x = math.ceil(x - 0.5) end
    return x / n
end
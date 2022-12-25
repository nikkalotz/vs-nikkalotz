function onEvent(name, value1, value2)
	if name == 'bgchange' then
		setProperty('fnfp.alpha', 0.000001);
	    for i=0,4,1 do
		    setPropertyFromGroup('opponentStrums', i, 'texture', 'NOTE_assets');
		    setPropertyFromGroup('playerStrums', i, 'texture', 'NOTE_assets');
	    end
        for i = 0, getProperty('unspawnNotes.length')-1 do
		    setPropertyFromGroup('unspawnNotes', i, 'texture', 'NOTE_assets');
			setPropertyFromGroup('unspawnNotes', i, 'noteSplashTexture', 'noteSplashes');
        end
	end
end
function onCreate()
	for i = 0, getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Cool Note' then
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'coolNotes');

			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then 
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', false);
			end
		end
	end
end

function noteMiss(id, noteData, noteType, isSustainNote)
	if noteType == 'Cool Note' then
		setProperty('health', -1);
	end
end
function onCreate()
	for i = 0, getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Uncool Note' then
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'UncoolNotes');

			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then 
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', true);
			end
		end
	end
end

function goodNoteHit(id, noteData, noteType, isSustainNote)
	if noteType == 'Uncool Note' then
		setProperty('health', -1);
	end
end
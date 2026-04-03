function onCreatePost()
    for i = 0, 3 do
        setPropertyFromGroup('playerStrums', i, 'x', 412 + (i * 112))
    end

    for i = 0, 3 do
        setPropertyFromGroup('opponentStrums', i, 'x', -1000)
    end
end
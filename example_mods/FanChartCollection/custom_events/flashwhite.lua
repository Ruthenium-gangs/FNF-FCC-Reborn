function onCreatePost()
    makeLuaSprite('flas','',-5000,-5000)
    makeGraphic('flas',screenWidth,screenHeight,'FFFFFF')
    setObjectCamera('flas','camHUD')
    scaleObject('flas',50,40)
    setBlendMode('flas','ADD')
    setProperty('flas.alpha',0)
    addLuaSprite('flas', false);
    --setObjectOrder('flas',90)

    makeLuaSprite('F-C', 'F-C', 0, 0);
    setScrollFactor('F-C', 0, 0);
    setProperty('F-C.alpha', 0.001);
    setObjectCamera('F-C', 'camHUD');
    addLuaSprite('F-C', true);
    setBlendMode('F-C','ADD')
end

function onEvent(n,v1,v2)
    if n == 'flashwhite' then
        setProperty('flas.alpha',1)
        doTweenAlpha('flastt','flas',0,0.7,'linear')
    end
    if n == 'flashwhite50' then
        setProperty('flas.alpha',0.3)
        doTweenAlpha('flasttt','flas',0,0.3,'linear')
    end
    if n == 'flashwhite-C' then
        setProperty('F-C.alpha',1)
        doTweenAlpha('flastttt','F-C',0,0.3,'linear')
    end
end
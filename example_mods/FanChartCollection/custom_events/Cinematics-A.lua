--Created by RamenDominoes (Please credit if using this, thanks! <3)

function onCreatePost()

    makeLuaSprite('UpperBar-A', 'empty', -210, -690)
	makeGraphic('UpperBar-A', 1500, 350, '000000')
	setObjectCamera('UpperBar-A', 'HUD')
	setProperty('UpperBar-A.angle',-5)
	addLuaSprite('UpperBar-A', false)

    makeLuaSprite('LowerBar-A', 'empty', -10, 1060)
	makeGraphic('LowerBar-A', 1500, 350, '000000')
	setObjectCamera('LowerBar-A', 'HUD')
	setProperty('LowerBar-A.angle',-5)
	addLuaSprite('LowerBar-A', false)

    UpperBar = getProperty('UpperBar-A.y')
	LowerBar = getProperty('LowerBar-A.y')
end

function onEvent(n, v1, v2)
	
	if n == 'Cinematics-A' then
if v1 == 'on' then
doTweenY('UpperBarA','UpperBar-A',-275,v2,'QuadOut')
doTweenY('LowerBarA','LowerBar-A',645,v2,'QuadOut')
end
if v1 == 'beat' then
    setProperty('UpperBar-A.y',-255)
    setProperty('LowerBar-A.y',625)
doTweenY('UpperBarA','UpperBar-A',-275,0.2,'QuadOut')
doTweenY('LowerBarA','LowerBar-A',645,0.2,'QuadOut')
end
if v1 == 'off' then
doTweenY('UpperBarA','UpperBar-A',-690,v2,'QuadIn')
doTweenY('LowerBarA','LowerBar-A',1060,v2,'QuadIn')
end
	end
end

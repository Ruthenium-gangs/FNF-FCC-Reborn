function onCreate()
	-- background shit
    makeLuaSprite('bg', 'stages/abeyan/000', -950,-550)
    setLuaSpriteScrollFactor('b', 0.9, 0.9); 
    addLuaSprite('bg')
	scaleObject('bg', 1.5,1.5);
    setScrollFactor('bg', 0, 0);

    makeLuaSprite('b', 'stages/abeyan/001', -950,-550)
    setLuaSpriteScrollFactor('b', 0.9, 0.9); 
    addLuaSprite('b')
	scaleObject('b', 1.5,1.5);
    setScrollFactor('b', 0, 0);

    makeLuaSprite('gg', 'stages/abeyan/light', -700, -100)
    setLuaSpriteScrollFactor('gg', 0.9, 0.9); 
    addLuaSprite('gg', true)
	scaleObject('gg', 6, 0.6);
    setScrollFactor('gg', 0, 0);

    makeLuaSprite('gg2', 'stages/abeyan/light2', -700, -600)
    setLuaSpriteScrollFactor('gg2', 0.9, 0.9); 
    addLuaSprite('gg2', true)
	scaleObject('gg2', 6, 0.6);
    setScrollFactor('gg2', 0, 0);


end


local shadname = "WavyBackgrounds"

function onCreatePost()
	initLuaShader("WavyBackgrounds")
    setSpriteShader('b', shadname)
    setSpriteShader('bg', shadname)
end
	
function onUpdate(elapsed)
    setShaderFloat('b', 'uWaveAmplitude', 0.1)
	setShaderFloat('b', 'uFrequency', -41)
	setShaderFloat('b', 'uSpeed', 0.2)
    setShaderFloat('bg', 'uWaveAmplitude', 0.1)
	setShaderFloat('bg', 'uFrequency', 44)
	setShaderFloat('bg', 'uSpeed', 0.5)   
end

function onUpdatePost(elapsed)
	setShaderFloat('b', 'uTime', os.clock())
	setShaderFloat('bg', 'uTime', os.clock())
end




